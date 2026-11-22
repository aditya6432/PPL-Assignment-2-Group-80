#!/usr/bin/env bash
# Tests for P2 (code/80_q2.pl). Run from anywhere: bash tests/test_p2.sh
# Expected lists for the extra cases were produced by a separate brute-force
# program written from the assignment text, and spot-checked by hand.
set -uo pipefail
cd "$(dirname "$0")/.."
FILE=code/80_q2.pl
fails=0

# check NAME GOAL : the goal must succeed with no output and no exception.
check() {
  local out
  out="$(timeout 60 swipl -q -f "$FILE" -g "catch(($2), E, (print_message(error, E), fail))" -t halt 2>&1)"
  if [ $? -eq 0 ] && [ -z "$out" ]; then printf 'PASS  %s\n' "$1"
  else printf 'FAIL  %s\n%s\n' "$1" "$out"; fails=$((fails + 1)); fi
}

out="$(swipl -q -f "$FILE" -g true -t halt 2>&1)"
if [ -z "$out" ]; then echo "PASS  file loads silently"; else echo "FAIL  file loads silently: $out"; fails=$((fails + 1)); fi

# --- Official examples -------------------------------------------------------
OFFICIAL='["4*2-5=3","4*2=5+3","4-2=5-3","4/2=5-3","4=2*(5-3)","4=2+(5-3)","4=2+5-3"]'
check "all_equations([4,2,5,3]) = the seven official equations" "all_equations([4,2,5,3],Es), Es == $OFFICIAL"
check "count_equations([4,2,5,3]) = 7" 'count_equations([4,2,5,3],N), N == 7'
check "generate_equation([4,2,5,3]) gives one of the seven" "generate_equation([4,2,5,3],E), string(E), memberchk(E, $OFFICIAL)"
check "generate_equation([2,3,4]) fails" '\+ generate_equation([2,3,4],_)'
check "all_equations([2,3,4]) = []" 'all_equations([2,3,4],Es), Es == []'
check "all_equations([2,4,8]) = [\"2*4=8\"]" 'all_equations([2,4,8],Es), Es == ["2*4=8"]'

# --- Lists of length 0 and 1, and trivial lists ------------------------------
check "generate_equation([]) fails"  '\+ generate_equation([],_)'
check "generate_equation([5]) fails" '\+ generate_equation([5],_)'
check "all_equations([]) = []"       'all_equations([],Es), Es == []'
check "all_equations([5]) = []"      'all_equations([5],Es), Es == []'
check "count_equations([]) = 0"      'count_equations([],N), N == 0'
check "all_equations([0,0]) = [\"0=0\"]" 'all_equations([0,0],Es), Es == ["0=0"]'
check "all_equations([7,0]) = []"    'all_equations([7,0],Es), Es == []'

# --- Output type and form ----------------------------------------------------
check "every result is a string with exactly one = and no spaces" \
  'all_equations([2,5,3,0],Es), Es \== [], forall(member(E,Es), (string(E), split_string(E,"=","",[_,_]), \+ sub_string(E,_,_,_," ")))'
check "result is sorted by sort/2 and has no duplicates" 'all_equations([8,4,2,1],Es), sort(Es,S), S == Es'
check "generate_equation accepts a given valid equation" 'generate_equation([4,2,5,3],"4=2*(5-3)")'
check "generate_equation rejects a wrong equation"       '\+ generate_equation([4,2,5,3],"4=2*5-3")'

# --- Division rules ----------------------------------------------------------
check "inexact division is rejected (7/2=3 is not valid)" 'all_equations([7,2,3],Es), Es == []'
check "inexact division is rejected (6/4=1 is not valid)" 'all_equations([6,4,1],Es), Es == []'
check "division by zero is rejected, no error"            'all_equations([5,0,0],Es), Es == ["5*0=0"]'
check "all-zero list"   'all_equations([0,0,0],Es), Es == ["0*0=0","0+0=0","0-0=0","0=0*0","0=0+0","0=0-0"]'
check "exact division inside a sub-expression" 'all_equations([1,2,3,6],Es), Es == ["1*(2*3)=6","1*2*3=6","1+(2+3)=6","1+2+3=6","1=2*3/6"]'

# --- Negative intermediate values --------------------------------------------
check "negative intermediate value (2-5 = -3)" \
  'all_equations([2,5,3,0],Es), Es == ["2-(5-3)=0","2-5+3=0","2=5-(3+0)","2=5-(3-0)","2=5-3+0","2=5-3-0"]'
check "exact division of a negative value ((1-5)/2 = 0-2)" 'all_equations([1,5,2,0,2],Es), memberchk("(1-5)/2=0-2",Es)'

# --- Parenthesization rule ---------------------------------------------------
check "left operand with lower precedence is bracketed: (4+2)*3" 'all_equations([4,2,3,18],Es), Es == ["(4+2)*3=18"]'
check "right operand with same precedence is bracketed: 1-(2-3), 2-(3-2)" \
  'all_equations([1,2,3,2],Es), Es == ["1-(2-3)=2","1-2+3=2","1=2-(3-2)","1=2-3+2"]'
check "8/(4*2) vs 8/4/2 and 4*(2*1) vs 4*2*1 are different equations" \
  'all_equations([8,4,2,1],Es), Es == ["8/(4*2)=1","8/4/2=1","8/4=2*1","8/4=2/1","8=4*(2*1)","8=4*(2/1)","8=4*2*1","8=4*2/1"]'

# --- Larger inputs (must finish, not loop) -------------------------------------
check "count_equations([9,8,7,6,5,4,3]) = 442"     'count_equations([9,8,7,6,5,4,3],N), N == 442'
check "count_equations([1,2,3,4,5,6,7,8]) = 4804"  'count_equations([1,2,3,4,5,6,7,8],N), N == 4804'

if [ "$fails" -eq 0 ]; then printf 'P2 tests passed\n'; else printf 'P2: %d test(s) FAILED\n' "$fails"; exit 1; fi
