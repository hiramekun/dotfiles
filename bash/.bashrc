source ~/common.bash
source ~/local.bash

export ANYENV_DIR=$HOME/.anyenv
export PATH=/opt/homebrew/bin:$PATH
export PATH=$ANYENV_DIR/bin:$PATH

if [ -d $HOME/.anyenv ] && command 'anyenv' > /dev/null 2>&1; then
  eval "$(anyenv install --init)"
fi
