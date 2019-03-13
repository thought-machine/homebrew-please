#!/usr/bin/env python3
"""Script to create Github releases of our bottles."""

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
flags.mark_flag_as_required('github_token')
FLAGS = flags.FLAGS


class BottleUploader:

    def __init__(self, github_token:str, dry_run:bool=False):
        self.url = 'https://api.github.com'
        self.releases_url = self.url + '/repos/thought-machine/homebrew-please/releases'
        self.upload_url = self.releases_url.replace('api.', 'uploads.') + '/<id>/assets?name='
        self.download_url = 'https://github.com/thought-machine/please/releases/download/v%s/please_%s_%s.tar.gz'
        self.session = requests.Session()
        self.session.verify = '/etc/ssl/certs/ca-certificates.crt'
        self.version = self.determine_version()
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
            'draft': True,
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
        repacked = self._repack(self.download_url % (self.version, self.version, from_arch))
        if FLAGS.dry_run:
            logging.info('Would upload to %s', url)
            return
        logging.info('Uploading %s to %s', filename, url)
        response = self.session.post(url, data=repacked,
                                     headers={'Content-Type': 'application/gzip'})
        response.raise_for_status()
        logging.info('%s uploaded', filename)

    def _repack(self, download_url):
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
            info = tarfile.TarInfo(prefix + 'LICENSE')
            w.addfile(info, io.BytesIO(pkgutil.get_data(__name__, 'LICENSE')))
            info = tarfile.TarInfo(prefix + '.brew/please.rb')
            w.addfile(info, io.BytesIO(pkgutil.get_data(__name__, 'please.rb')))
        b.seek(0)  # Rewind the stream so we can read it again.
        return b

    def determine_version(self) -> str:
        """Determines the current version based on the contents of the Homebrew formula."""
        data = pkgutil.get_data(__name__, 'please.rb')
        m = re.search(
            r'url \"https://github.com/thought-machine/please/archive/v([0-9\.]+).tar.gz\"',
            data.decode('utf-8'),
        )
        if not m:
            logging.fatal('Failed to determine version from Homebrew formula.')
            sys.exit(1)
        logging.info('Determined version to be %s', m.group(1))
        return m.group(1)


def main(argv):
    b = BottleUploader(FLAGS.github_token, dry_run=FLAGS.dry_run)
    if not b.needs_release():
        logging.info('Current version has already been released, nothing to be done!')
        return
    b.release()
    b.upload('linux_amd64', 'linux_x86_64')
    b.upload('darwin_amd64', 'el_capitan')
    b.upload('darwin_amd64', 'yosemite')
    b.upload('darwin_amd64', 'mojave')


if __name__ == '__main__':
    app.run(main)
