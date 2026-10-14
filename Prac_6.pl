% =========================================================================
% FACTS (The Graph Database)
% =========================================================================

% edge(NodeA, NodeB) defines a directed relationship from NodeA to NodeB
edge(a, b).
edge(a, c).
edge(b, d).
edge(b, e).
edge(c, e).
edge(c, g).
edge(d, f).
edge(e, f).
edge(g, f).

% Bi-directional connection helper (in case you want an undirected graph)
connected(X, Y) :- edge(X, Y).
connected(X, Y) :- edge(Y, X).

% =========================================================================
% CLAUSES & RULES (Breadth-First Search Logic)
% =========================================================================

% shortest_path(Start, Goal, Path)
% Initiates the BFS queue with a single path containing only the Start node.
shortest_path(Start, Goal, Path) :-
    bfs_queue([[Start]], Goal, RevPath),
    reverse(RevPath, Path).

% Base Case: The front path in the queue successfully reaches the Goal node.
bfs_queue([[Goal | Rest] | _], Goal, [Goal | Rest]).

% Recursive Case: Expand the first path in the queue and append new extensions to the back.
bfs_queue([[Current | Rest] | Queue], Goal, Path) :-
    % Find all unvisited neighbors and create new paths
    findall([Next, Current | Rest],
            (connected(Current, Next), \+ member(Next, [Current | Rest])),
            NewPaths),
    % Append new paths to the end of the queue (First-In, First-Out behavior)
    append(Queue, NewPaths, ExtendedQueue),
    % Continue searching with the updated queue
    bfs_queue(ExtendedQueue, Goal, Path).
