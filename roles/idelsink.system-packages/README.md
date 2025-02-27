# System packages

This role will install system package and repos depending on the target system.

Internally, it will check what system it use the appropriate variables for that.


## Role variables

- `system_packages_dnf` (Default : `[]`) - List of packages to install using the dnf module. See <https://docs.ansible.com/ansible/latest/collections/ansible/builtin/dnf_module.html> for all the available variables.
- `system_packages_yum_repositories` (default: `[]`) - List of repositories to install using yum_repository module. See <https://docs.ansible.com/ansible/latest/collections/ansible/builtin/yum_repository_module.html> for all the available variables.
