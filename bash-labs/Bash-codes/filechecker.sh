#!/bin/bash
# Enhanced File Checker Utility
# Usage:
#   ./file_checker.sh <file1> <file2> ...    # check multiple files
#   ./file_checker.sh -d <directory>        # check all files inside a directory
#   ./file_checker.sh help                  # show usage
#   ./file_checker.sh -h / --help           # show usage

# --- Help Option ---
if [[ "$1" == "help" || "$1" == "-h" || "$1" == "--help" ]]; then
  cat <<EOF
Usage:
  $0 <file1> <file2> ...       # check one or more files
  $0 -d <directory>            # check all files inside a directory
  $0 help | -h | --help        # show this help message

Examples:
  $0 myfile.txt otherfile.txt
  $0 -d /home/user/Documents
EOF
  exit 0
fi

# If no arguments are provided
if [ $# -lt 1 ]; then
  echo "Usage:"
  echo "  $0 <file1> <file2> ...       # check one or more files"
  echo "  $0 -d <directory>            # check all files inside a directory"
  exit 1
fi

# Check if user passed the -d option for directory mode
if [ "$1" == "-d" ]; then
  dir="$2"
  if [ -z "$dir" ]; then
    echo "Error: No directory provided."
    exit 1
  fi

  if [ ! -d "$dir" ]; then
    echo "Error: '$dir' is not a directory."
    exit 1
  fi

  echo "Checking all files in directory: $dir"
  for file in "$dir"/*; do
    if [ -f "$file" ]; then
      echo "File exists: $(basename "$file")"
    elif [ -d "$file" ]; then
      echo "Directory found: $(basename "$file")"
    else
      echo "Unknown item: $(basename "$file")"
    fi
  done
  exit 0
fi

# Otherwise, assume normal mode (check multiple files passed as arguments)
for file in "$@"; do
  if [ -f "$file" ]; then
    echo "The file '$file' exists."
  elif [ -d "$file" ]; then
    echo "'$file' is a directory, not a regular file."
  else
    echo "The file '$file' does not exist."
  fi
done


##-----------------------------------------------------------------

# #!/usr/bin/env bash

# FILE="$1"   # First argument passed to the script

# # Check if the file exists and is a regular file
# if [[ -f "$FILE" ]]; then
# echo "The file '$FILE' exists."
# else
# echo "The file '$FILE' does not exist."
# fi

##----------- Previous simple version -----------

# #!/bin/bash

# # Check if a filename was provided as an argument
# if [ -z "$1" ]; then
# echo "Usage: $0 <filename>"
# exit 1
# fi

# filename="$1"

# # Check if the file exists and is a regular file
# if [ -f "$filename" ]; then
# echo "The file '$filename' exists."
# else
# echo "The file '$filename' does not exist."
# fi

