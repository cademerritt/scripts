#!/bin/bash

python3 -c "
import sys, json
from datetime import datetime

timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
log_path = '/media/cade/E/raw/claude-raw.log'

try:
    data = json.load(sys.stdin)
    tool_name = data.get('tool_name', '')
    tool_input = data.get('tool_input', '')
    tool_response = data.get('tool_response', '')
    transcript = data.get('transcript_path', '')
    with open(log_path, 'a') as f:
        f.write(f'=== {timestamp} ===\n')
        f.write(f'TOOL: {tool_name}\n')
        f.write(f'INPUT: {tool_input}\n')
        f.write(f'OUTPUT: {tool_response}\n')
        f.write(f'TRANSCRIPT: {transcript}\n')
        f.write('\n')
except Exception:
    pass
"
