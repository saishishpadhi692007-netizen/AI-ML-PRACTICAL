% =================================================================
% HILL CLIMBING SEARCH ALGORITHM
% =================================================================

% Main entry point: Start hill climbing from a node
% Usage: hill_climbing(StartNode, Path, FinalNode).
hill_climbing(Start, Path, FinalNode) :-
    h(Start, StartVal),
    % Keep track of visited nodes to prevent any cycles
    search_climb(Start, StartVal, [Start], Path, FinalNode).

% -----------------------------------------------------------------
% Core Local Search Logic
% -----------------------------------------------------------------

% Case 1: Find all neighbors, check if there's a better one.
search_climb(Current, CurrentVal, Visited, Path, FinalNode) :-
    % Generate all valid neighbors not already visited
    findall(
        Val-Next,
        (move(Current, Next), \+ member(Next, Visited), h(Next, Val)),
        Neighbors
    ),
    % If neighbors exist, check if the best one is an improvement
    Neighbors \= [],
    keysort(Neighbors, [BestVal-BestNext|_]), % Sorts ascending (lowest value first)
    BestVal < CurrentVal,                      % Strict improvement check
    !,
    % Move to the better neighbor recursively
    search_climb(BestNext, BestVal, [BestNext|Visited], Path, FinalNode).

% Case 2: Base Case (Local Optimum Reached)
% If no better neighbor is found, stop here.
search_climb(Current, _, Visited, Path, Current) :-
    reverse(Visited, Path).


% =================================================================
% SAMPLE GRAPH KNOWLEDGE BASE (For Testing Optimization)
% =================================================================
% Directed connections: move(CurrentNode, NeighborNode)
move(a, b).
move(a, c).
move(b, d).
move(b, e).
move(c, f).
move(d, g).
move(e, g).

% Heuristic cost function h(Node, Cost).
% Lower values represent states closer to the optimal solution.
h(a, 12).
h(b, 10).
h(c, 11).
h(d, 6).
h(e, 8).
h(f, 9).
h(g, 2).   % Global optimum / target low cost
