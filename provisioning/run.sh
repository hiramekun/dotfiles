#!/usr/bin/env bash

set -eu
set -o pipefail

cd "$(dirname $0)"

RTUN='reattach-to-user-namespace'

CMD=('ansible-playbook')
ARGS=('')
for a in "$@"; do
  ARGS=(${ARGS[@]} "$a")
done

if [ -n "${TMUX:-}" ] && command -v $RTUN > /dev/null 2>&1; then
  CMD=($RTUN ${CMD[@]})
fi

${CMD[@]} \
  -i 'localhost,' \
  --extra-vars='@config.yml' \
  ${ARGS[@]} \
  playbook.yml
