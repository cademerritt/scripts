#!/bin/bash

DATE=$(date '+%Y-%m-%d')
WIKI="/media/cade/E/wiki"
DAILY="$WIKI/sessions/$DATE.md"

mkdir -p "$WIKI/sessions"

TRANSCRIPT="$1"

if [ -z "$TRANSCRIPT" ]; then
  echo "Usage: claude-index.sh <transcript.jsonl>"
  exit 1
fi

# Write daily session note
echo "# Session $DATE" > "$DAILY"
echo "" >> "$DAILY"
echo "## Conversation" >> "$DAILY"
echo "" >> "$DAILY"

python3 -c "
import sys, json
with open('$TRANSCRIPT') as f:
    for line in f:
        try:
            entry = json.loads(line)
            if entry.get('type') == 'user':
                for block in entry.get('message', {}).get('content', []):
                    if isinstance(block, dict) and block.get('type') == 'text':
                        print('**Cade:** ' + block['text'])
                        print('')
            elif entry.get('type') == 'assistant':
                for block in entry.get('message', {}).get('content', []):
                    if isinstance(block, dict) and block.get('type') == 'text':
                        lines = [l for l in block['text'].split('\n') if not l.startswith('#### Correction:')]
                        cleaned = '\n'.join(lines).strip()
                        if cleaned:
                            print('**Claude:** ' + cleaned)
                            print('')
        except:
            pass
" >> "$DAILY"

echo "---" >> "$DAILY"
echo "Written by claude-index.sh" >> "$DAILY"

echo "Session note written to $DAILY"
