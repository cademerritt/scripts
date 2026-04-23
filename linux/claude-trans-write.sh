#!/bin/bash

TRANS_DIR="/media/cade/E/trans"
DATE=$(date '+%-m.%-d.%y')
TIME=$(date '+%H%M')
FILENAME="$DATE-$TIME-L.txt"
FILEPATH="$TRANS_DIR/$FILENAME"

if [ ! -d "$TRANS_DIR" ]; then
    echo "Trans folder not found: $TRANS_DIR"
    exit 1
fi

if [ -n "$1" ] && [ -f "$1" ]; then
    cp "$1" "$FILEPATH"
else
    cat > "$FILEPATH"
fi

echo "Trans file written: $FILENAME"
