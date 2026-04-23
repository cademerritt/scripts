#!/bin/bash

TRANS_DIR="/media/cade/E/trans"
LAST_READ_FILE="$HOME/.trans-last-read"

if [ ! -d "$TRANS_DIR" ]; then
    echo "Trans folder not found: $TRANS_DIR"
    exit 1
fi

if [ -f "$LAST_READ_FILE" ]; then
    NEW_FILES=$(find "$TRANS_DIR" -name "*-W*.txt" -newer "$LAST_READ_FILE" 2>/dev/null | sort)
else
    NEW_FILES=$(find "$TRANS_DIR" -name "*-W*.txt" 2>/dev/null | sort)
fi

if [ -z "$NEW_FILES" ]; then
    echo "No new trans files from Windows."
    exit 0
fi

echo "=== AUTO TRANS READ ==="
for FILE in $NEW_FILES; do
    echo ""
    echo "--- $(basename "$FILE") ---"
    cat "$FILE"
    echo ""
done

touch "$LAST_READ_FILE"
echo "Trans files loaded into context."
