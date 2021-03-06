#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    source "$HOME/dotfiles/set-distro"

    if [ ! -d "$HOME/dotfiles/$DISTRO" ]; then
        echo "Unknown distribution, exiting"
    fi

    # install zsh only if the updates were successful
    # shellcheck source=/dev/null
    if source "$HOME/dotfiles/$DISTRO/update"; then
        # shellcheck source=/dev/null
        source "$HOME/dotfiles/$DISTRO/install-zsh"
    fi

elif [[ "$OSTYPE" == "darwin"* ]]; then
    # install zsh only if Homebrew was installed sucessfully
    if source "$HOME/mac/install-homebrew"; then
        source "$HOME/mac/install-zsh"
    fi
else
    echo "Unknown OS, exiting"
    exit 1
fi

# run only if zsh is installed
if which zsh; then
    source "install-oh-my-zsh"
fi
