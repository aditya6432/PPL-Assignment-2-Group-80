#!/usr/bin/env bash
# Tests for S1 (code/80_q3.rkt). Run from anywhere: bash tests/test_s1.sh
# Like the grader, each test appends calls to a copy of the solution file.
set -uo pipefail
cd "$(dirname "$0")/.."
FILE=code/80_q3.rkt
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
fails=0

# run_case NAME CALLS EXPECTED : appends CALLS to a copy of the file, runs it,
# and compares stdout byte for byte (including the final newline).
run_case() {
  cp "$FILE" "$tmp/case.rkt"
  printf '\n%s\n' "$2" >> "$tmp/case.rkt"
  racket "$tmp/case.rkt" > "$tmp/actual" 2>&1
  printf '%s\n' "$3" > "$tmp/expected"
  if cmp -s "$tmp/actual" "$tmp/expected"; then printf 'PASS  %s\n' "$1"
  else printf 'FAIL  %s\n' "$1"; diff "$tmp/expected" "$tmp/actual" | head -20; fails=$((fails + 1)); fi
}

# Loading the file alone prints nothing.
if [ -z "$(racket "$FILE" 2>&1)" ]; then echo "PASS  file loads silently"; else echo "FAIL  file loads silently"; fails=$((fails + 1)); fi

T1="(define t1 '(4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ()))))"

# --- Official examples ---------------------------------------------------------
run_case "t1: print-inorder" "$T1
(print-inorder t1)" "(1 2 3 4 5 6 7)"
run_case "t1: print-all-traversals" "$T1
(print-all-traversals t1)" "$(printf '%s\n' '(1 2 3 4 5 6 7)' '(4 2 1 3 6 5 7)' '(1 3 2 5 7 6 4)')"
run_case "t1: print-height-and-leaves" "$T1
(print-height-and-leaves t1)" "(3 4)"
run_case "t2: traversals, height and leaves" "(print-all-traversals '(1 () (2 () (3 () ()))))
(print-height-and-leaves '(1 () (2 () (3 () ()))))" "$(printf '%s\n' '(1 2 3)' '(1 2 3)' '(3 2 1)' '(3 1)')"
run_case "t3: traversals, height and leaves (symbols)" "(print-all-traversals '(a (b () ()) (c () ())))
(print-height-and-leaves '(a (b () ()) (c () ())))" "$(printf '%s\n' '(b a c)' '(a b c)' '(b c a)' '(2 2)')"
run_case "empty tree: all three functions" "(print-inorder '())
(print-all-traversals '())
(print-height-and-leaves '())" "$(printf '%s\n' '()' '()' '()' '()' '(0 0)')"

# --- Own edge cases --------------------------------------------------------------
run_case "single node" "(print-inorder '(x () ()))
(print-all-traversals '(x () ()))
(print-height-and-leaves '(x () ()))" "$(printf '%s\n' '(x)' '(x)' '(x)' '(x)' '(1 1)')"
run_case "left-skewed tree" "(print-all-traversals '(5 (3 (1 () ()) ()) ()))
(print-height-and-leaves '(5 (3 (1 () ()) ()) ()))" "$(printf '%s\n' '(1 3 5)' '(5 3 1)' '(1 3 5)' '(3 1)')"
run_case "node with one child and mixed values" "(print-all-traversals '(-3 (z () ()) (10 (q () ()) ())))
(print-height-and-leaves '(-3 (z () ()) (10 (q () ()) ())))" "$(printf '%s\n' '(z -3 q 10)' '(-3 z 10 q)' '(z q 10 -3)' '(3 2)')"

# --- Large skewed trees (10,000 nodes) ---------------------------------------------
# Left chain: root 10000, left child 9999, ..., 1.  Right chain: root 10000,
# right child 9999, ..., 1.
UP="($(seq -s ' ' 1 10000))"
DOWN="($(seq -s ' ' 10000 -1 1))"
CHAINS="(define (left-chain i n acc) (if (> i n) acc (left-chain (+ i 1) n (list i acc '()))))
(define (right-chain i n acc) (if (> i n) acc (right-chain (+ i 1) n (list i '() acc))))"
run_case "10,000-node left chain" "$CHAINS
(print-all-traversals (left-chain 1 10000 '()))
(print-height-and-leaves (left-chain 1 10000 '()))" "$(printf '%s\n' "$UP" "$DOWN" "$UP" '(10000 1)')"
run_case "10,000-node right chain" "$CHAINS
(print-all-traversals (right-chain 1 10000 '()))
(print-height-and-leaves (right-chain 1 10000 '()))" "$(printf '%s\n' "$DOWN" "$DOWN" "$UP" '(10000 1)')"

if [ "$fails" -eq 0 ]; then printf 'S1 tests passed\n'; else printf 'S1: %d test(s) FAILED\n' "$fails"; exit 1; fi
