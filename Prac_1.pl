% ==========================================
% PREDICATES & FACTS (The Knowledge Base)
% ==========================================

% student(Name) - Defines who is a student
student(alice).
student(bob).
student(charlie).
student(david).

% course(Code, Name) - Defines the available courses
course(cs101, computer_science).
course(math201, calculus).
course(phy101, physics).

% enrolled(Student, CourseCode) - Establishes enrollment records
enrolled(alice, cs101).
enrolled(alice, math201).
enrolled(bob, cs101).
enrolled(charlie, math201% ==========================================
% PREDICATES & FACTS (The Knowledge Base)
% ==========================================

% student(Name) - Defines who is a student
student(alice).
student(bob).
student(charlie).
student(david).

% course(Code, Name) - Defines the available courses
course(cs101, computer_science).
course(math201, calculus).
course(phy101, physics).

% enrolled(Student, CourseCode) - Establishes enrollment records
enrolled(alice, cs101).
enrolled(alice, math201).
enrolled(% ==========================================
% PREDICATES & FACTS (The Knowledge Base)
% ==========================================

% student(Name) - Defines who is a student
student(alice).
student(bob).
student(charlie).
student(david).

% course(Code, Name) - Defines the available courses
course(cs101, computer_science).
course(math201, calculus).
course(phy101, physics).

% enrolled(Student, CourseCode) - Establishes enrollment records
enrolled(alice, cs101).
enrolled(alice, math201).
enrolled(bob, cs101).
enrolled(charlie, math201).
enrolled(charlie, phy101).
enrolled(david, phy101).

% ==========================================
% CLAUSES / RULES (Logical Relationships)
% ==========================================

% Rule 1: Two students are classmates if they are enrolled in the same course code.
classmate(Student1, Student2) :-
    enrolled(Student1, CourseCode),
    enrolled(Student2, CourseCode),
    Student1 \= Student2.  % Ensures a student isn't their own classmate

% Rule 2: Checks if a student takes a course based on the course's name rather than its code.
takes_course_title(Student, CourseName) :-
    enrolled(Student, CourseCode),
    course(CourseCode, CourseName).
