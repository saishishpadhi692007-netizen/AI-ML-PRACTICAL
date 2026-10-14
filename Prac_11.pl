% =================================================================
% MAP-COLORING PROBLEM DEFINITION (CSP)
% =================================================================

% 1. Define the domain of available colors
color(red).
color(green).
color(blue).

% 2. Main entry point: color_map(-Solution)
% This defines a classic map topology (using the Australia map layout)
% Variables: WA, NT, SA, Q, NSW, V, T
color_map(Solution) :-
    % Assign variables from the domain (Prolog backtracks if constraints fail)
    color(WA),
    color(NT),
    color(SA),
    color(Q),
    color(NSW),
    color(V),
    color(T),

    % Define the adjacency constraints (Adjacent regions must have different colors)
    WA \= NT, WA \= SA,
    NT \= SA, NT \= Q,
    SA \= Q,  SA \= NSW, SA \= V,
    Q  \= NSW,
    NSW \= V,

    % Note: T (Tasmania) is an island and has no adjacency constraints!

    % Package the assignment cleanly into a list for output
    Solution = [wa=WA, nt=NT, sa=SA, q=Q, nsw=NSW, v=V, t=T].
