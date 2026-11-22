---
name: scheme-dev
description: Develop and review one Racket 8.x Scheme function or test unit at a time for CS F301, respecting the assignment's restricted racket/base built-ins.
---

# Scheme development rules

- Use Racket 8.x and place `#lang racket/base` at the start of each code file.
- Allow only the Scheme forms and built-ins explicitly listed in Assignment 2. In S2, `read` is additionally permitted. Implement helpers for `length`, `map`, and `reverse` rather than using those built-ins.
- Use lowercase hyphenated function names, pure recursion, and `let`/`letrec` for local helpers.
- Keep program files definition-only. No `(provide ...)`, top-level test calls, prints on load, loops, mutation, vectors, hashes, or extra imports.
- Treat `()` as an empty tree in S1; in S2 it is a list with length zero and must be recursively transformed.
- For S2, measure each list's length before inserting elements. Implement tail-recursive helpers for long input lists where possible.

## Run and test

`racket code/80_q3.rkt`

`racket code/80_q4.rkt`

These programs should print nothing when loaded. Tests may construct temporary copies with calls appended to the end, matching the grader's behavior. Use the shell tests in `tests/` for standard cases and deep/long nested lists.

## Before every answer

1. Handle one function, one test file, or one review per AI prompt.
2. Inspect every called identifier against the allowed built-ins list.
3. Test empty, single-node, nested, and long-list cases.
4. Check output line endings and that state is passed through arguments.
5. Verify the 10,000-element S2 case avoids quadratic traversal overhead.

## Typical AI failure modes

- Using forbidden standard helpers (`length`, `append`, `map`, `reverse`, `filter`, `member`).
- Confusing an empty nested list with an atom.
- Computing length after insertion rather than on the original list.
- Reversing traversal order or failing to count a single node as height one.
- Using test calls, `provide`, or additional `require` forms in a grader-loaded source file.
- Infinite recursion when traversing empty lists or deeply nested data.
