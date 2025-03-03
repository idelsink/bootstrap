# Bootstrap my machines

This repository will help me bootstrap my machines (mostly workstations).

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Usage](#usage)
- [Signing `setup-workstation.sh`](#signing-setup-workstationsh)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Usage

1. Boot a [Fedora Workstation live image](https://fedoraproject.org/workstation/download) on the target system.
2. Install and reboot.
3. Run the setup script.

```sh
# This snippet will:
# 1. Download the public key for key id: 6BFF495F6EF46E6E (https://keybase.io/binbash)
# 2. Download the setup script and its signature
# 3. Verify the signature and check the authenticity of the setup script
PRIMARY_KEY="2490AACAD97245B59ACCB7A96BFF495F6EF46E6E" && \
  curl -s https://keybase.io/binbash/key.asc | gpg --import
  curl -sL --remote-name-all \
    dels.ink/bootstrap/bin/setup-workstation.sh \
    dels.ink/bootstrap/bin/setup-workstation.sh.sig
  gpg --assert-signer "${PRIMARY_KEY}" --verify setup-workstation.sh.sig setup-workstation.sh && \
  chmod +x setup-workstation.sh && ./setup-workstation.sh
```

4. Optionally configure dotfiles from [idelsink/dotfiles](https://github.com/idelsink/dotfiles)

## Signing `setup-workstation.sh`

When the setup-workstation.sh script is updated, a new detached signature file needs to be generated so that the script can be validated when downloaded.

```sh
gpg \
  --local-user <name or (sub)key to sign with> \
  --sign \
  --armor \
  --output bin/setup-workstation.sh.sig \
  --detach-sign bin/setup-workstation.sh
```
