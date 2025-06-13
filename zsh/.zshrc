source "$DOTFILES_PATH/zsh/plugin.zsh"
source "$DOTFILES_PATH/zsh/alias.zsh"
source "$DOTFILES_PATH/zsh/console.zsh"

# asdf completions (ASDF_DIR is set in shell/env.sh)
if [ -n "${ASDF_DIR:-}" ]; then
  fpath=(${ASDF_DIR}/completions $fpath)
fi

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# Emacs ライクな操作を有効にする（文字入力中に Ctrl-F,B でカーソル移動など）
# Vi ライクな操作が好みであれば `bindkey -v` とする
bindkey -e

# 自動補完を有効にする
# コマンドの引数やパス名を途中まで入力して <Tab> を押すといい感じに補完してくれる
# 例： `cd path/to/<Tab>`, `ls -<Tab>`
#autoload -U compinit; compinit

# 入力したコマンドが存在せず、かつディレクトリ名と一致するなら、ディレクトリに cd する
# 例： /usr/bin と入力すると /usr/bin ディレクトリに移動
setopt auto_cd

# 隠しファイルも補完で表示する
setopt globdots

#ターミナルの音をオフにする
setopt NO_BEEP

# "~hoge" が特定のパス名に展開されるようにする（ブックマークのようなもの）
# 例： cd ~hoge と入力すると /long/path/to/hogehoge ディレクトリに移動
# hash -d hoge=/long/path/to/hogehoge

# cd した先のディレクトリをディレクトリスタックに追加する
# ディレクトリスタックとは今までに行ったディレクトリの履歴のこと
# `cd +<Tab>` でディレクトリの履歴が表示され、そこに移動できる
setopt auto_pushd

# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups
# 拡張 glob を有効にする
# glob とはパス名にマッチするワイルドカードパターンのこと
# （たとえば `mv hoge.* ~/dir` における "*"）
# 拡張 glob を有効にすると # ~ ^ もパターンとして扱われる # どういう意味を持つかは `man zshexpn` の FILENAME GENERATION を参照
setopt extended_glob

# 入力したコマンドがすでにコマンド履歴に含まれる場合、履歴から古いほうのコマンドを削除する
# コマンド履歴とは今まで入力したコマンドの一覧のことで、上下キーでたどれる
setopt hist_ignore_all_dups

# コマンドがスペースで始まる場合、コマンド履歴に追加しない
# 履歴に残したくないコマンドを入力するとき使う
# 例： <Space>echo hello と入力
setopt hist_ignore_space

# <Tab> でパス名の補完候補を表示したあと、
# 続けて <Tab> を押すと候補からパス名を選択できるようになる
# 候補を選ぶには <Tab> か Ctrl-N,B,F,P
zstyle ':completion:*:default' menu select=1


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/takaaki.hirano/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/takaaki.hirano/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/takaaki.hirano/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/takaaki.hirano/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
