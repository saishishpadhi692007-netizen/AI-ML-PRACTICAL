% =================================================================
% 1. APPEND TWO LISTS
% =================================================================
% Base case: Appending an empty list to List leaves List unchanged.
my_append([], List, List).

% Recursive case: Take the Head of the first list, recursively append
% the Tail to List2, and add Head back to the front of the result.
my_append([Head|Tail], List2, [Head|ResultTail]) :-
    my_append(Tail, List2, ResultTail).


% =================================================================
% 2. REVERSE A LIST
% =================================================================
% Base case: Reversing an empty list results in an empty list.
my_reverse([], []).

% Recursive case: Reverse the Tail first, then use my_append/3
% to place the Head at the very end of that reversed tail.
my_reverse([Head|Tail], Reversed) :-
    my_reverse(Tail, RevTail),
    my_append(RevTail, [Head], Reversed).


% =================================================================
% 3. MEMBER SEARCH IN A LIST
% =================================================================
% Base case: Element is found if it matches the Head of the list.
my_member(Element, [Element|_]).

% Recursive case: Look for Element inside the Tail of the list.
my_member(Element, [_|Tail]) :-
    my_member(Element, Tail).


% =================================================================
% 4. FIND LIST LENGTH
% =================================================================
% Base case: An empty list has a length of 0.
my_length([], 0).

% Recursive case: The length is 1 plus the length of the Tail.
my_length([_|Tail], Length) :-
    my_length(Tail, TailLength),
    Length is TailLength + 1.
