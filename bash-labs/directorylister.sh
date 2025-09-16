#!/usr/bin/env bash
# Advanced Directory Lister

DIR="$1"
FILTER="$2"   # optional: file, dir, ext
OPTION="$3"   # optional: hidden

# --- Help Option ---
if [[ "$DIR" == "help" || "$DIR" == "-h" || "$DIR" == "--help" ]]; then
  cat <<EOF
Usage: $0 <directory> [filter] [option]

<directory>   Path to the directory to list
[filter]      file   -> show only files
              dir    -> show only directories
              ext:<ext> -> show only files with given extension
[option]      hidden -> include hidden files/directories

Examples:
  $0 /tmp
  $0 /var/log file
  $0 /home/user dir
  $0 /home/user ext:txt hidden
EOF
  exit 0
fi

# 1. Validate directory
if [[ -z "$DIR" ]]; then
  echo "Usage: $0 <directory> [filter: file|dir|ext:<ext>] [hidden]"
  exit 1
fi

if [[ ! -d "$DIR" ]]; then
  echo "Error: $DIR is not a directory"
  exit 1
fi

# 2. Collect items
if [[ "$OPTION" == "hidden" ]]; then
  items=("$DIR"/.* "$DIR"/*)   # include hidden
else
  items=("$DIR"/*)             # normal
fi

# 3. Empty directory check
if [[ ${#items[@]} -eq 0 ]]; then
  echo "$DIR is empty"
  exit 0
fi

# Counters
file_count=0
dir_count=0

# 4. Recursive function
list_dir() {
  local path="$1"
  local prefix="$2"
  for item in "$path"/*; do
    [[ ! -e "$item" ]] && continue  # skip non-existing
    if [[ -f "$item" ]]; then
      ((file_count++))
      # Apply filter
      if [[ "$FILTER" == "file" || -z "$FILTER" ]]; then
        perms=$(stat -c "%A" "$item" 2>/dev/null || stat -f "%Sp" "$item")
        size=$(stat -c "%s" "$item" 2>/dev/null || stat -f "%z" "$item")
        mtime=$(stat -c "%y" "$item" 2>/dev/null || stat -f "%Sm" "$item")
        echo "$prefix $(basename "$item") | $perms | ${size}B | $mtime"
      fi
      if [[ "$FILTER" == ext:* ]]; then
        ext="${FILTER#ext:}"
        [[ "$item" == *.$ext ]] && echo "$prefix $(basename "$item")"
      fi
    elif [[ -d "$item" ]]; then
      ((dir_count++))
      if [[ "$FILTER" == "dir" || -z "$FILTER" ]]; then
        echo "$prefix $(basename "$item")/"
      fi
      # Recursive call
      list_dir "$item" "   $prefix"
    fi
  done
}

# 5. Start listing
echo "Contents of $DIR:"
list_dir "$DIR" "   "

# 6. Summary
echo
echo "Summary for $DIR:"
echo "   Files: $file_count"
echo "   Directories: $dir_count"



##-----------------------------------------------------------------

# #!/usr/bin/env bash
# DIR="$1"

# # Check if it’s a directory
# if [[ ! -d "$DIR" ]]; then
# echo "Error: $DIR is not a directory"
# exit 1
# fi

# # Simple loop to list files and directories
# echo "Contents of $DIR:"
# for item in "$DIR"/*; do
# echo "$(basename "$item")"
# done
