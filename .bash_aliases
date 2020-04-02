#!/bin/bash
alias o=xdg-open
alias py=python3
alias make-presentation='pandoc -V lang=croatian -t beamer --latex-engine=lualatex --slide-level=2'
alias q='exit'
alias c='clear'
alias ll='ls -alh'
alias t='i3-sensible-terminal'
alias nf='neofetch'
alias sl='ls'
alias copy='xclip -sel clip'

if [ -f ~/.private_aliases ]; then
    . ~/.private_aliases
fi

