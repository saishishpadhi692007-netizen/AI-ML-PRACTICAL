% =========================================================================
% FACTS (The Database)
% =========================================================================

% faculty(FacultyID, Name)
faculty(f1, prof_smith).
faculty(f2, prof_davis).
faculty(f3, prof_jones).

% subject(SubjectCode, SubjectName)
subject(cs101, intro_to_cs).
subject(math201, calculus).
subject(phy101, physics).

% classroom(RoomID, Capacity)
classroom(room101, 40).
classroom(room102, 60).

% timetable(FacultyID, SubjectCode, RoomID, Day, StartHour)
% Hours are represented as integers (e.g., 9 = 9:00 AM, 14 = 2:00 PM)
timetable(f1, cs101, room101, mon, 9).
timetable(f2, math201, room102, mon, 9).
timetable(f3, phy101, room101, mon, 10).

% Intentional conflict facts for testing the detection rules:
timetable(f1, phy101, room102, mon, 9).  % Faculty Conflict: prof_smith cannot be in two places at 9
timetable(f3, cs101, room101, mon, 9).  % Room Conflict: room101 is double-booked at 9

% =========================================================================
% CLAUSES & RULES (The Changes & Logic)
% =========================================================================

% Rule 1: Detect if a Faculty Member is double-booked at the same time
faculty_conflict(FacultyName, Day, Hour, Subject1, Subject2) :-
    faculty(FacultyID, FacultyName),
    timetable(FacultyID, SubjCode1, Room1, Day, Hour),
    timetable(FacultyID, SubjCode2, Room2, Day, Hour),
    % Ensure we are looking at two different scheduled classes
    (SubjCode1 \= SubjCode2 ; Room1 \= Room2),
    subject(SubjCode1, Subject1),
    subject(SubjCode2, Subject2).

% Rule 2: Detect if a Classroom is double-booked at the same time
room_conflict(RoomID, Day, Hour, Faculty1, Faculty2) :-
    timetable(FactID1, SubjCode1, RoomID, Day, Hour),
    timetable(FactID2, SubjCode2, RoomID, Day, Hour),
    % Ensure they are different bookings
    (FactID1 \= FactID2 ; SubjCode1 \= SubjCode2),
    faculty(FactID1, Faculty1),
    faculty(FactID2, Faculty2).
