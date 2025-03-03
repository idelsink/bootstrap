# Flatpak

Simple role to manage flatpak packages.

## Role variables

- `flatpak_remotes` (default: `[]`) - List of flatpak remotes. See <https://docs.ansible.com/ansible/latest/collections/community/general/flatpak_remote_module.html> for all the available arguments.
- `flatpak_packages` (default: `[]`) - List of flatpak packages to install. See <https://docs.ansible.com/ansible/latest/collections/community/general/flatpak_module.html> for all the available arguments.
