#!/bin/bash

REPO="$HOME/scripts"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M')

cd "$REPO" || exit 1

if [ -n "$(git status --porcelain)" ]; then
    git add -A
    git commit -m "auto-push $TIMESTAMP"
    git push
fi
