alias o=xdg-open
alias py=python3.6
alias make-presentation='pandoc -V lang=croatian -t beamer --latex-engine=lualatex --slide-level=2'
alias q='exit'
alias c='clear'
alias ll='ls -alh'

if [ -f ~/.private_aliases ]; then
    . ~/.private_aliases
fi

