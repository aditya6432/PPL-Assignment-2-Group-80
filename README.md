# CS F301 Assignment 2 — working repository

This project is a **draft** and **not yet a submission-ready GitHub repository**.

## Required before submission

1. Replace the filename prefix `id` in all four files under `code/` with the **actual group ID**. Update references in `tests/` and `skills/` accordingly.
2. Install and run SWI-Prolog **9.x** and Racket **8.x**; the local authoring environment did not contain these interpreters, so language-runtime tests could not be executed here.
3. Run the independent test scripts: `bash tests/test_p1.sh`, `bash tests/test_p2.sh`, `bash tests/test_s1.sh`, `bash tests/test_s2.sh`. Scripts must pass before submission.
4. Resolve the P1 clue-9 ordering caveat with the TA if an order-dependent clue is not considered valid.
5. Complete `prompts/P1.md`, `P2.md`, `S1.md`, and `S2.md` with **only authentic, word-for-word AI requests**. The present global request does *not* satisfy the required one-unit-per-prompt rule.
6. Ask group members to make and explain **their own** substantive Git commits. Do not falsely attribute automated edits to a student.
7. Push the repository to GitHub. Submit **the GitHub repository URL**, not a ZIP.

## Grader commands

```sh
swipl -q -f code/80_q1.pl -g main -t halt
swipl -q -f code/80_q1.pl -g 'count_solutions([1,2,3,4,5,6,7,8],N),write(N)' -t halt
swipl -q -f code/80_q2.pl -g 'all_equations([4,2,5,3],Es),write(Es)' -t halt
racket code/80_q3.rkt
racket code/80_q4.rkt
```

The two Racket files must print nothing when loaded; the grader appends its own calls.

## Important timing discrepancy

The email says the assignment starts at **1 PM on 22 November** and allows **12 hours** (which would imply 1 AM on 23 November). The PDF separately states **13–24 Hrs on 22 November**, which implies midnight. Treat the earlier deadline as operative unless clarified by teaching staff.
