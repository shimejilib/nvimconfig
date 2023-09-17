set -x
SRC=$(realpath "$(dirname "$0")")


# mac ならgsedを使う
if [ "$(uname)" = "Darwin" ]; then
	gsed "s/set termguicolors/\" &/" -i.backup "$SRC"/vimrc_basic
else
	sed "s/set termguicolors/\" &/" -i.backup "$SRC"/vimrc_basic
fi
