alias ls="ls -a -G"
alias rm='rmtrash'
alias activate='. ./venv/bin/activate.fish'
alias emacs="emacs -nw"
alias tobom='nkf --overwrite --oc=UTF-8-BOM'
alias toutf8='nkf --overwrite --oc=UTF-8'
alias upper='python ~/dotfiles/scripts/upper.py'
alias lower='python ~/dotfiles/scripts/lower.py'
alias traen='trans {en=ja}'
alias traja='trans {ja=en}'

#git
alias gbr='git branch'
alias gbrd='git branch -d'
alias gbra='git branch -a'
alias gch='git checkout'
alias gch-='git checkout -'
alias gchb='git checkout -b'
alias gchd='git checkout develop'
alias gchm='git checkout master'
alias gst='git status'
alias gsh='git stash'
alias gshp='git stash -p'
alias gshpo='git stash pop'
alias gshc="git stash clear"
alias gshl='git stash list'
alias gcm='git commit'
alias gcma='git commit --amend'
alias gad='git add'
alias gada='git add .'
alias gadp='git add -p'
alias gpl='git pull'
alias gps='git push'
alias gpss='git push --set-upstream origin'
alias gpsf='git push -f'
alias gpso='git push origin'
alias ggr="git log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'"
alias gre='git rebase'
alias grei='git rebase -i'
alias grec='git rebase --continue'
alias grea='git rebase --abort'
alias gred='git rebase develop'
alias grem='git rebase master'
alias gp='git remote prune origin'
alias gchp='git cherry-pick'
alias vconf='vim ~/dotfiles/fish/config.fish'

#tmux
alias tml='tmux ls'
alias tma='tmux a'

alias les='less'
alias vl='/usr/share/vim/vim80/macros/less.sh'
alias vljis='vl -c ":e ++enc=shift_jis"'
alias vimjis='vim -c ":e ++enc=shift_jis"'

alias difcut='diff --strip-trailing-cr'

set fish_greeting ""
set -gx LD_LIBRARY_PATH "/usr/local/lib"
set -gx PKG_CONFIG_PATH "/usr/local/lib_pkgconfig"
set -gx GOOGLE_APPLICATION_CREDENTIALS "/Users/hiramekun/AudioDetections/cloud_text_to_speech_sample/endless-empire-211804-f5af7674b159.json"
set PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin /opt/X11/bin ~/.anyenv/bin 

#init rbenv
# rbenv
set -x RBENV_ROOT "$HOME/.anyenv/envs/rbenv"
set -x PATH $PATH "$RBENV_ROOT/bin"
set -gx PATH '/Users/hiramekun/.anyenv/envs/rbenv/shims' $PATH
set -gx RBENV_SHELL fish
source '/Users/hiramekun/.anyenv/envs/rbenv/libexec/../completions/rbenv.fish'
command rbenv rehash 2>/dev/null
function rbenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case rehash shell
    source (rbenv "sh-$command" $argv|psub)
  case '*'
    command rbenv "$command" $argv
  end
end

#init pyenv
set -x PYENV_ROOT "$HOME/.anyenv/envs/pyenv"
set -x PATH $PATH "$PYENV_ROOT/bin"
set -gx PATH '/Users/hiramekun/.anyenv/envs/pyenv/shims' $PATH
set -gx PYENV_SHELL fish
source '/Users/hiramekun/.anyenv/envs/pyenv/libexec/../completions/pyenv.fish'
command pyenv rehash 2>/dev/null
function pyenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case rehash shell
    source (pyenv "sh-$command" $argv|psub)
  case '*'
    command pyenv "$command" $argv
  end
end

#ndenv
set -x NDENV_ROOT "$HOME/.anyenv/envs/ndenv"
set -x PATH $PATH "$NDENV_ROOT/bin"
set -gx PATH "$NDENV_ROOT/shims" $PATH
set -gx NDENV_SHELL fish
command ndenv rehash 2>/dev/null
function ndenv
  set command $argv[1]
  set -e argv[1]

  switch "$command"
  case rehash shell
    eval (ndenv sh-"$command" $argv|psub)
  case '*'
    command ndenv "$command" $argv
  end
end
