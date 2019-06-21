#!/bin/bash
for FILE in $(cat "$HOME/dotfiles/files"); do
    rm "$HOME/$FILE"
done
