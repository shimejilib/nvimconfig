#!/usr/bin/env bash
# Date: 2023/09/17
# Name: Yuya Aoki

GIT_URL="git@github.com:shimejilib/nvimconfig.git"
MOCWORD_DB_PATH="$HOME/self/etc/"

# $HOME/.configがなければ作成
if [ ! -d "$HOME"/.config ]; then
	mkdir "$HOME"/.config
fi

sudo apt-get install git curl gzip
# このrepository をcloneして、nvimの設定をする
git clone "$GIT_URL" ~/.config/nvim

#######################################
# neovim build
# License is Apache-2.0
sudo apt-get install ninja-build gettext cmake unzip curl xclip
git clone https://github.com/neovim/neovim
cd neovim || exit
git checkout v0.9.2
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd .. || exit

#######################################
# deno install
# License is MIT
curl -fsSL https://deno.land/x/install/install.sh | sh
echo "
export DENO_INSTALL=$HOME'/.deno'
export PATH='$DENO_INSTALL/bin:$PATH'
" >> ~/.bashrc

#######################################
# dein install
# License is MIT
yes 1 | sh -c "$(curl -fsSL https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh)"

#######################################
# mocwordのinstallとnextword用の設定
# mocwordは英単語を保管するためのツール
if ! which cargo > /dev/null;
then
	curl https://sh.rustup.rs -sSf | sh
	export PATH=$HOME/.cargo/bin:$PATH
	echo "export PATH=$HOME/.cargo/bin:$PATH" >> "$HOME/.bashrc"
fi
cargo install mocword
# もし/.cargo/binがpathにふくまれていなければ追加
if ! echo "$PATH" | grep -q "$HOME/.cargo/bin";
then
	echo "
	export PATH=$HOME/.cargo/bin:$PATH
	" >> ~/.bashrc
fi
wget https://github.com/high-moctane/mocword-data/releases/download/eng20200217/mocword.sqlite.gz
gzip -d mocword.sqlite.gz
if [ ! -d "$MOCWORD_DB_PATH" ]; then
	mkdir -p "$MOCWORD_DB_PATH"
fi
mv mocword.sqlite "$MOCWORD_DB_PATH"
echo "
export MOCWORD_DATA=\"$MOCWORD_DB_PATH/mocword.sqlite\"
" >> ~/.bashrc
# finishing mocword install

#######################################

# install some useful linters
sudo apt-get shellcheck pylint

#######################################

# TRUECOLORが有効か確認する
bash "$HOME".config/nvim/test_truecolor.sh

echo "
if you want to enable TRUECOLOR, please install tmux 2.2 or later.
And please use 256color terminal.
it's the easiest way to enable TRUECOLOR.
of course the best way is installing some terminal emulator which support TRUECOLOR.
"

#######################################

# shellcheck source=/dev/null
source "$HOME"/.bashrc

echo "
installing finished.
strongly recommend you to restart your terminal.

NOTE: The first time you start nvim, you must face some error.
	  But please don't worry. It's because dein is not installed yet.
	  Please type ':call dein#install()' in nvim.
	  Then dein will be installed.
	  After that, please restart nvim.
	  Then you can use nvim.
"
