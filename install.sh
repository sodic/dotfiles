#!/bin/bash
for FILE_NAME in .vimrc .bashrc .zshrc .gitconfig .bash_aliases .vimrc_background; do
    TARGET=~/dotfiles/$FILE_NAME
    LINK=~/$FILE_NAME
    echo "Creating a symbolic link: $LINK -> $TARGET".
    ln -s $TARGET $LINK
done
