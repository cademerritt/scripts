#!/bin/bash

SPOOL_DIR="/media/cade/E/spool"
LAST_READ_FILE="$HOME/.spool-last-read"

if [ ! -d "$SPOOL_DIR" ]; then
    echo "Spool directory not found: $SPOOL_DIR"
    exit 1
fi

if [ -f "$LAST_READ_FILE" ]; then
    NEW_FILES=$(find "$SPOOL_DIR" -name "*-W*.txt" -newer "$LAST_READ_FILE" 2>/dev/null | sort)
else
    NEW_FILES=$(find "$SPOOL_DIR" -name "*-W*.txt" 2>/dev/null | sort)
fi

if [ -z "$NEW_FILES" ]; then
    echo "No new spool files from Windows."
    exit 0
fi

echo "=== AUTO SPOOL READ ==="
for FILE in $NEW_FILES; do
    echo ""
    echo "--- $(basename "$FILE") ---"
    cat "$FILE"
    echo ""
done

touch "$LAST_READ_FILE"
echo "Spool files loaded into context."
