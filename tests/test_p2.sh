#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

swipl -q -f code/80_q2.pl -g \
  'all_equations([4,2,5,3],Es),Es==["4*2-5=3","4*2=5+3","4-2=5-3","4/2=5-3","4=2*(5-3)","4=2+(5-3)","4=2+5-3"],count_equations([4,2,5,3],7)' -t halt

swipl -q -f code/80_q2.pl -g \
  'all_equations([2,3,4],[]),\+ generate_equation([2,3,4],_),all_equations([2,4,8],["2*4=8"]),all_equations([],[]),all_equations([5],[]),all_equations([0,0],["0=0"])' -t halt

printf 'P2 tests passed\n'
