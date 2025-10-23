#!/usr/bin/env bash
# Simple Menu-Driven Calculator
# Usage:
#   ./calculator.sh                  # run calculator interactively
#   ./calculator.sh help | -h | --help   # show usage instructions

# --- Help Option ---
if [[ "$1" == "help" || "$1" == "-h" || "$1" == "--help" ]]; then
  cat <<EOF
Usage:
  $0                           # run calculator interactively
  $0 help | -h | --help        # show this help message

This calculator supports:
  1. Addition
  2. Subtraction
  3. Multiplication
  4. Division

Notes:
  - Division by zero is not allowed.
  - Input is taken interactively when you run the script.
EOF
  exit 0
fi

# Ask the user for two numbers
read -p "Enter first number: " num1
read -p "Enter second number: " num2

# Show menu
echo "Choose an operation:"
echo "1. Addition"
echo "2. Subtraction"
echo "3. Multiplication"
echo "4. Division"

read -p "Enter your choice [1-4]: " choice

# Perform calculation based on choice
case $choice in
1)
    result=$(( num1 + num2 ))
    echo "Result: $num1 + $num2 = $result"
    ;;
2)
    result=$(( num1 - num2 ))
    echo "Result: $num1 - $num2 = $result"
    ;;
3)
    result=$(( num1 * num2 ))
    echo "Result: $num1 * $num2 = $result"
    ;;
4)
    if [[ $num2 -eq 0 ]]; then
        echo "Error: Division by zero is not allowed"
    else
        result=$(( num1 / num2 ))
        echo "Result: $num1 / $num2 = $result"
    fi
    ;;
*)
    echo "Invalid choice. Please select 1–4."
    ;;
esac

