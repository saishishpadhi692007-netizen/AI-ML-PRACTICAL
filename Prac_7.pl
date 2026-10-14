% =========================================================================
% FACTS (Graph Connections & Heuristic Values)
% =========================================================================

% edge(NodeA, NodeB) - Directed links in the graph
edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, e).
edge(c, g).
edge(d, f).
edge(e, f).
edge(g, f).

% connected(X, Y) - Makes the graph undirected/bi-directional
connected(X, Y) :- edge(X, Y).
connected(X, Y) :- edge(Y, X).

% h(Node, Goal, EstimatedCost) - Straight-line heuristic distance to goal 'f'
h(a, f, 6).
% =========================================================================
% GRAPH DATABASE (Facts)
% =========================================================================
edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, e).
edge(c, g).
edge(d, f).
edge(e, f).
edge(g, f).

connected(X, Y) :- edge(X, Y).
connected(X, Y) :- edge(Y, X).

% Heuristic values h(Node, Goal, Value)
h(a, f, 6).
h(b, f, 4).
h(c, f, 5).
h(d, f, 2).
h(e, f, 1).
h(g, f, 4).
h(f, f, 0).

% =========================================================================
% GREEDY BEST-FIRST SEARCH LOGIC (Rules)
% =========================================================================
gbfs_path(Start, Goal, Path) :-
    h(Start, Goal, HValue),
    gbfs_queue([[HValue, [Start]]], Goal, [], RevPath),
    reverse(RevPath, Path).

% Base case
gbfs_queue([[_, [Goal | Rest]] | _], Goal, _, [Goal | Rest]).

% Recursive case
gbfs_queue([[_, [Current | Rest]] | Queue], Goal, Visited, Path) :-
    findall([HNext, [Next, Current | Rest]],
            (connected(Current, Next),
             \+ member(Next, Visited),
             \+ member(Next, [Current | Rest]),
             h(Next, Goal, HNext)),
            NewPaths),
    append(Queue, NewPaths, UnsortedQueue),
    keysort(UnsortedQueue, SortedQueue),
    gbfs_queue(SortedQueue, Goal, [Current | Visited], Path).
