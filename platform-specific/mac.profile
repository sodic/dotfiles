#!/bin/bash
# Homebrew path setter
eval "$(/opt/homebrew/bin/brew shellenv)"

# GNU utils
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export MANPATH="/opt/homebrew/opt/gnu-sed/libexec/gnuman:/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

export PATH="/opt/homebrew/opt/gawk/libexec/gnubin:/usr/local/opt/gawk/libexec/gnubin:$PATH"
export MANPATH="/opt/homebrew/opt/gawk/libexec/gnuman:/usr/local/opt/gawk/libexec/gnuman:$MANPATH"

export PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
export MANPATH="/opt/homebrew/opt/gnu-tar/libexec/gnuman:/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"

export PATH="/opt/homebrew/opt/gnu-getopt/bin:/usr/local/opt/gnu-getopt/bin:$PATH"
export MANPATH="/opt/homebrew/opt/gnu-getopt/share/man:/usr/local/opt/gnu-getopt/libexec/share/man:$MANPATH"

export PATH="/opt/homebrew/opt/gnu-indent/libexec/gnubin:/usr/local/opt/gnu-indent/libexec/gnubin:$PATH"
export MANPATH="/opt/homebrew/opt/gnu-indent/libexec/gnuman:/usr/local/opt/gnu-indent/libexec/gnuman:$MANPATH"

export PATH="/opt/homebrew/opt/grep/libexec/gnubin:/usr/local/opt/grep/libexec/gnubin:$PATH"
export MANPATH="/opt/homebrew/opt/grep/libexec/gnuman:/usr/local/opt/grep/libexec/gnuman:$MANPATH"

export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:/usr/local/opt/find/libexec/gnubin:$PATH"
export MANPATH="/opt/homebrew/opt/findutils/libexec/gnuman:/usr/local/opt/find/libexec/gnuman:$MANPATH"

# Localization
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
