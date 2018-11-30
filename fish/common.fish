#vars
set -gx LD_LIBRARY_PATH "/usr/local/lib"
set -gx PKG_CONFIG_PATH "/usr/local/lib_pkgconfig"
set fish_greeting ""

#path
set PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin /opt/X11/bin ~/.anyenv/bin 

alias ls="ls -a -G"
alias rm='rmtrash'
alias emacs="emacs -nw"

alias tobom='nkf --overwrite --oc=UTF-8-BOM'
alias toutf8='nkf --overwrite --oc=UTF-8'
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

#tmux
alias tml='tmux ls'
alias tma='tmux a'

alias les='less'
alias difcut='diff --strip-trailing-cr'
