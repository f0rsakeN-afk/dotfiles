#!/usr/bin/env python3
import json
import os
import psutil
from pathlib import Path

CACHE_DIR = Path(os.environ.get('XDG_CACHE_HOME', Path.home() / '.cache'))
HISTORY_FILE = CACHE_DIR / 'cpu_usage_history.json'
HISTORY_DEPTH = 40

BRAILLE_PATTERNS = {
    (0, 0): '⠀', (1, 0): '⡀', (2, 0): '⡄', (3, 0): '⡆', (4, 0): '⡇',
    (0, 1): '⢀', (1, 1): '⣀', (2, 1): '⣄', (3, 1): '⣆', (4, 1): '⣇',
    (0, 2): '⢠', (1, 2): '⣠', (2, 2): '⣤', (3, 2): '⣦', (4, 2): '⣧',
    (0, 3): '⢰', (1, 3): '⣰', (2, 3): '⣴', (3, 3): '⣶', (4, 3): '⣷',
    (0, 4): '⢸', (1, 4): '⣸', (2, 4): '⣼', (3, 4): '⣾', (4, 4): '⣿',
}

def get_braille_char(left_val, right_val):
    def cpu_to_level(val):
        if val < 1: return 0
        elif val < 12.5: return 1
        elif val < 25: return 2
        elif val < 50: return 3
        else: return 4
    left_level = cpu_to_level(left_val)
    right_level = cpu_to_level(right_val)
    return BRAILLE_PATTERNS.get((left_level, right_level), '⠀')

try:
    with open(HISTORY_FILE, 'r') as f:
        data = json.load(f)
except (FileNotFoundError, json.JSONDecodeError):
    data = {"history": []}

per_core = psutil.cpu_percent(interval=0.1, percpu=True)
current_usage = sum(per_core) / len(per_core)

history = data.get("history", [])
history.append(current_usage)
if len(history) > HISTORY_DEPTH:
    history = history[-HISTORY_DEPTH:]

padded = [0.0] * (HISTORY_DEPTH - len(history)) + history
graph = ''.join(
    get_braille_char(padded[i], padded[i + 1] if i + 1 < HISTORY_DEPTH else 0.0)
    for i in range(0, HISTORY_DEPTH, 2)
)
text = f"[{graph}]"

with open(HISTORY_FILE, 'w') as f:
    json.dump({"history": history}, f)

print(text)
