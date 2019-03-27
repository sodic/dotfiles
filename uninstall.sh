#!/bin/bash
for FILE in $(cat files); do
    rm "$HOME/$FILE"
done
