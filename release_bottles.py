#!/usr/bin/env python3
"""Script to create Github releases of our bottles."""

import hashlib
import io
import json
import logging
import os
import re
import pkgutil
import subprocess
import sys
import tarfile

from third_party.python import colorlog, requests
from third_party.python.absl import app, flags

logging.root.handlers[0].setFormatter(colorlog.ColoredFormatter('%(log_color)s%(levelname)s: %(message)s'))

flags.DEFINE_string('github_token', None, 'Github API token')
flags.DEFINE_bool('dry_run', False, "Don't actually do the release, just print it.")
flags.DEFINE_string('version', None, 'Version to release (default is current)')
flags.mark_flag_as_required('github_token')
FLAGS = flags.FLAGS


class BottleUploader:

    def __init__(self, github_token:str, dry_run:bool=False, version:str=''):
        self.url = 'https://api.github.com'
        self.please_url = self.url + '/repos/thought-machine/please/releases/latest'
        self.releases_url = self.url + '/repos/thought-machine/homebrew-please/releases'
        self.upload_url = self.releases_url.replace('api.', 'uploads.') + '/<id>/assets?name='
        self.download_url = 'https://github.com/thought-machine/please/releases/download/v%s/please_%s_%s.tar.gz'
        self.session = requests.Session()
        self.session.verify = '/etc/ssl/certs/ca-certificates.crt'
        self.version = version or self.determine_version()
        logging.info('Releasing version %s', self.version)
        self.is_prerelease = 'a' in self.version or 'b' in self.version
        self.formula = self._extract_formula()
        self.original_formula = self.formula
        if not dry_run:
            self.session.headers.update({
                'Accept': 'application/vnd.github.v3+json',
                'Authorization': 'token ' + github_token,
            })

    def needs_release(self):
        """Returns true if the current version is not yet released to Github."""
        url = self.releases_url + '/tags/v' + self.version
        logging.info('Checking %s for release...', url)
        response = self.session.get(url)
        return response.status_code == 404

    def release(self):
        """Submits a new release to Github."""
        data = {
            'tag_name': 'v' + self.version,
            'target_commitish': os.environ.get('CIRCLE_SHA1'),
            'name': 'Please bottles for v' + self.version,
            'body': 'Homebrew bottles (pre-built releases) for Please v' + self.version,
            'prerelease': self.is_prerelease,
        }
        if FLAGS.dry_run:
            logging.info('Would post the following to Github: %s', json.dumps(data, indent=4))
            return
        logging.info('Creating release: %s',  json.dumps(data, indent=4))
        response = self.session.post(self.releases_url, json=data)
        response.raise_for_status()
        data = response.json()
        self.upload_url = data['upload_url'].replace('{?name,label}', '?name=')
        logging.info('Release id %s created', data['id'])

    def upload(self, from_arch:str, to_arch:str):
        """Uploads the given artifact to the new release."""
        filename = 'please-%s.%s.bottle.tar.gz' % (self.version, to_arch)
        url = self.upload_url + filename
        repacked, h = self._repack(self.download_url % (self.version, self.version, from_arch))
        self._update_formula(to_arch, h)
        if FLAGS.dry_run:
            logging.info('Would upload to %s', url)
            return
        logging.info('Uploading %s to %s', filename, url)
        response = self.session.post(url, data=repacked,
                                     headers={'Content-Type': 'application/gzip'})
        response.raise_for_status()
        logging.info('%s uploaded', filename)

    def _repack(self, download_url:str):
        """Repacks a downloaded tarball into the paths Brew expects."""
        # Not sure if there is a better way of doing this that doesn't involve buffering the
        # whole lot into memory? We should really be able to stream it from one to the other...
        logging.info('Downloading %s...', download_url)
        response = self.session.get(download_url, stream=True)
        response.raise_for_status()
        b = io.BytesIO()
        prefix = os.path.join('please', self.version)
        with tarfile.open(fileobj=response.raw) as r, tarfile.open(fileobj=b, mode='w:gz') as w:
            for f in r:
                logging.info('Repacking %s...', f.name)
                f.name = os.path.join(prefix, 'libexec', f.name[len('please/'):])
                w.addfile(f, r.extractfile(f))
            info = tarfile.TarInfo(prefix + '/bin/please')
            info.type = tarfile.SYMTYPE
            info.linkname = '../libexec/please'
            w.addfile(info)
            info = tarfile.TarInfo(prefix + '/bin/plz')
            info.type = tarfile.SYMTYPE
            info.linkname = '../libexec/please'
            w.addfile(info)
            info = tarfile.TarInfo(prefix + 'LICENSE')
            w.addfile(info, io.BytesIO(pkgutil.get_data(__name__, 'LICENSE')))
            info = tarfile.TarInfo(prefix + '.brew/please.rb')
            w.addfile(info, io.StringIO(self.original_formula))
        b.seek(0)  # Rewind the stream so we can read it again.
        h = hashlib.sha256(b.read()).hexdigest()
        b.seek(0)
        return b, h

    def determine_version(self) -> str:
        """Determines the current version of the latest Please release."""
        resp = self.session.get(self.please_url)
        resp.raise_for_status()
        data = resp.json()
        return data['tag_name'].strip('v')

    def _update_formula(self, to_arch:str, digest:str):
        """Updates the Homebrew formula (if it exists) with the given digest."""
        if not os.path.exists('please.rb'):
            logging.warn("Can't find please.rb, will not update")
            return
        self.formula = re.sub(
            fr'sha256 cellar: :any_skip_relocation, {to_arch}\s*:\s*\"[0-9a-f]+\"',
            fr'sha256 cellar: :any_skip_relocation, {to_arch}: "{digest}"',
            self.formula,
        )
        with open('please.rb', 'w') as f:
            f.write(self.formula)

    def _extract_formula(self) -> str:
        """Extracts the formula and updates its version."""
        f = pkgutil.get_data(__name__, 'please.rb').decode('utf-8')
        f = re.sub(r'archive/v[0-9\.]+.tar.gz', f'archive/v{self.version}.tar.gz', f)
        return re.sub(r'releases/download/v[0-9\.]+\"', f'releases/download/v{self.version}"', f)

    def commit(self):
        """Commits changes to the repo & pushes them."""
        subprocess.check_call(['git', 'config', 'user.email', 'the-hogfather@thoughtmachine.net'])
        subprocess.check_call(['git', 'config', 'user.name', 'The Hogfather'])
        subprocess.check_call(['git', 'commit', 'please.rb',
                               '-m', 'Release version ' + self.version])
        subprocess.check_call(['git', 'push', 'origin', 'master'])


def main(argv):
    b = BottleUploader(FLAGS.github_token, dry_run=FLAGS.dry_run, version=FLAGS.version)
    if not b.needs_release():
        logging.info('Current version has already been released, nothing to be done!')
        return
    b.release()
    b.upload('linux_amd64', 'linux_x86_64')
    b.upload('darwin_amd64', 'el_capitan')
    b.upload('darwin_amd64', 'yosemite')
    b.upload('darwin_amd64', 'mojave')
    b.commit()


if __name__ == '__main__':
    app.run(main)
