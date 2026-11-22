# CS F301 Assignment 2 — Group 80

This repository contains the solutions for CS F301
Principles of Programming Languages, Assignment 2.

## Assignment Solutions

### P1 — Prolog Logic Puzzle
File: `code/80_q1.pl`

- Implements the logic puzzle using Prolog.
- Provides a predicate to count valid solutions.
- Clues 1–8 produce 3 solutions.
- Adding clue 9 reduces the count to 1.
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

- Implements inorder traversal.
- Implements preorder traversal.
- Implements postorder traversal.
- Calculates binary-tree height.
- Counts leaf nodes.

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

All four test scripts passed during local verification.

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

The P1 ninth clue distinguishes solutions using the
relative positions of project attributes in the required
solution-list order.

This introduces a possible interpretation issue if the
ninth clue is expected to be independent of list ordering.

The issue is explained in `P1_REPORT.md`.

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
