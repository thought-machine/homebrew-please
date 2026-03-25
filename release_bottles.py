#!/usr/bin/env python3
"""Script to create Github releases of our bottles."""

import argparse
import hashlib
import io
import json
import logging
import os
import pkgutil
import re
import subprocess
import sys
import tarfile
import urllib.request

log = logging.getLogger(__name__)

# ANSI color codes for log output.
_COLORS = {
    'DEBUG': '\033[36m',     # cyan
    'INFO': '\033[32m',      # green
    'WARNING': '\033[33m',   # yellow
    'ERROR': '\033[31m',     # red
    'CRITICAL': '\033[1;31m', # bold red
}
_RESET = '\033[0m'


class ColorFormatter(logging.Formatter):
    def format(self, record):
        color = _COLORS.get(record.levelname, '')
        return f'{color}{record.levelname}{_RESET}: {record.getMessage()}'


logging.basicConfig(level=logging.INFO)
logging.root.handlers[0].setFormatter(ColorFormatter())


class BottleUploader:

    def __init__(self, github_token:str, dry_run:bool=False, version:str=''):
        self.url = 'https://api.github.com'
        self.please_url = self.url + '/repos/thought-machine/please/releases/latest'
        self.releases_url = self.url + '/repos/thought-machine/homebrew-please/releases'
        self.upload_url = self.releases_url.replace('api.', 'uploads.') + '/<id>/assets?name='
        self.download_url = 'https://github.com/thought-machine/please/releases/download/v%s/please_%s_%s.tar.gz'
        self.github_token = github_token
        self.dry_run = dry_run
        self.version = version or self.determine_version()
        log.info('Releasing version %s', self.version)
        self.is_prerelease = 'a' in self.version or 'b' in self.version
        self.formula = self._extract_formula()
        self.original_formula = self.formula

    def _request(self, url, data=None, headers=None, method=None):
        """Makes an HTTP request with GitHub auth headers."""
        hdrs = {
            'Accept': 'application/vnd.github.v3+json',
        }
        if not self.dry_run:
            hdrs['Authorization'] = 'token ' + self.github_token
        if headers:
            hdrs.update(headers)
        req = urllib.request.Request(url, data=data, headers=hdrs, method=method)
        try:
            resp = urllib.request.urlopen(req)
            return resp.getcode(), resp.read()
        except urllib.error.HTTPError as e:
            return e.code, e.read()

    def _get_json(self, url):
        """GET a URL and return parsed JSON."""
        code, body = self._request(url)
        if code >= 400:
            raise RuntimeError(f'GET {url} returned {code}: {body.decode()}')
        return json.loads(body)

    def needs_release(self):
        """Returns true if the current version is not yet released to Github."""
        url = self.releases_url + '/tags/v' + self.version
        log.info('Checking %s for release...', url)
        code, _ = self._request(url)
        return code == 404

    def release(self):
        """Submits a new release to Github."""
        data = {
            'tag_name': 'v' + self.version,
            'target_commitish': os.environ.get('CIRCLE_SHA1'),
            'name': 'Please bottles for v' + self.version,
            'body': 'Homebrew bottles (pre-built releases) for Please v' + self.version,
            'prerelease': self.is_prerelease,
        }
        if self.dry_run:
            log.info('Would post the following to Github: %s', json.dumps(data, indent=4))
            return
        log.info('Creating release: %s', json.dumps(data, indent=4))
        code, body = self._request(
            self.releases_url,
            data=json.dumps(data).encode(),
            headers={'Content-Type': 'application/json'},
        )
        if code >= 400:
            raise RuntimeError(f'POST {self.releases_url} returned {code}: {body.decode()}')
        resp = json.loads(body)
        self.upload_url = resp['upload_url'].replace('{?name,label}', '?name=')
        log.info('Release id %s created', resp['id'])

    def upload(self, from_arch:str, to_arch:str):
        """Uploads the given artifact to the new release."""
        filename = 'please-%s.%s.bottle.tar.gz' % (self.version, to_arch)
        url = self.upload_url + filename
        repacked, h = self._repack(self.download_url % (self.version, self.version, from_arch))
        self._update_formula(to_arch, h)
        if self.dry_run:
            log.info('Would upload to %s', url)
            return
        log.info('Uploading %s to %s', filename, url)
        code, body = self._request(
            url,
            data=repacked.read(),
            headers={'Content-Type': 'application/gzip'},
        )
        if code >= 400:
            raise RuntimeError(f'POST {url} returned {code}: {body.decode()}')
        log.info('%s uploaded', filename)

    def _repack(self, download_url:str):
        """Repacks a downloaded tarball into the paths Brew expects."""
        log.info('Downloading %s...', download_url)
        resp = urllib.request.urlopen(download_url)
        b = io.BytesIO()
        prefix = os.path.join('please', self.version)
        with tarfile.open(fileobj=resp, mode='r|gz') as r, tarfile.open(fileobj=b, mode='w:gz') as w:
            for f in r:
                log.info('Repacking %s...', f.name)
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
            info = tarfile.TarInfo(prefix + '/bin/build_langserver')
            info.type = tarfile.SYMTYPE
            info.linkname = '../libexec/build_langserver'
            w.addfile(info)
            info = tarfile.TarInfo(prefix + '/bin/please_sandbox')
            info.type = tarfile.SYMTYPE
            info.linkname = '../libexec/please_sandbox'
            w.addfile(info)
            info = tarfile.TarInfo(prefix + '/LICENSE')
            w.addfile(info, io.BytesIO(self._read_resource('LICENSE')))
            info = tarfile.TarInfo(prefix + '/.brew/please.rb')
            w.addfile(info, io.BytesIO(self.original_formula.encode('utf-8')))
        b.seek(0)
        h = hashlib.sha256(b.read()).hexdigest()
        b.seek(0)
        return b, h

    def determine_version(self) -> str:
        """Determines the current version of the latest Please release."""
        data = self._get_json(self.please_url)
        return data['tag_name'].strip('v')

    def _update_formula(self, to_arch:str, digest:str):
        """Updates the Homebrew formula (if it exists) with the given digest."""
        if not os.path.exists('please.rb'):
            log.warning("Can't find please.rb, will not update")
            return
        self.formula = re.sub(
            fr'sha256 cellar: :any_skip_relocation, {to_arch}\s*:\s*\"[0-9a-f]+\"',
            fr'sha256 cellar: :any_skip_relocation, {to_arch}: "{digest}"',
            self.formula,
        )
        with open('please.rb', 'w') as f:
            f.write(self.formula)

    def _hash_remote_file(self, url):
        resp = urllib.request.urlopen(url)
        return hashlib.sha256(resp.read()).hexdigest()

    def _read_resource(self, filename):
        """Read a bundled resource file."""
        script_dir = os.path.dirname(os.path.abspath(__file__))
        path = os.path.join(script_dir, filename)
        if os.path.exists(path):
            with open(path, 'rb') as f:
                return f.read()
        data = pkgutil.get_data(__name__, filename)
        if data is None:
            raise FileNotFoundError(f'Could not find resource: {filename}')
        return data

    def _extract_formula(self) -> str:
        """Extracts the formula and updates its version."""
        h = self._hash_remote_file("https://github.com/thought-machine/please/archive/refs/tags/v%s.tar.gz" % self.version)

        f = self._read_resource('please.rb').decode('utf-8')
        f = re.sub(r'archive/refs/tags/v[0-9\.]+.tar.gz', f'archive/refs/tags/v{self.version}.tar.gz', f)
        f = re.sub(r'sha256 "[0-9a-f]+"', 'sha256 "%s"' % h, f)
        return re.sub(r'releases/download/v[0-9\.]+\"', f'releases/download/v{self.version}"', f)

    def commit(self):
        """Commits changes to the repo & pushes them."""
        subprocess.check_call(['git', 'config', 'user.email', 'the-hogfather@thoughtmachine.net'])
        subprocess.check_call(['git', 'config', 'user.name', 'The Hogfather'])
        subprocess.check_call(['git', 'commit', 'please.rb',
                               '-m', 'Release version ' + self.version])
        subprocess.check_call(['git', 'push', 'origin', 'master'])


def main():
    parser = argparse.ArgumentParser(description='Create Github releases of Homebrew bottles.')
    parser.add_argument('--github_token', required=True, help='Github API token')
    parser.add_argument('--dry_run', action='store_true', help="Don't actually do the release, just print it.")
    parser.add_argument('--version', default='', help='Version to release (default is latest)')
    args = parser.parse_args()

    b = BottleUploader(args.github_token, dry_run=args.dry_run, version=args.version)
    if not b.needs_release():
        log.info('Current version has already been released, nothing to be done!')
        return
    b.release()
    b.upload('darwin_arm64', 'arm64_sequoia')
    b.upload('darwin_arm64', 'arm64_sonoma')
    b.upload('darwin_amd64', 'sequoia')
    b.upload('darwin_amd64', 'sonoma')
    b.upload('linux_amd64', 'x86_64_linux')
    b.upload('linux_arm64', 'arm64_linux')
    if not args.dry_run:
        b.commit()
    else:
        log.info('Dry run, skipping commit and push')


if __name__ == '__main__':
    main()
