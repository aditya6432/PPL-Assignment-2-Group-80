:- use_module(library(lists), [permutation/2, member/2, append/3]).

% A full assignment: every department, language and project occurs exactly once.
possible_solution([
    p('Alex', D1, L1, P1),
    p('Ben', D2, L2, P2),
    p('Carla', D3, L3, P3),
    p('Dana', D4, L4, P4)
]) :-
    permutation([research, development, design, testing], [D1, D2, D3, D4]),
    permutation([python, java, 'c++', javascript], [L1, L2, L3, L4]),
    permutation(['AI', web, embedded, data], [P1, P2, P3, P4]).

clue(1, Solution) :-
    member(p(Name, Dept, _, 'AI'), Solution),
    Name \= 'Dana', Dept \= research.

clue(2, Solution) :-
    member(p('Alex', Dept, Lang, _), Solution),
    Dept \= development,
    Lang \= 'c++'.

clue(3, Solution) :-
    member(p(_, testing, python, _), Solution).

clue(4, Solution) :-
    member(p('Ben', Dept, _, web), Solution),
    Dept \= testing.

clue(5, Solution) :-
    member(p(_, design, java, _), Solution).

clue(6, Solution) :-
    member(p('Carla', Dept, _, Project), Solution),
    Project \= embedded,
    Dept \= development.

clue(7, Solution) :-
    member(p('Dana', Dept, Lang, _), Solution),
    Lang \= java,
    member(Dept, [research, testing]).

clue(8, Solution) :-
    member(p(_, research, Lang, data), Solution),
    Lang \= javascript.

% CLUE 9: In the required output order, the AI-project friend comes before the web-project friend.
clue(9, Solution) :-
    append(_, [p(_, _, _, 'AI') | AfterAI], Solution),
    member(p(_, _, _, web), AfterAI).

satisfies_clues([], _).
satisfies_clues([N | Rest], Solution) :-
    clue(N, Solution),
    satisfies_clues(Rest, Solution).

solution_for(Active, Solution) :-
    possible_solution(Solution),
    satisfies_clues(Active, Solution).

count_solutions(Active, N) :-
    findall(Solution, solution_for(Active, Solution), Solutions),
    length(Solutions, N).

print_solution([]).
print_solution([p(Name, Dept, Lang, Project) | Rest]) :-
    format('~a = [~a, ~a, ~a]~n', [Name, Dept, Lang, Project]),
    print_solution(Rest).

main :-
    once(solution_for([1,2,3,4,5,6,7,8,9], Solution)),
    print_solution(Solution).
