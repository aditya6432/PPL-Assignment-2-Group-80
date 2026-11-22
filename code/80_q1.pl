:- use_module(library(lists), [permutation/2, member/2]).

% A full assignment: every department, language and project occurs exactly once.
% Declarative reading: possible_solution(S) holds when S is a list of four
% p(Name, Dept, Lang, Project) terms in the order Alex, Ben, Carla, Dana in
% which each attribute is a permutation of its four values.
possible_solution([
    p('Alex', D1, L1, P1),
    p('Ben', D2, L2, P2),
    p('Carla', D3, L3, P3),
    p('Dana', D4, L4, P4)
]) :-
    permutation([research, development, design, testing], [D1, D2, D3, D4]),
    permutation([python, java, 'c++', javascript], [L1, L2, L3, L4]),
    permutation(['AI', web, embedded, data], [P1, P2, P3, P4]).

% Clue 1: The friend who prefers the AI project does not work in research
% and is not Dana.
clue(1, Solution) :-
    member(p(Name, Dept, _, 'AI'), Solution),
    Name \= 'Dana', Dept \= research.

% Clue 2: Alex does not work in development and does not prefer C++.
clue(2, Solution) :-
    member(p('Alex', Dept, Lang, _), Solution),
    Dept \= development,
    Lang \= 'c++'.

% Clue 3: The friend working in the testing department likes Python.
clue(3, Solution) :-
    member(p(_, testing, python, _), Solution).

% Clue 4: Ben prefers web projects and does not work in testing.
clue(4, Solution) :-
    member(p('Ben', Dept, _, web), Solution),
    Dept \= testing.

% Clue 5: The friend whose favorite language is Java works in design.
clue(5, Solution) :-
    member(p(_, design, java, _), Solution).

% Clue 6: Carla's project is not embedded and her department is not
% development.
clue(6, Solution) :-
    member(p('Carla', Dept, _, Project), Solution),
    Project \= embedded,
    Dept \= development.

% Clue 7: Dana's favorite language is not Java, and she works in research
% or testing.
clue(7, Solution) :-
    member(p('Dana', Dept, Lang, _), Solution),
    Lang \= java,
    member(Dept, [research, testing]).

% Clue 8: The friend who prefers data projects works in research and does
% not use JavaScript.
clue(8, Solution) :-
    member(p(_, research, Lang, data), Solution),
    Lang \= javascript.

% CLUE 9: The friend who works in the testing department prefers the AI project.
clue(9, Solution) :-
    member(p(_, testing, _, 'AI'), Solution).

% satisfies_clues(Clues, S) holds when every clue number in Clues holds in S.
satisfies_clues([], _).
satisfies_clues([N | Rest], Solution) :-
    clue(N, Solution),
    satisfies_clues(Rest, Solution).

% solution_for(Active, S) holds when S is a complete assignment that
% satisfies exactly the clues listed in Active (all other clues are ignored).
solution_for(Active, Solution) :-
    possible_solution(Solution),
    satisfies_clues(Active, Solution).

% count_solutions(Active, N) holds when N is the number of complete
% assignments that satisfy the clues in Active.
count_solutions(Active, N) :-
    findall(Solution, solution_for(Active, Solution), Solutions),
    length(Solutions, N).

% print_solution(S) prints one line "Name = [Dept, Lang, Project]" per friend.
print_solution([]).
print_solution([p(Name, Dept, Lang, Project) | Rest]) :-
    format('~a = [~a, ~a, ~a]~n', [Name, Dept, Lang, Project]),
    print_solution(Rest).

% main prints the one solution of clues 1 to 9 (it also satisfies clues 1 to 8).
main :-
    once(solution_for([1,2,3,4,5,6,7,8,9], Solution)),
    print_solution(Solution).
