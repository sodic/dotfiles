#!/usr/bin/env bash
read -p "Enter Query: " query
tmux neww bash -c "curl -s cht.sh/$query | less"
