#--------------
# common.bash
#--------------

# OS descripter 'OS'{{{
if [ "$(uname)" == 'Darwin' ]; then
	OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then       
	OS='Cygwin'
else
	echo "Your platform ($(uname -a)) is not supported."
	exit 1
fi
#}}}

if [ ${OS} == 'Mac' ]; then
	export LSCOLORS=gxfxcxdxbxegedabagacad
	alias ls='ls -G'
	alias tree="pwd;find . | sort | sed '1d;s/^\.//;s/\/\([^/]*\)$/|--\1/;s/\/[^/|]*/|  /g'"
fi
