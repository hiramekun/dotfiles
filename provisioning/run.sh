#!/usr/bin/env bash

set -eu
set -o pipefail

cd "$(dirname $0)"

RTUN='reattach-to-user-namespace'

CMD=('ansible-playbook')

if command -v ansible-playbook > /dev/null 2>&1; then
  if [ -n "${PROVISION_DRY_RUN:-}" ]; then
    CMD+=(--syntax-check)
    echo 'DRYRUN: ansible-playbook --syntax-check'
  fi
else
  echo 'skip (ansible-playbook not found)'
  exit 0
fi

ARGS=()
for a in "$@"; do
  ARGS+=("$a")
done

if [ -n "${TMUX:-}" ] && command -v "$RTUN" > /dev/null 2>&1; then
  CMD=("$RTUN" "${CMD[@]}")
fi

if [ -z "${PROVISION_DRY_RUN:-}" ]; then
  if ! command -v ansible-playbook > /dev/null 2>&1; then
    echo 'skip (ansible-playbook not found)'
    exit 0
  fi
fi

${CMD[@]} \
  -i 'localhost,' \
  --extra-vars='@config.yml' \
  ${ARGS[@]} \
  playbook.yml
