#!/usr/bin/env bash
#
# Simple pre-commit hook that validates the signature of the setup scripts
# script is called as: check-script-signatures.sh <fingerprint> <file> [<file> ...]

fingerprint="${1}"
shift

echo
echo "Checking file signatures with fingerprint ${fingerprint}"

exit_status=0
while [[ $# -gt 0 ]]; do
  file="${1}"
  echo
  echo "Checking file ${file}"
  shift
  gpg \
    --assert-signer "${fingerprint}" \
    --verify "${file}.sig" "${file}"
  if [[ $? -ne 0 ]]; then
    echo
    echo "Signature did not match the file ${file}. Update signature using:"
    echo "  gpg \\"
    echo "    --local-user <name or (sub)key to sign with> \\"
    echo "    --sign \\"
    echo "    --armor \\"
    echo "    --output ${file}.sig \\"
    echo "    --detach-sign ${file}.sh"
    echo
    exit_status=1
  fi
done

exit "${exit_status}"
