#!/bin/bash
rm -rf "$HOME/.oh-my-zsh"

for FILE in $(cat "$HOME/dotfiles/files"); do
    rm "$HOME/$FILE"
done
