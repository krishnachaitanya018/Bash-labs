#!/usr/bin/env bash
# Log File Analyzer
# Counts keyword occurrences in a log file and shows matching line numbers.

# --- Help option ---
if [[ "$1" == "help" || "$1" == "-h" || "$1" == "--help" ]]; then
  cat <<EOF
Usage:
  $0 <logfile> <keyword> [lines]

Arguments:
  <logfile>   Path to the log file to analyze
  <keyword>   Word to search for (e.g., ERROR, WARNING)
  [lines]     Optional: show matching lines with numbers (set 'show')

Examples:
  $0 /var/log/syslog ERROR
  $0 app.log WARNING show
EOF
  exit 0
fi

# --- Input validation ---
if [[ -z "$1" || -z "$2" ]]; then
  echo "Usage: $0 <logfile> <keyword> [lines]"
  echo "Try '$0 --help' for details."
  exit 1
fi

LOGFILE="$1"
KEYWORD="$2"
OPTION="$3"

if [[ ! -f "$LOGFILE" ]]; then
  echo "Error: File '$LOGFILE' does not exist."
  exit 1
fi

# --- Count keyword occurrences ---
COUNT=$(grep -c "$KEYWORD" "$LOGFILE")

# --- Print summary ---
echo "Keyword: '$KEYWORD'"
echo "Log file: $LOGFILE"
echo "Total occurrences: $COUNT"

# --- Show matching lines if requested ---
if [[ "$OPTION" == "show" ]]; then
  echo
  echo "Matching lines:"
  grep -n "$KEYWORD" "$LOGFILE"
fi
