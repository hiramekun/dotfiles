if [[ ! -d $HOME/.zplug ]];then
  git clone https://github.com/zplug/zplug $HOME/.zplug
fi

source $HOME/.zplug/init.zsh
zplug "zplug/zplug", hook-build:'zplug --self-manage'

zplug "zsh-users/zsh-completions"
zplug "spaceship-prompt/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

zplug "zsh-users/zsh-autosuggestions"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#c6c6c6,bg=#106a84,bold,underline"

zplug "zsh-users/zsh-syntax-highlighting"

# インストールしてないプラグインはインストール
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load --verbose

