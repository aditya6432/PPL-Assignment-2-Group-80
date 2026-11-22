#!/usr/bin/env bash
# Tests for P1 (code/80_q1.pl). Run from anywhere: bash tests/test_p1.sh
set -uo pipefail
cd "$(dirname "$0")/.."
FILE=code/80_q1.pl
fails=0

# check NAME GOAL : the Prolog goal must succeed (exit 0) with no output.
check() {
  local out
  out="$(swipl -q -f "$FILE" -g "$2" -t halt 2>&1)"
  if [ $? -eq 0 ] && [ -z "$out" ]; then printf 'PASS  %s\n' "$1"
  else printf 'FAIL  %s\n%s\n' "$1" "$out"; fails=$((fails + 1)); fi
}

# 1. Loading the file prints nothing and gives no warnings.
out="$(swipl -q -f "$FILE" -g true -t halt 2>&1)"
if [ -z "$out" ]; then echo "PASS  file loads silently"; else echo "FAIL  file loads silently: $out"; fails=$((fails + 1)); fi

# 2. P1.b counts. 13824 = 24^3 assignments; single-clue counts follow from
#    simple probabilities (clue 3: 1/4 of all, clue 7: 3/4 * 1/2 of all).
check "count_solutions([1..8]) = 3"  'count_solutions([1,2,3,4,5,6,7,8],N), N =:= 3'
check "count_solutions([1..9]) = 1"  'count_solutions([1,2,3,4,5,6,7,8,9],N), N =:= 1'
check "clue order does not matter"   'count_solutions([9,8,7,6,5,4,3,2,1],N), N =:= 1'
check "no clues = 13824"             'count_solutions([],N), N =:= 13824'
check "clue 3 alone = 3456"          'count_solutions([3],N), N =:= 3456'
check "clue 7 alone = 5184"          'count_solutions([7],N), N =:= 5184'
check "repeated clues not double-counted" 'count_solutions([1,1,2,2],A), count_solutions([1,2],B), A =:= B'

# 3. P1.c: clue 9 is true in the kept solution and false in the other two.
KEPT="[p('Alex',design,java,embedded),p('Ben',development,javascript,web),p('Carla',testing,python,'AI'),p('Dana',research,'c++',data)]"
OTHER1="[p('Alex',design,java,'AI'),p('Ben',development,javascript,web),p('Carla',research,'c++',data),p('Dana',testing,python,embedded)]"
OTHER2="[p('Alex',testing,python,embedded),p('Ben',development,javascript,web),p('Carla',design,java,'AI'),p('Dana',research,'c++',data)]"
check "the three solutions of clues 1-8 are exactly these" \
  "findall(S, (possible_solution(S), satisfies_clues([1,2,3,4,5,6,7,8],S)), L), msort(L, M), msort([$KEPT,$OTHER1,$OTHER2], M)"
check "every clue 1-9 holds in the kept solution" "forall(between(1,9,K), clue(K, $KEPT))"
check "clue 9 is false in the first discarded solution"  "\\+ clue(9, $OTHER1)"
check "clue 9 is false in the second discarded solution" "\\+ clue(9, $OTHER2)"

# 4. P1.c form: '% CLUE 9:' is on the line directly above clue(9, ...),
#    and the clue does not name any friend.
if grep -B1 '^clue(9,' "$FILE" | head -1 | grep -q '^% CLUE 9:'; then echo "PASS  % CLUE 9: comment directly above the clause"
else echo "FAIL  % CLUE 9: comment directly above the clause"; fails=$((fails + 1)); fi
clue9="$(awk '/^% CLUE 9:/{on=1} on{print} on && /\.[[:space:]]*$/ && !/^%/{exit}' "$FILE")"
if [ -n "$clue9" ] && ! grep -qE "Alex|Ben|Carla|Dana" <<<"$clue9"; then echo "PASS  clue 9 mentions no friend by name"
else echo "FAIL  clue 9 mentions no friend by name"; fails=$((fails + 1)); fi

# 5. P1.a: exact output of main (four lines, order Alex, Ben, Carla, Dana).
actual="$(swipl -q -f "$FILE" -g main -t halt 2>&1)"
expected="$(printf '%s\n' \
  'Alex = [design, java, embedded]' \
  'Ben = [development, javascript, web]' \
  'Carla = [testing, python, AI]' \
  'Dana = [research, c++, data]')"
if [ "$actual" = "$expected" ]; then echo "PASS  main output"
else printf 'FAIL  main output\n--- expected\n%s\n--- actual\n%s\n' "$expected" "$actual"; fails=$((fails + 1)); fi

if [ "$fails" -eq 0 ]; then printf 'P1 tests passed\n'; else printf 'P1: %d test(s) FAILED\n' "$fails"; exit 1; fi
