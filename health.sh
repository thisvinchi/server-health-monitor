#!/bin/bash
set -euo pipefail

DIR="${1:-/}"
THRESHOLD=80
LOG="$HOME/health.log"

USAGE=$(df "$DIR" | awk 'NR==2 {print $5}' | sed 's/%//')
TIME=$(date '+%Y-%m-%d %H:%M:%S')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "$TIME WARNING: $DIR at ${USAGE}%" >> "$LOG"
else
    echo "$TIME OK: $DIR at ${USAGE}%" >> "$LOG"
fi

if [ "$(wc -l < "$LOG")" -gt 500 ]; then
    tail -n 500 "$LOG" > "$LOG.tmp" && mv "$LOG.tmp" "$LOG"
fi
