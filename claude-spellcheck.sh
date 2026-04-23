#!/bin/bash

TRANSCRIPT="$1"
DATE=$(date '+%Y-%m-%d')
OUT_DIR="$HOME/obsidian"
OUT_FILE="$OUT_DIR/$DATE.md"

if [ -z "$TRANSCRIPT" ]; then
  echo "Usage: claude-spellcheck.sh <transcript.jsonl>"
  exit 1
fi

echo "# Session $DATE" >> "$OUT_FILE"
echo "" >> "$OUT_FILE"

# Extract user messages from transcript and spell check them
python3 -c "
import sys, json
with open('$TRANSCRIPT') as f:
    for line in f:
        try:
            entry = json.loads(line)
            if entry.get('type') == 'user':
                for block in entry.get('message', {}).get('content', []):
                    if isinstance(block, dict) and block.get('type') == 'text':
                        print('USER: ' + block['text'])
            elif entry.get('type') == 'assistant':
                for block in entry.get('message', {}).get('content', []):
                    if isinstance(block, dict) and block.get('type') == 'text':
                        print('CLAUDE: ' + block['text'])
        except:
            pass
" | aspell -a --lang=en_US 2>/dev/null >> "$OUT_FILE"

echo "" >> "$OUT_FILE"
echo "---" >> "$OUT_FILE"
