#!/usr/bin/env bash
# Tests for S2 (code/80_q4.rkt). Run from anywhere: bash tests/test_s2.sh
# Like the grader, calls are appended to a copy of the solution file; S2.a is
# tested by appending (print-insert-result) and feeding standard input.
set -uo pipefail
cd "$(dirname "$0")/.."
FILE=code/80_q4.rkt
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
fails=0

report() {  # report NAME : compares $tmp/actual with $tmp/expected byte for byte
  if cmp -s "$tmp/actual" "$tmp/expected"; then printf 'PASS  %s\n' "$1"
  else printf 'FAIL  %s\n' "$1"; diff "$tmp/expected" "$tmp/actual" | cut -c1-200 | head -10; fails=$((fails + 1)); fi
}
# stdin_case NAME INPUT EXPECTED : runs (print-insert-result) with INPUT on stdin.
stdin_case() {
  printf '%s' "$2" | racket "$tmp/stdin.rkt" > "$tmp/actual" 2>&1
  printf '%s\n' "$3" > "$tmp/expected"
  report "$1"
}
# call_case NAME CALLS EXPECTED : appends CALLS to a copy of the file.
call_case() {
  cp "$FILE" "$tmp/calls.rkt"
  printf '\n%s\n' "$2" >> "$tmp/calls.rkt"
  racket "$tmp/calls.rkt" < /dev/null > "$tmp/actual" 2>&1
  printf '%s\n' "$3" > "$tmp/expected"
  report "$1"
}

if [ -z "$(racket "$FILE" < /dev/null 2>&1)" ]; then echo "PASS  file loads silently"; else echo "FAIL  file loads silently"; fails=$((fails + 1)); fi
cp "$FILE" "$tmp/stdin.rkt"
printf '\n(print-insert-result)\n' >> "$tmp/stdin.rkt"

# --- S2.a: official examples through standard input -----------------------------
stdin_case "official 1 (stdin)" '42 ((1 2) (3 4 5) (6) ()) 3' '((42 1 2) (3 4 5) (42 6) (42))'
stdin_case "official 2 (stdin)" '0 (((1) 2) (3) ((4 5 6) ())) 3' '((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))'
stdin_case "official 3 (stdin)" '7 () 3' '(7)'
stdin_case "official 4 (stdin)" '7 () 0' '()'
stdin_case "input split over several lines" $'42\n((1 2) (3 4 5) (6) ())\n3\n' '((42 1 2) (3 4 5) (42 6) (42))'

# --- Own cases through standard input -------------------------------------------
stdin_case "n = 1: only empty lists grow" 'z (a (b) (c d e)) 1' '(a (b) (c d e))'
stdin_case "n = 2"                         'z (a (b) (c d e)) 2' '(a (z b) (c d e))'
stdin_case "n = 4: every list grows"       'z (a (b) (c d e)) 4' '(z a (z b) (z c d e))'
stdin_case "length equal to n is not short" '9 (1 2 3) 3' '(1 2 3)'
stdin_case "length one less than n"         '9 (1 2 3) 4' '(9 1 2 3)'
stdin_case "nested empty lists"             'q (() (()) ((()))) 2' '((q) (q (q)) (q (q (q))))'
stdin_case "symbol as x"                    'hello (a b) 5' '(hello a b)'

# --- S2.b / S2.c: helpers and make-inserter called directly ---------------------
call_case "insert-if-short on the official examples" \
"(display (insert-if-short 42 '((1 2) (3 4 5) (6) ()) 3)) (newline)
(display (insert-if-short 0 '(((1) 2) (3) ((4 5 6) ())) 3)) (newline)
(display (insert-if-short 7 '() 3)) (newline)
(display (insert-if-short 7 '() 0)) (newline)" \
"$(printf '%s\n' '((42 1 2) (3 4 5) (42 6) (42))' '((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))' '(7)' '()')"
call_case "my-length and my-map" \
"(display (my-length '())) (newline)
(display (my-length '(a (b c) () d))) (newline)
(display (my-map (lambda (v) (* v v)) '(1 2 3 4))) (newline)
(display (my-map (lambda (v) v) '())) (newline)" \
"$(printf '%s\n' '0' '4' '(1 4 9 16)' '()')"
call_case "make-inserter with other predicates" \
"(display ((make-inserter 'x (lambda (k) (= k 1))) '((a) (b c) ()))) (newline)
(display ((make-inserter 'k (lambda (k) (> k 2))) '(1 (2 3 4) (5) ()))) (newline)
(display ((make-inserter 'k (lambda (k) (= k 0))) '())) (newline)" \
"$(printf '%s\n' '((x a) (b c) ())' '(k 1 (k 2 3 4) (5) ())' '(k)')"

# --- Hidden-test sizes: nesting depth 100 and lists of 10,000 elements ----------
deep="()";      for i in $(seq 99); do deep="($deep)"; done        # 100 nested lists
deep_n2="(x)";  for i in $(seq 99); do deep_n2="(x $deep_n2)"; done # every level grows
deep_n1="(x)";  for i in $(seq 99); do deep_n1="($deep_n1)"; done   # only the innermost grows
stdin_case "depth 100, n = 2 (insert at every level)" "x $deep 2" "$deep_n2"
stdin_case "depth 100, n = 1 (insert at the innermost level only)" "x $deep 1" "$deep_n1"
stdin_case "depth 100, n = 0 (no insertion)" "x $deep 0" "$deep"

flat="($(seq -s ' ' 1 10000))"
stdin_case "10,000 elements, n = 10001 (inserted)"      "x $flat 10001" "(x $(seq -s ' ' 1 10000))"
stdin_case "10,000 elements, n = 10000 (not inserted)"  "x $flat 10000" "$flat"
subs="($(seq 1 10000 | sed 's/.*/(&)/' | paste -sd ' '))"
stdin_case "10,000 one-element sublists, n = 2"         "x $subs 2" "($(seq 1 10000 | sed 's/.*/(x &)/' | paste -sd ' '))"

if [ "$fails" -eq 0 ]; then printf 'S2 tests passed\n'; else printf 'S2: %d test(s) FAILED\n' "$fails"; exit 1; fi
