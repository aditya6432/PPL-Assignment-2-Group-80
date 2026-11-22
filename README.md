# CS F301 Assignment 2 — Group 80

This repository contains the solutions for CS F301
Principles of Programming Languages, Assignment 2.

## Assignment Solutions

### P1 — Prolog Logic Puzzle
File: `code/80_q1.pl`

- Implements the logic puzzle using Prolog.
- Provides a predicate to count valid solutions.
- Clues 1–8 produce 3 solutions.
- Clue 9 ("the friend who works in the testing department prefers
  the AI project") refers to friends only through attribute values
  and reduces the count to 1.
- The solution and ninth-clue explanation are documented
  in `P1_REPORT.md`.

### P2 — Prolog Equation Generation
File: `code/80_q2.pl`

- Generates valid arithmetic equations.
- Preserves the original order of input numbers.
- Uses exact integer arithmetic.
- Returns distinct equations in sorted order.
- Handles inputs for which no valid equation exists.

### S1 — Racket Binary Trees
File: `code/80_q3.rkt`

- Implements inorder, preorder and postorder traversals, each
  built in one pass with an accumulator (linear time).
- Calculates binary-tree height.
- Counts leaf nodes with an accumulator.

### S2 — Racket List Processing
File: `code/80_q4.rkt`

- Implements recursive processing of nested lists.
- Inserts an element into lists satisfying a length condition.
- Preserves the order of existing elements.
- Uses helper functions for length, mapping, and reversal.

## Testing

The repository includes four test scripts:

- `tests/test_p1.sh`
- `tests/test_p2.sh`
- `tests/test_s1.sh`
- `tests/test_s2.sh`

Run the tests from the repository directory:

```bash
bash tests/test_p1.sh
bash tests/test_p2.sh
bash tests/test_s1.sh
bash tests/test_s2.sh
```

Each script prints PASS or FAIL for every check and exits with a
non-zero status if any check fails. They cover the examples in the
assignment plus edge cases, large inputs (P2 lists of length 8, S1
trees of 10,000 nodes, S2 nesting depth 100 and 10,000-element lists),
and S2.a through standard input. All four scripts passed with
SWI-Prolog 9.0.4 and Racket 8.10.

## Running the Programs

Requirements:

- SWI-Prolog 9.x
- Racket 8.x

Example commands:

```bash
swipl -q -f code/80_q1.pl -g main -t halt

swipl -q -f code/80_q1.pl -g \
'count_solutions([1,2,3,4,5,6,7,8],N),writeln(N)' -t halt

swipl -q -f code/80_q1.pl -g \
'count_solutions([1,2,3,4,5,6,7,8,9],N),writeln(N)' -t halt

racket code/80_q3.rkt
racket code/80_q4.rkt
```

The Racket files define functions and produce no output
when loaded without additional function calls.

## AI Prompt Documentation

AI review prompts and their results are documented in:

- `prompts/P1.md`
- `prompts/P2.md`
- `prompts/S1.md`
- `prompts/S2.md`

The original broad request is preserved in
`prompts/REQUEST.md`.

The prompt records document the actual requests made
during the review process and the corresponding findings.

## Implementation Notes

Two of the three solutions of clues 1–8 contain the same
(department, language, project) triples, so no clue that uses only
attribute values can separate them. The ninth clue therefore keeps
Solution 2 of `P1_REPORT.md`, the only one an attribute-only clue can
single out. An earlier position-based ninth clue was replaced. See
`P1_REPORT.md`.

## Repository Structure

- `code/` — Prolog and Racket implementations
- `tests/` — Local test scripts
- `prompts/` — AI prompt records
- `skills/` — Language-specific development instructions
- `P1_REPORT.md` — P1 solution analysis

## Submission

GitHub repository:
https://github.com/aditya6432/PPL-Assignment-2-Group-80

Branch: `main`

The repository is private. Authorized instructors and
evaluators must be granted access for assessment.
