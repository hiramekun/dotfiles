set -gx GOOGLE_APPLICATION_CREDENTIALS "$HOME/endless-empire-211804-f5af7674b159.json"

alias vl='/usr/share/vim/vim80/macros/less.sh'
alias vljis='vl -c ":e ++enc=shift_jis"'
alias vimjis='vim -c ":e ++enc=shift_jis"'
alias vimconf='vim ~/dotfiles/fish/config.fish'
alias vimenv='vim ~/dotfiles/fish/envs.fish'
alias vimlocal='vim ~/dotfiles/fish/local.fish'
alias vimcommon='vim ~/dotfiles/fish/common.fish'

alias upper='python ~/dotfiles/scripts/upper.py'
alias lower='python ~/dotfiles/scripts/lower.py'

alias activate='. ./venv/bin/activate.fish'
alias ocaml='rlwrap ocaml'
