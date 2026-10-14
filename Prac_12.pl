% =================================================================
% N-QUEENS PROBLEM VIA CSP BACKTRACKING
% =================================================================

% Main entry point: n_queens(+N, -Solution)
% Usage: n_queens(4, Solution).
n_queens(N, Solution) :-
    length(Solution, N),             % Create a list of N variables (rows)
    numlist(1, N, Domain),           % Domain of valid columns: [1, 2, ..., N]
    place_queens(Solution, Domain, []).

% -----------------------------------------------------------------
% Backtracking Placement Logic
% -----------------------------------------------------------------
% Base case: All queens placed successfully
place_queens([], _, _).

% Recursive case: Pick a column for the current row and check constraints
place_queens([Q|Rest], Domain, PlacedUpToNow) :-
    member(Q, Domain),               % Try assigning a column from the domain (Choices)
    safe(Q, PlacedUpToNow, 1),       % Enforce CSP constraints against previous queens
    place_queens(Rest, Domain, [Q|PlacedUpToNow]).

% -----------------------------------------------------------------
% CSP Constraint Checking
% -----------------------------------------------------------------
% Base case: A queen is always safe against an empty board
safe(_, [], _).

% Recursive case: Ensure the current queen doesn't attack the previous ones
safe(Q, [Q1|Rest], Dist) :-
    Q =\= Q1,                        % Constraint 1: Not in the same column
    Q - Q1 =\= Dist,                 % Constraint 2: Not in the same diagonal (\)
    Q1 - Q =\= Dist,                 % Constraint 3: Not in the same diagonal (/)
    NextDist is Dist + 1,
    safe(Q, Rest, NextDist).
