---
name: prolog-dev
description: Develop and review small SWI-Prolog 9.x predicates for the CS F301 logic-programming assignment, keeping each AI request limited to one predicate or test/review unit.
---

# Prolog development rules

- Use SWI-Prolog 9.x. Define predicates declaratively; use lowercase snake_case names and descriptive variables beginning with capitals.
- Keep predicates pure when possible: no `assert`, `retract`, global variables, initialization directives, or calls to `halt/0`.
- Only use libraries `lists`, `apply`, `yall`, and `aggregate` if needed. The grader loads a file with `-f`, then calls a goal with `-g`.
- For the department puzzle, model all four attribute assignments as permutations and apply each numbered clue separately to a *fully instantiated* solution.
- For the equation generator, maintain ordered input leaves, require exact integer division at every subexpression, and render expression trees without reparsing output strings.
- Keep ordinary code files silent when loaded. Limit printing to the explicitly requested `main/0` predicate.
- Comment convention: above every predicate write a `%` comment giving its declarative reading, in the form "`pred(X, Y)` holds when ...". Above each puzzle clue clause, write the English text of the clue (clue 9 must use exactly `% CLUE 9:` on the line directly above it).

## Run and test

`swipl -q -f code/80_q1.pl -g main -t halt`

`swipl -q -f code/80_q1.pl -g "count_solutions([1,2,3,4,5,6,7,8],N),write(N)" -t halt`

`swipl -q -f code/80_q2.pl -g "all_equations([4,2,5,3],Es),write(Es)" -t halt`

`bash tests/test_p1.sh` and `bash tests/test_p2.sh` run all checks and print PASS/FAIL per check.

Run the independent scripts in `tests/` too; include unsatisfiable lists, empty inputs, repetitions, negative intermediate values, and the exact canonical-string examples.

## Before every answer

1. Address only the one predicate, test file, or review requested in the current AI prompt.
2. Verify all argument orders and that failure is clean when no solutions exist.
3. Check enumeration for missing cases and accidental duplicates.
4. Check that output uses a genuine Prolog string and is formatted exactly.
5. Flag unproven assumptions or incomplete runtime validation.
6. Check that `swipl -q -f FILE -g true -t halt` prints nothing (no singleton or discontiguous warnings).
7. For a puzzle clue, confirm by running `count_solutions/2` (not by reasoning alone) that it is true in the solution kept and false in every other one.

## Typical AI failure modes

- Confusing atoms with strings (`'AI'` is an atom, `"AI"` is a string).
- Using negation while variables remain unbound; test clues only after assignments are complete.
- Accidentally creating duplicates or treating permutations as combinations.
- Applying truncating division instead of exact integer division.
- Relying on operator associativity when printing: the right child needs parentheses for equal precedence.
- Calling `halt/0` or printing debug output that breaks the grader.
- Writing a puzzle clue that depends on names or on positions in the fixed Alex, Ben, Carla, Dana list. A position is a name in disguise; a clue may refer to friends only through attribute values. Before choosing which solution to keep, compare the (Dept, Lang, Project) triples of the candidate solutions: solutions with the same set of triples cannot be told apart by any attribute-only clue.
- Counting a solution twice with `findall/3` because a clue can succeed in more than one way.
- Leaving singleton variables, which print warnings on load that the grader sees.
