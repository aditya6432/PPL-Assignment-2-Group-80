#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

swipl -q -f code/80_q1.pl \
  -g 'count_solutions([1,2,3,4,5,6,7,8],Three),Three=:=3,count_solutions([1,2,3,4,5,6,7,8,9],One),One=:=1' \
  -t halt

actual="$(swipl -q -f code/80_q1.pl -g main -t halt)"
expected="$(printf '%s\n' \
  'Alex = [design, java, AI]' \
  'Ben = [development, javascript, web]' \
  'Carla = [research, c++, data]' \
  'Dana = [testing, python, embedded]')"
test "$actual" = "$expected"
printf 'P1 tests passed\n'
