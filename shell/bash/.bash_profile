#!/bin/bash
# This file is executed by bash login shells

if [ -f "$HOME/.profile" ]; then
    . "$HOME/.profile"
fi

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

