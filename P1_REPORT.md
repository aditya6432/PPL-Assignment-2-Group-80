# P1 Report: number of solutions and the ninth clue

## P1.b: value of N for clues 1 to 8

```
swipl -q -f code/80_q1.pl -g "count_solutions([1,2,3,4,5,6,7,8],N), writeln(N)" -t halt
3
```

**N = 3.** Exactly three complete assignments satisfy clues 1 to 8:

| Friend | Solution 1 | Solution 2 | Solution 3 |
| --- | --- | --- | --- |
| Alex | design, java, AI | design, java, embedded | testing, python, embedded |
| Ben | development, javascript, web | development, javascript, web | development, javascript, web |
| Carla | research, c++, data | testing, python, AI | design, java, AI |
| Dana | testing, python, embedded | research, c++, data | research, c++, data |

### What N = 3 tells us about the puzzle

- The puzzle as given is **under-constrained**: clues 1 to 8 are consistent
  (N > 0), but they do not determine a unique answer (N > 1).
- Ben is fully determined (development, javascript, web in every solution).
  The uncertainty is only in how the remaining values are shared among Alex,
  Carla and Dana.
- Solutions 1 and 3 contain **exactly the same four (department, language,
  project) triples**: (design, java, AI), (development, javascript, web),
  (research, c++, data), (testing, python, embedded). They differ only in which
  friend holds which triple. Solution 2 has different triples:
  (design, java, embedded) and (testing, python, AI).

The second point decides how the puzzle can be repaired. A ninth clue may refer
to friends only through attribute values (as clue 5 does). Any such clue says
something only about the set of triples, so it is either true in both
Solutions 1 and 3 or false in both. Therefore **no allowed clue can keep
Solution 1 or Solution 3 alone; the only solution that can be kept is
Solution 2.**

## P1.c: the ninth clue

```prolog
% CLUE 9: The friend who works in the testing department prefers the AI project.
clue(9, Solution) :-
    member(p(_, testing, _, 'AI'), Solution).
```

- It mentions no friend by name and refers to friends only through attribute
  values (department and project), in the same style as clue 5.
- It is true in Solution 2 (Carla: testing, AI) and false in Solutions 1 and 3,
  where the testing friend prefers embedded.
- Other clues with the same effect: "the Python lover prefers AI", "the friend
  in design prefers embedded", "the Java lover prefers embedded". All of them
  keep Solution 2, as the argument above requires.

Result:

```
swipl -q -f code/80_q1.pl -g "count_solutions([1,2,3,4,5,6,7,8,9],N), writeln(N)" -t halt
1
swipl -q -f code/80_q1.pl -g main -t halt
Alex = [design, java, embedded]
Ben = [development, javascript, web]
Carla = [testing, python, AI]
Dana = [research, c++, data]
```

These numbers and the truth of clue 9 in each solution are checked by
`tests/test_p1.sh`.

## Note on an earlier version

An earlier version of clue 9 said "in the output order, the AI-project friend
comes before the web-project friend". It gave N = 1 but kept Solution 1, and it
depended on the fixed Alex, Ben, Carla, Dana order of the list rather than on
attribute values. Because clue 4 makes Ben the web friend, that clue only meant
"Alex prefers AI", which names a friend indirectly. It was replaced by the clue
above.
