#!/bin/bash
for FILE in $(cat files); do
    rm "~/$FILE"
done
