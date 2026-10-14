% =================================================================
% A* SEARCH ALGORITHM IMPLEMENTATION
% =================================================================

% Main entry point: Find path from Start to Goal
% Usage: a_star(start_node, goal_node, Path, TotalCost).
a_star(Start, Goal, Path, Cost) :-
    h(Start, H),
    % Open list holds paths in the format: path(F_Value, G_Value, [CurrentNode | VisitedNodes])
    astar_search([path(H, 0, [Start])], Goal, RevPath, Cost),
    reverse(RevPath, Path).

% -----------------------------------------------------------------
% Core Search Logic
% -----------------------------------------------------------------
% Base Case: If the path with the lowest F-value reaches the Goal, we are done!
astar_search([path(_, Cost, [Goal|Rest])|_], Goal, [Goal|Rest], Cost) :- !.

% Recursive Case: Expand the node at the front of the sorted Open list
astar_search([path(_, G, [Node|Rest])|RemainingOpen], Goal, BestPath, FinalCost) :-
    findall(
        path(F_new, G_new, [Next, Node|Rest]),
        (
            connected(Node, Next, StepCost),      % Move to a connected node
            \+ member(Next, [Node|Rest]),         % Avoid cycles / loops
            G_new is G + StepCost,                % Calculate new path cost g(n)
            h(Next, H_new),                       % Fetch heuristic estimate h(n)
            F_new is G_new + H_new                % f(n) = g(n) + h(n)
        ),
        NewPaths
    ),
    append(RemainingOpen, NewPaths, CombinedOpen),
    sort_open(CombinedOpen, SortedOpen),
    astar_search(SortedOpen, Goal, BestPath, FinalCost).

% -----------------------------------------------------------------
% Helper Rules: Stable Sorting by F-Value (using built-in keysort)
% -----------------------------------------------------------------
sort_open(OpenList, SortedList) :-
    map_to_pairs(OpenList, Pairs),
    keysort(Pairs, SortedPairs),
    pairs_to_list(SortedPairs, SortedList).

map_to_pairs([], []).
map_to_pairs([path(F, G, P)|T], [F-path(F, G, P)|RT]) :-
    map_to_pairs(T, RT).

pairs_to_list([], []).
pairs_to_list([_-P|T], [P|RT]) :-
    pairs_to_list(T, RT).


% =================================================================
% SAMPLE GRAPH KNOWLEDGE BASE (For Testing)
% =================================================================
% Undirected connections: edge(Node1, Node2, StepCost)
edge(s, a, 1).
edge(s, b, 4).
edge(a, b, 2).
edge(a, c, 5).
edge(b, c, 2).
edge(b, g, 6).
edge(c, g, 1).

% Rule to handle bidirectional movement smoothly
connected(X, Y, Cost) :- edge(X, Y, Cost).
connected(X, Y, Cost) :- edge(Y, X, Cost).

% Heuristic values to target Goal 'g': h(Node, EstimatedCost)
h(s, 7).
h(a, 6).
h(b, 4).
h(c, 1).
h(g, 0).
