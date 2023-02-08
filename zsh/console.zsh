function do_enter() {
	zle accept-line
    if [ -z "$BUFFER" ]; then
		echo
		ls
		if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
			echo
			echo -e "\e[0;33m--- git status ---\e[0m"
			git status -sb
		fi
    fi
}
zle -N do_enter
bindkey '^m' do_enter
bindkey '^j' do_enter

chpwd() {
	if [[ $(pwd) != $HOME ]]; then;
	do_enter
	fi
}


# -------------------------------------------------
# pecoの活用1
# ctrl + r で過去に実行したコマンドを選択できるようにする。
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER" --layout=bottom-up)
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# 単語の一部として扱われる文字のセットを指定する
# ここではデフォルトのセットから / を抜いたものとする
# こうすると、 Ctrl-W でカーソル前の1単語を削除したとき、 / までで削除が止まる
# パス名を入力中にファイル名を一気に消すとき便利
# 例： cd /home/me/somewhere<Ctrl-W> → cd /home/me/
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

