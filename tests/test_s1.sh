#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

test_file="$(mktemp --suffix=.rkt)"
trap 'rm -f "$test_file"' EXIT
cp code/80_q3.rkt "$test_file"
printf '%s\n' \
  '(define t1 (quote (4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ())))))' \
  '(print-all-traversals t1)' \
  '(print-height-and-leaves t1)' \
  '(print-all-traversals (quote (1 () (2 () (3 () ())))))' \
  '(print-height-and-leaves (quote (1 () (2 () (3 () ())))))' \
  '(print-all-traversals (quote (a (b () ()) (c () ()))))' \
  '(print-height-and-leaves (quote (a (b () ()) (c () ()))))' \
  '(print-inorder (quote ()))' \
  '(print-height-and-leaves (quote ()))' >> "$test_file"

actual="$(racket "$test_file")"
expected="$(printf '%s\n' \
  '(1 2 3 4 5 6 7)' \
  '(4 2 1 3 6 5 7)' \
  '(1 3 2 5 7 6 4)' \
  '(3 4)' \
  '(1 2 3)' \
  '(1 2 3)' \
  '(3 2 1)' \
  '(3 1)' \
  '(b a c)' \
  '(a b c)' \
  '(b c a)' \
  '(2 2)' \
  '()' \
  '(0 0)')"
test "$actual" = "$expected"
printf 'S1 tests passed\n'
