#!/bin/bash

SPOOL_DIR="/media/cade/E/spool"
DATE=$(date '+%-m.%-d.%y')
TIME=$(date '+%H%M')
FILENAME="$DATE-$TIME-L.txt"
FILEPATH="$SPOOL_DIR/$FILENAME"

if [ ! -d "$SPOOL_DIR" ]; then
    echo "Spool directory not found: $SPOOL_DIR"
    exit 1
fi

if [ -n "$1" ] && [ -f "$1" ]; then
    cp "$1" "$FILEPATH"
else
    cat > "$FILEPATH"
fi

echo "Spool file written: $FILENAME"
