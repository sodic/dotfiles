#!/bin/bash
alias o=xdg-open
alias py=python3
alias make-presentation='pandoc -V lang=croatian -t beamer --latex-engine=lualatex --slide-level=2'
alias q='exit'
alias c='clear'
alias ll='ls -alh'
alias t='i3-sensible-terminal & disown'
alias nf='neofetch'
alias sl='ls'
alias copy='xclip -sel clip'
alias init-nvm='. /usr/share/nvm/init-nvm.sh' # takes too long to init, use when needed
#alias node='node || [ $? -eq 127 ] && "To use node, you must first run init-nvm"'
#alias npm='npm || [ $? -eq 127 ] && "To use npm, you must first run init-nvm"'
alias cf='cf-tool'

if [ -f ~/.private_aliases ]; then
    . ~/.private_aliases
fi

