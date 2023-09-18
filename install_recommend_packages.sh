#!/bin/bash
# ##################################################################
# [Yuya Aoki]
# Title :
# Description : 
# ##################################################################
SRC=$(realpath "$(dirname "$0")")
VERSION=0.1.0
SUBJECT=$(basename "$0")

printhelp(){
echo "
Usage: $0 [options] [arguments]
VERSION: $VERSION
This is a template script.
This scriptfile is located at $SRC

options
	-h		print this help
	-v		print script version
"
}

while getopts ":i:vh-:" optname
  do
    case "$optname" in
      "v")
        echo "Version $VERSION"
        exit 0;
        ;;
      "i")
        echo "-i argument: $OPTARG"
        ;;
      "h")
        printhelp
        exit 0;
        ;;
      "?")
        echo "Unknown option $OPTARG"
        exit 0;
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        exit 0;
        ;;
      *)
        echo "Unknown error while processing options"
        exit 0;
        ;;
    esac
  done
shift $((OPTIND - 1))

# -----------------------------------------------------------------
LOCK_FILE=/tmp/$SUBJECT.lock
if [ -f "$LOCK_FILE" ]; then
   echo "Script is already running"
   exit
fi

trap 'rm -f $LOCK_FILE' EXIT
touch "$LOCK_FILE"

# it is requirement of jedi (python lsp)
sudo apt install python3.10-venv

# it is requirement of bashls
sudo apt install npm
sudo snap install bash-language-server

