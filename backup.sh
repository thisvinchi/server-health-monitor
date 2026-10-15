#!/bin/bash
set -euo pipefail

backup_dir() {
    local source="$1"
    local dest="/mnt/backups/$(date +%Y-%m-%d)"
    mkdir -p "$dest"
    cp -r "$source" "$dest"
    echo "$(date '+%Y-%m-%d %H:%M:%S') Backup complete: $dest" >> "$HOME/backup.log"
}

backup_dir "$1"
