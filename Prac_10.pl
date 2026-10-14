:- use_module(library(random)). % Required for random selection and probabilities

% =================================================================
% SIMULATED ANNEALING ALGORITHM
% =================================================================

% Main entry point: simulated_annealing(+StartNode, +InitialTemp, +CoolingRate, -Path, -FinalNode)
% Typical parameters: Temp = 100.0, CoolingRate = 0.9
simulated_annealing(Start, InitialTemp, CoolingRate, Path, FinalNode) :-
    h(Start, CurrentEnergy),
    sa_search(Start, CurrentEnergy, InitialTemp, CoolingRate, [Start], RevPath, FinalNode),
    reverse(RevPath, Path).

% -----------------------------------------------------------------
% Core Search Logic
% -----------------------------------------------------------------

% Case 1: Stop condition when the temperature cools down below a threshold
sa_search(Current, _, Temp, _, Visited, Visited, Current) :-
    Temp < 0.1, !.

% Case 2: Explore neighbors and decide whether to transition
sa_search(Current, CurrentEnergy, Temp, CoolingRate, Visited, Path, FinalNode) :-
    % Find all possible moves from the current state
    findall(Next, move(Current, Next), Neighbors),
    (   Neighbors = []
    ->  % If stuck with no neighbors, terminate search here
        Path = Visited, FinalNode = Current
    ;   % 1. Pick a neighbor at random
        random_member(ChosenNext, Neighbors),
        h(ChosenNext, NextEnergy),
        DeltaE is NextEnergy - CurrentEnergy,
        NextTemp is Temp * CoolingRate,

        (   % Condition A: Next state is better (Lower Energy) -> Always Accept
            DeltaE < 0
        ->  sa_search(ChosenNext, NextEnergy, NextTemp, CoolingRate, [ChosenNext|Visited], Path, FinalNode)
        ;   % Condition B: Next state is worse -> Accept with a probability: e^(-DeltaE / Temp)
            Probability is exp(-DeltaE / Temp),
            random_float(R), % Generates a float between 0.0 and 1.0
            (   R < Probability
            ->  % Accept worse move to escape local optimum
                sa_search(ChosenNext, NextEnergy, NextTemp, CoolingRate, [ChosenNext|Visited], Path, FinalNode)
            ;   % Reject worse move, stay at current state but cool down down
                sa_search(Current, CurrentEnergy, NextTemp, CoolingRate, Visited, Path, FinalNode)
            )
        )
    ).


% =================================================================
% SAMPLE GRAPH KNOWLEDGE BASE (Demonstrating Local Optima Escape)
% =================================================================
% State space graph: move(Current, Neighbor)
move(a, b).
move(a, c).
move(c, d).

% Heuristic Cost / Energy: h(Node, Energy)
% Objective: Find the state with the lowest energy.
h(a, 10).
h(b, 5).   % Local Optimum: Better than 'a', but a dead-end trap.
h(c, 12).  % Worse state than 'a' (Hill Climbing would reject this path).
h(d, 1).   % Global Optimum: The ultimate target.
