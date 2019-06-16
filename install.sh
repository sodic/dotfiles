#!/bin/bash
# shellcheck source=util
source "$HOME/dotfiles/util"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    DISTRO="$HOME/dotfiles/distro-query"

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


# link config files
for FILE_NAME in $(cat files); do
    TARGET=~/dotfiles/$FILE_NAME
    LINK=~/$FILE_NAME
    echo "Creating a symbolic link: $LINK -> $TARGET".
    ln -sf "$TARGET" "$LINK"
done
