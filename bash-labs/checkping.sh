#!/usr/bin/env bash
# Advanced Ping Checker with Function and Help

check_ping() {
  host="$1"
  count="$2"

  # Input validation
  if [[ -z "$host" ]]; then
    echo "Error: No hostname or IP provided."
    echo "Try '$0 help' for usage."s
    return 1
  fi

  # Default packet count = 1 if not provided
  if [[ -z "$count" ]]; then
    count=1
  fi

  # Run ping
  ping -c "$count" "$host" >/dev/null 2>&1

  if [[ $? -eq 0 ]]; then
    echo "Host $host is reachable with $count packet(s)."
  else
    echo "Host $host is unreachable."
  fi
}

# --- Help Option ---
if [[ "$1" == "help" || "$1" == "-h" || "$1" == "--help" ]]; then
  cat <<EOF
Usage:
  $0 <hostname_or_ip> [packet_count]
  $0 help | -h | --help

Arguments:
  <hostname_or_ip>   The host to ping (e.g., google.com or 8.8.8.8)
  [packet_count]     Optional. Number of packets to send (default: 1)

Examples:
  $0 google.com            # Ping google.com with 1 packet
  $0 8.8.8.8 5             # Ping 8.8.8.8 with 5 packets
  $0 --help                # Show this help message
EOF
  exit 0
fi

# --- Run the function ---
check_ping "$1" "$2"
