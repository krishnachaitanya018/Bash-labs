#!/usr/bin/env bash
# Backup Utility
# Creates a gzipped tar archive of a directory, time-stamped.
# Usage:
#   ./backup.sh <source_dir> [dest_dir]
#   ./backup.sh help | -h | --help

# --- Help option ---
if [[ "$1" == "help" || "$1" == "-h" || "$1" == "--help" ]]; then
  cat <<'EOF'
Usage:
  backup.sh <source_dir> [dest_dir]
  backup.sh help | -h | --help

Arguments:
  <source_dir>   Directory to back up (required)
  [dest_dir]     Where to save the archive (optional; default: current directory)

What it does:
  - Creates <basename>_backup_<YYYY-MM-DD_HH-MM-SS>.tar.gz
  - Verifies the archive after creation
  - Prints original size, archive size, and duration

Examples:
  backup.sh ~/projects
  backup.sh /var/www /mnt/backups
EOF
  exit 0
fi

# --- Input validation ---
if [[ -z "$1" ]]; then
  echo "Usage: $0 <source_dir> [dest_dir]    (try '$0 --help')"
  exit 1
fi

SRC="$1"
DEST="${2:-.}"

if [[ ! -d "$SRC" ]]; then
  echo "Error: '$SRC' is not a directory."
  exit 1
fi

# Create destination directory if it doesn't exist
if [[ ! -d "$DEST" ]]; then
  mkdir -p "$DEST" || { echo "Error: Cannot create destination '$DEST'."; exit 1; }
fi

# --- Build archive name ---
TIMESTAMP="$(date +%Y-%m-%d_%H-%M-%S)"
BASE="$(basename "$SRC")"
OUT="${DEST%/}/${BASE}_backup_${TIMESTAMP}.tar.gz"

# --- Measure start time & sizes ---
START_EPOCH="$(date +%s)"
SRC_SIZE="$(du -sh "$SRC" 2>/dev/null | awk '{print $1}')"

# --- Create archive ---
# Use -C to avoid embedding full absolute paths
if tar -czf "$OUT" -C "$(dirname "$SRC")" "$BASE"; then
  # Verify archive
  if tar -tzf "$OUT" >/dev/null 2>&1; then
    END_EPOCH="$(date +%s)"
    DUR="$((END_EPOCH - START_EPOCH))"
    OUT_SIZE="$(du -sh "$OUT" 2>/dev/null | awk '{print $1}')"

    echo "Backup successful."
    echo "   Source        : $SRC"
    echo "   Destination   : $OUT"
    echo "   Source size   : ${SRC_SIZE:-unknown}"
    echo "   Archive size  : ${OUT_SIZE:-unknown}"
    echo "   Duration      : ${DUR}s"
  else
    echo "Archive created but failed verification: $OUT"
    exit 2
  fi
else
  echo "Backup failed while creating archive."
  exit 1
fi
