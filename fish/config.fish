function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \cj do_enter
end

function cd 
  builtin cd $argv
  ls
end

function copy
  builtin echo $argv | pbcopy
end

alias copy=copy()
alias ls="ls -a -G"
alias rm='rmtrash'
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

#ssh
alias oakleafl='ssh -l t30005 oakleaf-fx-4'

#tmux
alias tml='tmux ls'
alias tma='tmux a'

#adb
alias ash='adb shell'
alias abres='adb kill-server; and adb start-server'

alias les='less'
alias vl='/usr/local/Cellar/vim/8.1.0450/share/vim/vim81/macros/less.sh'
alias vljis='vl -c ":e ++enc=shift_jis"'
alias vimjis='vim -c ":e ++enc=shift_jis"'

alias difcut='diff --strip-trailing-cr'

function do_enter
  set -l query (commandline)

  if test -n $query
    echo
    eval $query
    commandline ''
  else
    echo
    ls
    if test (git rev-parse --is-inside-work-tree 2> /dev/null)
      echo
      echo -e "\e[0;33m--- git status ---\e[0m"
      git status -sb
	  echo
    end
  end
  commandline -f repaint
end

set fish_greeting ""
set -gx OMF_PATH "/Users/takaakihirano/.local/share/omf"
set -gx OMF_CONFIG "/Users/takaakihirano/.config/omf"
set -gx LD_LIBRARY_PATH "/usr/local/lib"
set -gx PKG_CONFIG_PATH "/usr/local/lib_pkgconfig"
set -gx GOPATH "~/go"
set PATH ~/anaconda/bin ~/Library/Android/sdk/platform-tools/ ~/Library/Android/sdk/tools/ /usr/local/bin /usr/bin /bin /usr/sbin /sbin /opt/X11/bin  ~/go/bin ~/.anyenv/bin
source $OMF_PATH/init.fish
source ~/anaconda/etc/fish/conf.d/conda.fish

#eval (anyenv init - | source)
