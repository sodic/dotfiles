# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
export TERM="xterm-256color"
export TERMINAL="termite"

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '\e[1;36m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '\e[1;32m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '\e[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '\e[01;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '\e[0m')"; a="${a%_}"
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue="$(printf '%b' '\e[0m')"; a="${a%_}"


# The PATH declarations must to be in this file because Zsh on Arch sources
# /etc/profile – which overwrites and exports PATH – after having sourced
# ~/.zshenv. Source:
# https://stackoverflow.com/questions/21038903/path-variable-in-zshenv-or-zshrc

# set PATH so it includes user's private bin directories
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# personal binaries
export PATH="$HOME/dotfiles/bin:$PATH"

# nim, if exists
if [[ -d "$HOME/.nimble/bin" ]]; then
    export PATH="$HOME/.nimble/bin:$PATH"
fi

# go, if exists
if [[ -d '/usr/local/go' ]]; then 
    export GOROOT='/usr/local/go'
    export PATH="$GOROOT/bin:$PATH"
fi

# go anyway because that existence check is wrong
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

