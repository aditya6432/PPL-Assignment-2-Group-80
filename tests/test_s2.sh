#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

test_file="$(mktemp --suffix=.rkt)"
trap 'rm -f "$test_file"' EXIT
cp code/80_q4.rkt "$test_file"
printf '%s\n' \
  '(display (insert-if-short 42 (quote ((1 2) (3 4 5) (6) ())) 3)) (newline)' \
  '(display (insert-if-short 0 (quote (((1) 2) (3) ((4 5 6) ()))) 3)) (newline)' \
  '(display (insert-if-short 7 (quote ()) 3)) (newline)' \
  '(display (insert-if-short 7 (quote ()) 0)) (newline)' \
  '(display ((make-inserter (quote x) (lambda (k) (= k 1))) (quote ((a) (b c) ())))) (newline)' \
  '(define long-list (let loop ((i 0) (acc (quote ()))) (if (= i 10000) acc (loop (+ i 1) (cons (quote y) acc)))))' \
  '(display (my-length (insert-if-short 9 long-list 2))) (newline)' \
  '(define deep-list (let loop ((i 100) (acc (quote ()))) (if (= i 0) acc (loop (- i 1) (list acc)))))' \
  '(display (my-length (insert-if-short 9 deep-list 0))) (newline)' >> "$test_file"

actual="$(racket "$test_file")"
expected="$(printf '%s\n' \
  '((42 1 2) (3 4 5) (42 6) (42))' \
  '((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))' \
  '(7)' \
  '()' \
  '((x a) (b c) ())' \
  '10000' \
  '1')"
test "$actual" = "$expected"
printf 'S2 tests passed\n'
