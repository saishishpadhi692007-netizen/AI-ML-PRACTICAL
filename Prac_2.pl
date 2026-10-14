% =================================================================
% 1. ARITHMETIC OPERATIONS
% =================================================================
% Performs addition, subtraction, multiplication, and division.
add(A, B, Sum) :- Sum is A + B.
sub(A, B, Diff) :- Diff is A - B.
mul(A, B, Prod) :- Prod is A * B.
div(A, B, Quot) :-
    B \= 0, % Prevent division by zero
    Quot is A / B.


% =================================================================
% 2. FACTORIAL USING RECURSION
% =================================================================
% Base case: Factorial of 0 is 1.
factorial(0, 1).

% Recursive case: N! = N * (N-1)!
factorial(N, Result) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, SubResult),
    Result is N * SubResult.


% =================================================================
% 3. FIBONACCI SERIES USING RECURSION
% =================================================================
% Base cases: 0th Fibonacci number is 0, 1st is 1.
fibonacci(0, 0).
fibonacci(1, 1).

% Recursive case: Fib(N) = Fib(N-1) + Fib(N-2)
fibonacci(N, Result) :-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1, R1),
    fibonacci(N2, R2),
    Result is R1 + R2.
a
