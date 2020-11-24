#!/usr/bin/env python3

import os
from keyrings.cryptfile.cryptfile import CryptFileKeyring

pwfile = '/etc/init-secrets/cryptfile_pw'

class CryptFilePwFileDelete(CryptFileKeyring):
    def __init__(self):
        with open(pwfile) as fp:
            self.keyring_key = fp.read().strip()

        os.remove(pwfile)

        super().__init__()