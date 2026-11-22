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

## Run and test

`swipl -q -f code/id_q1.pl -g main -t halt`

`swipl -q -f code/id_q1.pl -g "count_solutions([1,2,3,4,5,6,7,8],N),write(N)" -t halt`

`swipl -q -f code/id_q2.pl -g "all_equations([4,2,5,3],Es),write(Es)" -t halt`

Run the independent scripts in `tests/` too; include unsatisfiable lists, empty inputs, repetitions, negative intermediate values, and the exact canonical-string examples.

## Before every answer

1. Address only the one predicate, test file, or review requested in the current AI prompt.
2. Verify all argument orders and that failure is clean when no solutions exist.
3. Check enumeration for missing cases and accidental duplicates.
4. Check that output uses a genuine Prolog string and is formatted exactly.
5. Flag unproven assumptions or incomplete runtime validation.

## Typical AI failure modes

- Confusing atoms with strings (`'AI'` is an atom, `"AI"` is a string).
- Using negation while variables remain unbound; test clues only after assignments are complete.
- Accidentally creating duplicates or treating permutations as combinations.
- Applying truncating division instead of exact integer division.
- Relying on operator associativity when printing: the right child needs parentheses for equal precedence.
- Calling `halt/0` or printing debug output that breaks the grader.
