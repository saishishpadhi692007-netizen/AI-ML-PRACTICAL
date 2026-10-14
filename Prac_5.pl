% =========================================================================
% FACTS (Student Marks Database)
% =========================================================================

% marks(StudentName, Score Out of 100)
marks(alice, 92).
marks(bob, 75).
marks(charlie, 38).
marks(david, 85).
marks(eva, 55).
marks(frank, 20).

% =========================================================================
% CLAUSES & RULES (Rule-Based Classification Reasoning)
% =========================================================================

% Rule 1: A student is a topper if their marks are 85 or above.
classify(Student, topper) :-
    marks(Student, Score),
    Score >= 85.

% Rule 2: A student is average if their marks are between 40 and 84 (inclusive).
classify(Student, average) :-
    marks(Student, Score),
    Score >= 40,
    Score < 85.

% Rule 3: A student fails if their marks are strictly below 40.
classify(Student, fail) :-
    marks(Student, Score),
    Score < 40.

