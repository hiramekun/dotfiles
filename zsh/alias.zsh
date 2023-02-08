alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='ls -a'
alias ls='ls -aGF'
alias rm='trash'
alias emacs="emacs -nw"
alias cp='cp -v'
alias mv='mv -v'

# git
alias gad='git add'

alias gbr='git branch'
alias gbra='git branch -a'
alias gbrd='git branch -d'

alias gch='git switch'
alias gch-='git switch -'
alias gchb='git switch -c'
alias gchd='git switch develop'
alias gchm='git switch main'
alias gchma='git switch master'
alias gchp='git cherry-pick'

alias gcm='git commit'
alias gcma='git commit --amend'

alias ggr="git log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'"
alias gp='git remote prune origin'
alias gpl='git pull'
alias gps='git push'
alias grei='git rebase -i'
alias gsh='git stash'
alias gshp='git stash pop'

alias gre='git rebase'
alias grea='git rebase --abort'
alias grec='git rebase --continue'
alias gred='git rebase develop'
alias grei='git rebase -i'
alias grem='git rebase master'

# charset
alias tobom='nkf --overwrite --oc=UTF-8-BOM'
alias toutf8='nkf --overwrite --oc=UTF-8'

# translation
alias traen='trans {en=ja} -no-auto'
alias traja='trans {ja=en} -no-auto'
