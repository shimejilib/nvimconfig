SRC=$(realpath "$(dirname "$0")")

curl -s https://gist.githubusercontent.com/lifepillar/09a44b8cf0f9397465614e622979107f/raw/24-bit-color.sh | bash 

echo "
1. [OK]if you can see the color bar without any seams, your shell and your terminal supports true color
2. [OK]if you can see the color bar with seams, your shell supports true color, and your terminal supports 256 colors
3. [NG]if you can't see the color bar, your shell or your terminal doesn't support true color
"

printf "\x1b[38;2;255;100;0mif this text is not brown, please turn off termguicolors in vimrc_basic\x1b[0m\nit doesn't work well\n"

echo "if you want to desable termguicolors, please use $SRC/turn_off_termguicolors.sh"
