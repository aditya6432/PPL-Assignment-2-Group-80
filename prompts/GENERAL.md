# General AI Prompt Record (prompts covering more than one problem)

AI tool: Claude (claude.ai), session of 22 November 2026.
The prompts below are copied word for word, in the order they were sent.
Problem-specific results are also recorded in P1.md, P2.md, S1.md and S2.md.

## Prompt G1 — Read-only compliance and testing review (22 November 2026, 21:35 IST)

The assignment PDF was attached to this prompt.

```text
@"/mnt/user-data/uploads/cb2b47e8-PPL_Assignment_2_Final_1.pdf" You are my expert coding, testing, and assignment-verification agent for CS F301 Principles of Programming Languages, Assignment 2.
GitHub repository:
https://github.com/aditya6432/PPL-Assignment-2-Group-80
Group ID: 80.
My objective is to achieve the highest possible marks through fully correct implementations, comprehensive testing, accurate documentation, and strict compliance with the official assignment PDF.
You must follow these instructions rigorously.

1. Read the complete attached assignment PDF. Treat it as the authoritative specification.
2. Inspect my existing GitHub repository before proposing any changes. The repository already contains solutions, tests, skill files, and AI prompt records. Preserve all correct existing work.
3. Your FIRST task is a read-only compliance and testing review. Do not rewrite the assignment or modify any code during this initial review.
4. Verify the required repository structure, filenames, language versions, permitted built-ins, output formats, skill-file requirements, and prompt-record requirements.
5. Inspect whether the existing tests cover the official examples and important edge cases. Run the available tests where the environment permits.
6. Pay particular attention to the P1 ninth-clue requirement, Prolog equation-generation correctness, Scheme output formatting, and nested-list performance.
7. Produce a precise checklist distinguishing VERIFIED, FAILED, UNVERIFIED, and POTENTIAL GRADING RISK. Never claim that a test passed without executing it.
8. The professor requires one AI prompt per unit of work. You must never solve an entire problem in response to one prompt.
9. After the initial review, propose at least eight separate, narrowly scoped follow-up prompts covering P1, P2, S1, and S2. Each proposed prompt must address only one predicate, one function, one test file, or one review.
10. Wait for me to send each follow-up prompt separately. Do not claim proposed prompts were actually sent.
11. For each subsequent task, work autonomously within its specified scope: inspect the relevant files, identify errors, make minimal valid corrections, execute relevant tests, and document the actual findings.
12. Preserve existing authentic AI prompt records. Append new prompts word for word only after I actually send them. Record real review findings and actual test results.
13. Make clear, narrowly scoped Git commits or reviewable pull requests for authorized changes. Never overwrite Git history or force-push.
14. Never hard-code expected answers, weaken tests, suppress errors, invent evidence, or introduce prohibited language features.
15. Never expose or commit credentials, access tokens, or private information.
16. Minimize unnecessary questions. Complete routine verification autonomously. Ask me only when permissions, missing information, or a genuine specification conflict prevents further progress.
17. Explain every unresolved risk honestly. Do not promise full marks without evidence.

For the INITIAL REVIEW, provide:
A. Repository structure compliance.
B. Status of P1, P2, S1, and S2.
C. Actual test commands executed and their results.
D. Missing edge cases and hidden-test risks.
E. Documentation and skill-file compliance.
F. Any contradictions or ambiguities in the assignment requirements.
G. A prioritized list of corrections, if necessary.
H. At least eight proposed one-unit follow-up prompts, clearly labeled as PROPOSED and not yet sent.
IMPORTANT: This first message authorizes a read-only review only. Do not modify code, generate a complete solution, or fabricate GitHub prompt history.
Begin by reading the PDF and inspecting the repository. Work carefully and report only what you can substantiate.
```

### Result (no files changed)

- All four existing test scripts passed (SWI-Prolog 9.0.4, Racket 8.10).
  All files load silently; no forbidden built-ins or Prolog constructs found.
- P1: clues 1-8 give 3 solutions; clue 9 gave N = 1 but depended on the
  order of friends in the list (equivalent to "Alex prefers AI"), not on
  attribute values. Solutions 1 and 3 contain the same attribute triples, so
  only Solution 2 can be kept by an attribute-only clue.
- P2: matched an independent brute-force program on 170 lists (524
  equations, 0 mismatches); all 8 bracketing examples render correctly.
- S1 and S2: correct on all official examples, the S2 stdin examples, depth
  100 and 10,000-element inputs. S1 traversals were quadratic on skewed trees.
- Test gaps: S2.a (stdin) never tested; two official S1 examples and the
  official generate_equation([4,2,5,3], E) example missing.
- Skill files lacked the declarative/recursive-reading convention.
- Eleven follow-up prompts were proposed (not sent).

## Prompt G2 — (22 November 2026, 21:47 IST)

```text
DO NA
```

### Result

Taken as approval of the first proposed prompt (clue 9). The request for
GitHub push access was denied, and the user interrupted before any file was
changed. No files changed.

## Prompt G3 — (22 November 2026, 21:49 IST)

```text
DO ALL YOURSELF AND THEN WE WIULL PUSH IT ON GITHUB REPO WITH ALL THE CORRECTNESS
```

### Result

This one prompt asked for all the proposed corrections at once, across all
four problems. The work was split into separate commits, one unit each, but
it came from a single prompt. Commits (oldest first):

| Commit | Unit |
| --- | --- |
| 122ea20 | P1: replace position-based clue 9 with an attribute-only clue |
| 104355f | P1: rewrite tests for counts, clue 9 and main output |
| 2ba65d7 | P1: rewrite report for N = 3 and the new clue 9 |
| 6e6dc1d | P2: extend tests with edge cases, division, negatives and bracketing |
| 9747fb3 | S1: extend tests with missing official examples and edge cases |
| 503eb83 | S2: test print-insert-result via stdin and full output at scale |
| f735844 | S1: compute inorder with an accumulator instead of my-append |
| 11fa037 | S1: compute preorder with an accumulator instead of my-append |
| 7e76735 | S1: compute postorder with an accumulator instead of my-append |
| d505bfe | S1: remove the unused my-append helper |
| 512aec7 | S1: count leaves with an accumulator |
| 6e5fecd | S1: add reading comments to tree-height and the print functions |
| bd28521 | P1: add declarative reading comments |
| 766cb3b | P2: add declarative reading comments |
| 1f08b3f | S2: add recursive reading comments |
| fa8c0d6 | Skills: prolog-dev convention and failure modes |
| bfc362d | Skills: scheme-dev convention and stdin testing |
| 5c11f7b | README update |

Test results after all changes (actual runs):

| Script | Checks passed | Checks failed |
| --- | --- | --- |
| tests/test_p1.sh | 15 | 0 |
| tests/test_p2.sh | 30 | 0 |
| tests/test_s1.sh | 12 | 0 |
| tests/test_s2.sh | 22 | 0 |
