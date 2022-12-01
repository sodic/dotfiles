#!/usr/bin/env bash
# Taken from here: https://github.com/ThePrimeagen/.dotfiles/blob/8214c54fa26ac709a1794389f06f99a32cef6366/bin/.local/scripts/tmux-cht.sh

commands="$(echo "find man tldr sed awk tr cp ls grep xargs rg ps mv kill lsof less head tail tar cp rm rename jq cat ssh cargo git git-worktree git-status git-commit git-rebase docker docker-compose stow chmod chown make" | tr ' ' '\n')"

languages="$(echo "golang nodejs javascript tmux typescript zsh cpp c lua rust python bash php haskell css html" | tr ' ' '\n')"

selected="$(printf "$commands\n$languages"| fzf)"

if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" <(echo "$languages"); then
    query=`echo $query | tr ' ' '+'`
    tmux neww bash -c "curl -s cht.sh/$selected/$query | less"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi
