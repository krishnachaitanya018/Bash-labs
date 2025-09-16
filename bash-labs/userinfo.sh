#!/usr/bin/env bash
# Script: user_info_tool.sh
# Purpose: Show user/system info with handy subcommands
# Usage:
#   ./user_info_tool.sh                      # current user + date/time
#   ./user_info_tool.sh all                  # all currently logged-in users
#   ./user_info_tool.sh user <username>      # details for a specific user
#   ./user_info_tool.sh session              # current session details
#   ./user_info_tool.sh uptime               # system uptime/load
#   ./user_info_tool.sh log [path]           # write default output to a log (default: ./user_info.log)
#   ./user_info_tool.sh help                 # help/usage

set -euo pipefail

# -------- Helpers --------
bold() { printf "\033[1m%s\033[0m" "$*"; }
exists() { command -v "$1" >/dev/null 2>&1; }

now_iso() { date +"%Y-%m-%d %H:%M:%S %Z"; }

# OS-agnostic passwd record (Linux/macOS)
# Fields: name:passwd:uid:gid:gecos:home:shell
get_passwd_record() {
  local user="$1"
  local rec
  # Prefer getent if present (Linux/modern)
  if exists getent; then
    rec=$(getent passwd "$user" || true)
  fi
  # Fallback to /etc/passwd
  if [[ -z "${rec:-}" ]]; then
    rec=$(awk -F: -v u="$user" '$1==u{print $0}' /etc/passwd || true)
  fi
  printf "%s" "${rec:-}"
}

user_exists() {
  local user="$1"
  [[ -n "$(get_passwd_record "$user")" ]]
}

user_home() {
  local rec
  rec=$(get_passwd_record "$1")
  [[ -n "$rec" ]] && awk -F: '{print $6}' <<<"$rec"
}

user_shell() {
  local rec
  rec=$(get_passwd_record "$1")
  [[ -n "$rec" ]] && awk -F: '{print $7}' <<<"$rec"
}

user_groups() {
  # 'groups user' is portable; on Linux 'id -nG user' also works
  if exists id; then
    id -nG "$1" 2>/dev/null || groups "$1" 2>/dev/null || true
  else
    groups "$1" 2>/dev/null || true
  fi
}

last_login() {
  local user="$1"
  # 'last' may not exist on minimal/mac systems; try 'lastlog' on Linux
  if exists last; then
    last -n 1 "$user" 2>/dev/null | head -n 1 || true
  elif exists lastlog; then
    lastlog -u "$user" 2>/dev/null | tail -n +2 || true
  else
    echo "last/lastlog not available"
  fi
}

current_user_block() {
  echo "$(bold "Current user") : ${USER:-$(whoami)}"
  echo "$(bold "Effective user"): $(whoami)"
  echo "$(bold "Timestamp")     : $(now_iso)"
}

all_logged_in_users_block() {
  echo "$(bold "All currently logged-in users:")"
  # 'who' is more detailed; 'users' is compact
  if exists who; then
    who
  else
    users
  fi
}

specific_user_block() {
  local user="$1"
  if ! user_exists "$user"; then
    echo "User '$user' not found on this system."
    return 1
  fi
  local home shell groups_line last_line
  home=$(user_home "$user")
  shell=$(user_shell "$user")
  groups_line=$(user_groups "$user")
  last_line=$(last_login "$user")

  echo "$(bold "User")       : $user"
  [[ -n "$home"  ]] && echo "$(bold "Home")       : $home"
  [[ -n "$shell" ]] && echo "$(bold "Shell")      : $shell"
  [[ -n "$groups_line" ]] && echo "$(bold "Groups")     : $groups_line"
  [[ -n "$last_line"  ]] && echo "$(bold "Last login") : $last_line"
}

session_block() {
  echo "$(bold "Current session(s):")"
  if exists w; then
    w
  elif exists who; then
    who -u
  else
    echo "Neither 'w' nor 'who' available."
  fi
}

uptime_block() {
  echo "$(bold "Uptime / Load:")"
  if exists uptime; then
    uptime
  else
    echo "uptime command not available."
  fi
}

log_default() {
  local path="${1:-./user_info.log}"
  {
    echo "===== $(now_iso) ====="
    current_user_block
    echo
    uptime_block
    echo
    echo "----------------------"
  } >> "$path"
  echo "Wrote default info to: $path"
}

usage() {
  cat <<'EOF'
Usage:
  user_info_tool.sh                      # current user + date/time
  user_info_tool.sh all                  # all currently logged-in users
  user_info_tool.sh user <username>      # details for a specific user
  user_info_tool.sh session              # current session details
  user_info_tool.sh uptime               # system uptime/load
  user_info_tool.sh log [path]           # append default info to a log file (default: ./user_info.log)
  user_info_tool.sh help                 # show this help
EOF
}

# -------- Dispatcher --------
cmd="${1:-default}"
case "$cmd" in
  default)
    current_user_block
    ;;
  all)
    all_logged_in_users_block
    ;;
  user)
    if [[ $# -lt 2 ]]; then
      echo "Provide a username: ./user_info_tool.sh user <username>"
      exit 1
    fi
    specific_user_block "$2"
    ;;
  session)
    session_block
    ;;
  uptime)
    uptime_block
    ;;
  log)
    log_default "${2:-}"
    ;;
  help|-h|--help)
    usage
    ;;
  *)
    echo "Unknown command: $cmd"
    usage
    exit 1
    ;;
esac

##----------------------------------#


#!/usr/bin/env bash
# User Information Script
# Usage: ./user_info.sh

# Using system variable
echo "Current user (from \$USER variable): $USER"

# Using built-in command with command substitution
echo "Current user (from whoami command): $(whoami)"

# Using command substitution to get current date/time
echo "Current date and time: $(date '+%Y-%m-%d %H:%M:%S %Z')"
