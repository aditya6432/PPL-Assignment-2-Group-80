# P1: Count of solutions and ninth clue

For the eight original clues, the answer to P1.b is **N = 3**.

This means the puzzle is not uniquely solvable as written: three different fully filled-in friend assignments satisfy clues 1 to 8.

The three solutions are:

| Friend | Solution 1 | Solution 2 | Solution 3 |
| --- | --- | --- | --- |
| Alex | design, java, AI | design, java, embedded | testing, python, embedded |
| Ben | development, javascript, web | development, javascript, web | development, javascript, web |
| Carla | research, c++, data | testing, python, AI | design, java, AI |
| Dana | testing, python, embedded | research, c++, data | research, c++, data |

## Ninth clue

The clause `clue(9, Solution)` implements this sentence:

> In the required output order, the AI-project friend comes before the web-project friend.

It refers to friends only by project preferences and does not name any friend. It keeps Solution 1 and removes Solutions 2 and 3. Consequently,
`count_solutions([1,2,3,4,5,6,7,8,9], N)` yields **N = 1**.

**Interpretation caution:** The distinction above relies on the *required ordering of friends in the solution list*. Solutions 1 and 3 have identical sets of `(Department, Language, Project)` triples, with those triples assigned to different named friends. No extra clue depending *only* on attribute triples—and not on names, positions, or other external properties—could distinguish those two solutions. If the instructor intended the ninth clue to be a conventional order-independent logic-puzzle clue, clarification is necessary.
