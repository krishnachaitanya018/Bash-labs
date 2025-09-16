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



##############------------------------------------------------------------------------###################
# #!/usr/bin/env bash
# # Pro Bash Calculator (floats, memory, history, menu-driven)

# shopt -s extglob
# HISTORY=()         # ring buffer of results
# LAST_RES=""        # last result (empty until first calc)
# MEM=0              # memory register

# # ---------- UI helpers ----------
# C_RESET="\033[0m"; C_HL="\033[1;36m"; C_ERR="\033[1;31m"; C_OK="\033[1;32m"; C_DIM="\033[2m"

# msg()   { printf "%b%s%b\n" "$C_HL" "$1" "$C_RESET"; }
# ok()    { printf "%b%s%b\n" "$C_OK" "$1" "$C_RESET"; }
# err()   { printf "%b%s%b\n" "$C_ERR" "$1" "$C_RESET" >&2; }
# dim()   { printf "%b%s%b\n" "$C_DIM" "$1" "$C_RESET"; }

# # ---------- validation ----------
# is_number() {
#   # integers or floats, optional leading sign
#   [[ $1 =~ ^[+-]?[0-9]+([.][0-9]+)?$ ]]
# }

# read_number() {
#   local prompt="$1" default="$2" val
#   while true; do
#     if [[ -n "$default" ]]; then
#       read -r -p "$prompt [$default]: " val
#       [[ -z "$val" ]] && val="$default"
#     else
#       read -r -p "$prompt: " val
#     fi
#     if is_number "$val"; then
#       printf "%s" "$val"
#       return 0
#     else
#       err "Please enter a valid number (e.g., 12, -3.5, 0.75)."
#     fi
#   done
# }

# # ---------- math engine (bc -l) ----------
# calc() {
#   # usage: calc "expression"
#   local expr="$1"
#   # guard against unsafe chars
#   if [[ $expr =~ [^0-9+\-*/^().%[:space:]] ]]; then
#     err "Invalid characters in expression."
#     return 1
#   fi
#   local out
#   out=$(printf 'scale=10; %s\n' "$expr" | bc -l 2>/dev/null)
#   # bc may output ".5" → normalize
#   [[ $out =~ ^[.][0-9]+$ ]] && out="0$out"
#   if [[ -z "$out" ]]; then
#     err "Computation failed."
#     return 1
#   fi
#   # strip trailing zeros for neatness
#   out=$(printf "%s\n" "$out" | sed -E 's/(\.[0-9]*[1-9])0+$/\1/; s/\.0+$//')
#   printf "%s" "$out"
# }

# store_history() {
#   HISTORY=("$1" "${HISTORY[@]}")
#   # keep last 10
#   (( ${#HISTORY[@]} > 10 )) && HISTORY=("${HISTORY[@]:0:10}")
# }

# show_history() {
#   if ((${#HISTORY[@]}==0)); then
#     dim "(no history yet)"
#     return
#   fi
#   for i in "${!HISTORY[@]}"; do
#     printf "%2d) %s\n" "$((i+1))" "${HISTORY[$i]}"
#   done
# }

# help_screen() {
#   cat <<'EOF'
# Operations:
#   1) Addition            a + b
#   2) Subtraction         a - b
#   3) Multiplication      a * b
#   4) Division            a / b        (guarded against divide-by-zero)
#   5) Modulo              a % b        (integers behave as expected)
#   6) Power               a ^ b
#   7) Square root         sqrt(a)      (enter only first number)
#   8) Absolute value      |a|          (enter only first number)
#   9) Percentage          a % of b     (a/100 * b)
#  10) Average (N numbers) Enter a space-separated list

# Utility:
#   h) History (last 10)   m) Memory (MR/M+/M-/MC)   c) Clear screen   ?/help) Help   q) Quit

# Tip: press Enter to reuse the previous result as a default input.
# EOF
# }

# memory_menu() {
#   printf "Memory: current MEM = %s\n" "$MEM"
#   echo "Enter:  MR (recall) | M+ <x> | M- <x> | MC  | back"
#   while true; do
#     read -r -p "mem> " cmd x
#     case "$cmd" in
#       MR|mr)        ok "Recall → $MEM"; LAST_RES="$MEM"; return;;
#       M+|m+)        if is_number "$x"; then MEM=$(calc "$MEM + $x"); ok "MEM = $MEM"; else err "Provide a number."; fi;;
#       M-|m-)        if is_number "$x"; then MEM=$(calc "$MEM - $x"); ok "MEM = $MEM"; else err "Provide a number."; fi;;
#       MC|mc)        MEM=0; ok "Memory cleared."; ;;
#       back|"")      return;;
#       *)            err "Unknown: use MR | M+ <x> | M- <x> | MC | back";;
#     esac
#   done
# }

# clear; msg "🧮 Pro Bash Calculator"
# help_screen

# # ---------- main loop ----------
# while true; do
#   echo
#   echo "Choose: 1)+  2)-  3)*  4)/  5)%  6)^  7)sqrt  8)abs  9)%of  10)avg   h)history  m)memory  c)clear  ?/help  q)quit"
#   read -r -p "option> " opt

#   case "$opt" in
#     q|Q) msg "Goodbye!"; exit 0;;
#     c|C) clear; continue;;
#     h|H) show_history; continue;;
#     \?|help|HELP) help_screen; continue;;
#     m|M) memory_menu; continue;;
#   esac

#   case "$opt" in
#     1)  # addition
#         a=$(read_number "Enter a" "$LAST_RES")
#         b=$(read_number "Enter b" "")
#         res=$(calc "$a + $b") || { err "Failed."; continue; }
#         ok "$a + $b = $res"
#         LAST_RES="$res"; store_history "$a + $b = $res"
#         ;;
#     2)  # subtraction
#         a=$(read_number "Enter a" "$LAST_RES")
#         b=$(read_number "Enter b" "")
#         res=$(calc "$a - $b") || { err "Failed."; continue; }
#         ok "$a - $b = $res"
#         LAST_RES="$res"; store_history "$a - $b = $res"
#         ;;
#     3)  # multiplication
#         a=$(read_number "Enter a" "$LAST_RES")
#         b=$(read_number "Enter b" "")
#         res=$(calc "$a * $b") || { err "Failed."; continue; }
#         ok "$a * $b = $res"
#         LAST_RES="$res"; store_history "$a * $b = $res"
#         ;;
#     4)  # division
#         a=$(read_number "Enter a" "$LAST_RES")
#         b=$(read_number "Enter b" "")
#         if [[ "$b" == "0" || "$b" == "0.0" ]]; then err "Division by zero not allowed."; continue; fi
#         res=$(calc "$a / $b") || { err "Failed."; continue; }
#         ok "$a / $b = $res"
#         LAST_RES="$res"; store_history "$a / $b = $res"
#         ;;
#     5)  # modulo (works fine with ints; bc handles floats modulo too via %)
#         a=$(read_number "Enter a" "$LAST_RES")
#         b=$(read_number "Enter b" "")
#         if [[ "$b" == "0" || "$b" == "0.0" ]]; then err "Modulo by zero not allowed."; continue; fi
#         res=$(calc "$a % $b") || { err "Failed."; continue; }
#         ok "$a % $b = $res"
#         LAST_RES="$res"; store_history "$a % $b = $res"
#         ;;
#     6)  # power
#         a=$(read_number "Base a" "$LAST_RES")
#         b=$(read_number "Exponent b" "")
#         res=$(calc "$a ^ $b") || { err "Failed."; continue; }
#         ok "$a ^ $b = $res"
#         LAST_RES="$res"; store_history "$a ^ $b = $res"
#         ;;
#     7)  # sqrt
#         a=$(read_number "Enter a" "$LAST_RES")
#         if [[ "$a" == -*([0-9.]) ]]; then err "sqrt of negative not supported (real numbers)."; continue; fi
#         res=$(calc "sqrt($a)") || { err "Failed."; continue; }
#         ok "√$a = $res"
#         LAST_RES="$res"; store_history "sqrt($a) = $res"
#         ;;
#     8)  # abs
#         a=$(read_number "Enter a" "$LAST_RES")
#         res=$(calc "if($a<0){-$a}else{$a}") || { err "Failed."; continue; }
#         ok "|$a| = $res"
#         LAST_RES="$res"; store_history "abs($a) = $res"
#         ;;
#     9)  # percentage: a % of b  -> (a/100)*b
#         a=$(read_number "Enter percent (a)" "")
#         b=$(read_number "Of number (b)" "$LAST_RES")
#         res=$(calc "($a/100)*$b") || { err "Failed."; continue; }
#         ok "$a%% of $b = $res"
#         LAST_RES="$res"; store_history "$a% of $b = $res"
#         ;;
#     10) # average of N numbers (space-separated)
#         read -r -p "Enter numbers separated by spaces: " line
#         # validate at least one number
#         nums=($line)
#         if ((${#nums[@]}==0)); then err "Provide at least one number."; continue; fi
#         sum=0; count=0
#         for n in "${nums[@]}"; do
#           if ! is_number "$n"; then err "Invalid number: $n"; sum=""; break; fi
#           sum=$(calc "$sum + $n"); count=$((count+1))
#         done
#         [[ -z "$sum" ]] && continue
#         res=$(calc "$sum / $count") || { err "Failed."; continue; }
#         ok "avg(${nums[*]}) = $res"
#         LAST_RES="$res"; store_history "avg(${nums[*]}) = $res"
#         ;;
#     *)
#         err "Invalid option. Type '?' for help."
#         ;;
#   esac
# done

