#!/usr/bin/env bash
#
# Simple setup script to be used to bootstrap a machine with this repo.

REPO_URL="https://github.com/idelsink/bootstrap.git"

source /etc/os-release

# Install missing packages
case "${ID}" in
  fedora )
    packages=(
      ansible
      git
    )
    missing_packages=()
    for package in "${packages[@]}"; do
      if ! rpm -q "${package}" >/dev/null; then
        missing_packages+=("${package}")
      fi
    done
    if [ ${#missing_packages[@]} -gt 0 ]; then
      echo "Installing missing packages: ${missing_packages[*]}"
      sudo dnf install -y "${missing_packages[@]}"
    fi
    ;;
  # Other systems go here...
  * )
    echo "${NAME} is not supported"
    exit 1
    ;;
esac

# Check if we are inside a git repository
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  cd "$(git rev-parse --show-toplevel)" || { echo "Could not change to the git top level directory"; exit 1; }
else
  bootstrap_dir="${HOME}/bootstrap"

  if [[ -d "${bootstrap_dir}/.git" ]] && git -C "${bootstrap_dir}" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Bootstrap directory already contains a valid Git repository."
  else
    echo "Not inside a git repository and bootstrap directory is missing or invalid..."
    mkdir -p "${bootstrap_dir}"
    git clone "${REPO_URL}" "${bootstrap_dir}" || { echo "Failed to clone repository"; exit 1; }
  fi

  cd "${bootstrap_dir}" || { echo "Could not change to the git top level directory"; exit 1; }
fi

echo
echo "System is ready to run ansible. Run the workstation playbook using:"
echo
echo "  cd $(pwd) && \\"
echo "    ansible-playbook playbooks/workstation.yaml \\"
echo "    --ask-become-pass \\"
echo "    --inventory <inventory>"
echo
echo "  Where <inventory> is one of the following options:"
echo
ls -d inventories/*/ | awk '{print "    - " $0}'
echo
