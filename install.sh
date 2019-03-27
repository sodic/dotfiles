#!/bin/bash
for FILE_NAME in $(cat files); do
    TARGET=~/dotfiles/$FILE_NAME
    LINK=~/$FILE_NAME
    echo "Creating a symbolic link: $LINK -> $TARGET".
    ln -s $TARGET $LINK
done
