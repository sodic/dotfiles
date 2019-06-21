# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
export TERM="xterm-256color"

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '\e[1;36m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '\e[1;32m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '\e[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '\e[01;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '\e[0m')"; a="${a%_}"
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7) # white
export LESS_TERMCAP_ue="$(printf '%b' '\e[0m')"; a="${a%_}"

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
