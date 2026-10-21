% Copyright

implement main
    open core

domains
    continentType = europe; northAmerica; asia.
    countryType = romania; portugal; switzerland; spain; uk; usa.
    programType = bachelors; masters; phd; erasmus; internship.
    activityType = lecture; laboratory; seminar; internship_activity.
    evaluationType = exam; project; test; presentation; practical_eval.
    difficultyType = easy; medium; advanced.
    statusType = notStarted; inProgress; completed.
    continent = continent(continentType ContName).
    country = country(countryType CountryName).
    region = region(string RegionName, string ClimateType).
    city = city(string CityName, integer Population).
    university = university(string UnivName, integer YearFounded).
    campus = campus(string CampusName, string Location).
    faculty = faculty(string FacultyName).
    department = department(string DeptName).
    studyProgram = studyProgram(programType Level, integer DurationYears).
    academicYear = academicYear(integer CurrentYear).
    semester = semester(integer SemesterNumber, string Season).
    course = course(string CourseName, integer EctsCredits).
    activity = activity(activityType Type, string Attendance).
    evaluation = evaluation(evaluationType Method, integer WeightPercentage).
    task = task(string TaskName, difficultyType Difficulty, string Language, statusType Status).

class facts - databaseClauses
    record : (continent, country, region, city, university, campus, faculty, department, studyProgram, academicYear, semester, course, activity,
        evaluation, task).

class facts - temporaryMemory
    visitedContinent : (continentType).
    visitedCountry : (countryType).
    visitedCity : (string).
    visitedUniversity : (string).
    visitedCourse : (string).
    visitedRegion : (string).
    visitedCampus : (string).
    visitedFaculty : (string).
    visitedDepartment : (string).
    visitedProgram : (programType).
    visitedYear : (integer).
    visitedSemester : (integer).
    visitedActivity : (activityType).
    visitedEvaluation : (evaluationType).

clauses
    run() :-
        console::init(),
        file::consult("..\\data.txt", databaseClauses),
        fail.

    run() :-
        stdio::write("\n--- 1. All registered tasks ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, _, _, _, task(Name, _, _, _)),
        stdio::writef("Task found: %\n", Name),
        fail.

    run() :-
        stdio::write("\n--- 2. All courses ---\n"),
        retractAll(visitedCourse(_)),
        record(_, _, _, _, _, _, _, _, _, _, _, course(Name, _), _, _, _),
        not(visitedCourse(Name)),
        assert(visitedCourse(Name)),
        stdio::writef("Course: %\n", Name),
        fail.

    run() :-
        stdio::write("\n--- 3. All continents ---\n"),
        retractAll(visitedContinent(_)),
        record(continent(C), _, _, _, _, _, _, _, _, _, _, _, _, _, _),
        not(visitedContinent(C)),
        assert(visitedContinent(C)),
        stdio::writef("Continent: %\n", C),
        fail.

    run() :-
        stdio::write("\n--- 4. All countries ---\n"),
        retractAll(visitedCountry(_)),
        record(_, country(T), _, _, _, _, _, _, _, _, _, _, _, _, _),
        not(visitedCountry(T)),
        assert(visitedCountry(T)),
        stdio::writef("Country: %\n", T),
        fail.

    run() :-
        stdio::write("\n--- 5. Regions and their climate ---\n"),
        retractAll(visitedRegion(_)),
        record(_, _, region(R, C), _, _, _, _, _, _, _, _, _, _, _, _),
        not(visitedRegion(R)),
        assert(visitedRegion(R)),
        stdio::writef("% (Climate: %)\n", R, C),
        fail.

    run() :-
        stdio::write("\n--- 6. Cities ---\n"),
        retractAll(visitedCity(_)),
        record(_, _, _, city(O, _), _, _, _, _, _, _, _, _, _, _, _),
        not(visitedCity(O)),
        assert(visitedCity(O)),
        stdio::writef("City: %\n", O),
        fail.

    run() :-
        stdio::write("\n--- 7. City populations ---\n"),
        retractAll(visitedCity(_)),
        record(_, _, _, city(O, Pop), _, _, _, _, _, _, _, _, _, _, _),
        not(visitedCity(O)),
        assert(visitedCity(O)),
        stdio::writef("% has % residents\n", O, Pop),
        fail.

    run() :-
        stdio::write("\n--- 8. Universities and foundation year ---\n"),
        retractAll(visitedUniversity(_)),
        record(_, _, _, _, university(U, Year), _, _, _, _, _, _, _, _, _, _),
        not(visitedUniversity(U)),
        assert(visitedUniversity(U)),
        stdio::writef("% (Founded in %)\n", U, Year),
        fail.

    run() :-
        stdio::write("\n--- 9. Campuses ---\n"),
        retractAll(visitedCampus(_)),
        record(_, _, _, _, _, campus(Camp, Z), _, _, _, _, _, _, _, _, _),
        not(visitedCampus(Camp)),
        assert(visitedCampus(Camp)),
        stdio::writef("Campus % located in %\n", Camp, Z),
        fail.

    run() :-
        stdio::write("\n--- 10. Faculties ---\n"),
        retractAll(visitedFaculty(_)),
        record(_, _, _, _, _, _, faculty(F), _, _, _, _, _, _, _, _),
        not(visitedFaculty(F)),
        assert(visitedFaculty(F)),
        stdio::writef("Faculty of %\n", F),
        fail.

    run() :-
        stdio::write("\n--- 11. Departments ---\n"),
        retractAll(visitedDepartment(_)),
        record(_, _, _, _, _, _, _, department(D), _, _, _, _, _, _, _),
        not(visitedDepartment(D)),
        assert(visitedDepartment(D)),
        stdio::writef("Dept. %\n", D),
        fail.

    run() :-
        stdio::write("\n--- 12. Study programs (Levels) ---\n"),
        retractAll(visitedProgram(_)),
        record(_, _, _, _, _, _, _, _, studyProgram(Type, _), _, _, _, _, _, _),
        not(visitedProgram(Type)),
        assert(visitedProgram(Type)),
        stdio::writef("Registered program: %\n", Type),
        fail.

    run() :-
        stdio::write("\n--- 13. Current academic years ---\n"),
        retractAll(visitedYear(_)),
        record(_, _, _, _, _, _, _, _, _, academicYear(Year), _, _, _, _, _),
        not(visitedYear(Year)),
        assert(visitedYear(Year)),
        stdio::writef("Year %\n", Year),
        fail.

    run() :-
        stdio::write("\n--- 14. Semester details ---\n"),
        retractAll(visitedSemester(_)),
        record(_, _, _, _, _, _, _, _, _, _, semester(Nr, Season), _, _, _, _),
        not(visitedSemester(Nr)),
        assert(visitedSemester(Nr)),
        stdio::writef("Semester % (%)\n", Nr, Season),
        fail.

    run() :-
        stdio::write("\n--- 15. ECTS credits per course ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, course(M, Cred), _, _, _),
        stdio::writef("% -> % credits\n", M, Cred),
        fail.

    run() :-
        stdio::write("\n--- 16. Activity types ---\n"),
        retractAll(visitedActivity(_)),
        record(_, _, _, _, _, _, _, _, _, _, _, _, activity(Act, P), _, _),
        not(visitedActivity(Act)),
        assert(visitedActivity(Act)),
        stdio::writef("Activity: % (Attendance: %)\n", Act, P),
        fail.

    run() :-
        stdio::write("\n--- 17. Evaluation methods ---\n"),
        retractAll(visitedEvaluation(_)),
        record(_, _, _, _, _, _, _, _, _, _, _, _, _, evaluation(Method, _), _),
        not(visitedEvaluation(Method)),
        assert(visitedEvaluation(Method)),
        stdio::writef("Graded by: %\n", Method),
        fail.

    run() :-
        stdio::write("\n--- 18. Evaluation weights ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, course(M, _), _, evaluation(Method, Weight), _),
        stdio::writef("% (%): % of final grade\n", M, Method, Weight),
        fail.

    run() :-
        stdio::write("\n--- 19. Task difficulty levels ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, _, _, _, task(S, Dif, _, _)),
        stdio::writef("The task % is '%'\n", S, Dif),
        fail.

    run() :-
        stdio::write("\n--- 20. Task working languages ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, _, _, _, task(S, _, Lang, _)),
        stdio::writef("% is written in %\n", S, Lang),
        fail.

    run() :-
        stdio::write("\n--- 21. Current task statuses ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, _, _, _, task(S, _, _, Status)),
        stdio::writef("Status [%]: %\n", Status, S),
        fail.

    run() :-
        stdio::write("\n--- 22. Tasks evaluated via EXAM ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, _, _, evaluation(exam, _), task(S, _, _, _)),
        stdio::writef("-> %\n", S),
        fail.

    run() :-
        stdio::write("\n--- 23. Tasks evaluated via PROJECT ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, _, _, evaluation(project, _), task(S, _, _, _)),
        stdio::writef("-> %\n", S),
        fail.

    run() :-
        stdio::write("\n--- 24. Universities in Romania ---\n"),
        retractAll(visitedUniversity(_)),
        record(_, country(romania), _, _, university(U, _), _, _, _, _, _, _, _, _, _, _),
        not(visitedUniversity(U)),
        assert(visitedUniversity(U)),
        stdio::writef("%\n", U),
        fail.

    run() :-
        stdio::write("\n--- 25. Universities in Switzerland ---\n"),
        retractAll(visitedUniversity(_)),
        record(_, country(switzerland), _, _, university(U, _), _, _, _, _, _, _, _, _, _, _),
        not(visitedUniversity(U)),
        assert(visitedUniversity(U)),
        stdio::writef("%\n", U),
        fail.

    run() :-
        stdio::write("\n--- 26. ERASMUS study programs ---\n"),
        retractAll(visitedCity(_)),
        record(_, _, _, city(O, _), _, _, _, _, studyProgram(erasmus, _), _, _, _, _, _, _),
        not(visitedCity(O)),
        assert(visitedCity(O)),
        stdio::writef("Erasmus mobility in the city of: %\n", O),
        fail.

    run() :-
        stdio::write("\n--- 27. Specific tasks for Bachelors level ---\n"),
        record(_, _, _, _, _, _, _, _, studyProgram(bachelors, _), _, _, _, _, _, task(S, _, _, _)),
        stdio::writef("%\n", S),
        fail.

    run() :-
        stdio::write("\n--- 28. Tasks for Masters level ---\n"),
        record(_, _, _, _, _, _, _, _, studyProgram(masters, _), _, _, _, _, _, task(S, _, _, _)),
        stdio::writef("%\n", S),
        fail.

    run() :-
        stdio::write("\n--- 29. Mandatory attendance activities ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, course(D, _), activity(_, "Mandatory"), _, _),
        stdio::writef("% requires attendance\n", D),
        fail.

    run() :-
        stdio::write("\n--- 30. High workload courses (Over 10 ECTS) ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, course(D, Cred), _, _, _),
        Cred > 10,
        stdio::writef("% provides % credits!\n", D, Cred),
        fail.

    run() :-
        stdio::write("\n--- 31. LARGE cities (Population over 1 million) ---\n"),
        retractAll(visitedCity(_)),
        record(_, _, _, city(O, Pop), _, _, _, _, _, _, _, _, _, _, _),
        Pop > 1000000,
        not(visitedCity(O)),
        assert(visitedCity(O)),
        stdio::writef("%\n", O),
        fail.

    run() :-
        stdio::write("\n--- 32. Universities founded before 1900 ---\n"),
        retractAll(visitedUniversity(_)),
        record(_, _, _, _, university(U, Year), _, _, _, _, _, _, _, _, _, _),
        Year < 1900,
        not(visitedUniversity(U)),
        assert(visitedUniversity(U)),
        stdio::writef("% (Year: %)\n", U, Year),
        fail.

    run() :-
        stdio::write("\n--- 33. ADVANCED difficulty tasks ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, _, _, _, task(S, advanced, _, _)),
        stdio::writef("%\n", S),
        fail.

    run() :-
        stdio::write("\n--- 34. Tasks requiring English ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, _, _, _, task(S, _, "English", _)),
        stdio::writef("%\n", S),
        fail.

    run() :-
        stdio::write("\n--- 35. Work in progress ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, _, _, _, task(S, _, _, inProgress)),
        stdio::writef("To be completed: %\n", S),
        fail.

    run() :-
        stdio::write("\n--- 36. COMPLETED tasks ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, _, _, _, task(S, _, _, completed)),
        stdio::writef("Done with: %\n", S),
        fail.

    run() :-
        stdio::write("\n--- 37. MAXIMUM weight evaluations (100%) ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, _, _, evaluation(_, Weight), task(S, _, _, _)),
        Weight = 100,
        stdio::writef("% depends 100%% on this evaluation\n", S),
        fail.

    run() :-
        stdio::write("\n--- 38. Courses in Semester 2 (Spring) ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, semester(2, _), course(D, _), _, _, _),
        stdio::writef("%\n", D),
        fail.

    run() :-
        stdio::write("\n--- 39. Software department locations ---\n"),
        retractAll(visitedCity(_)),
        record(_, country(T), _, city(O, _), _, _, _, department("Software"), _, _, _, _, _, _, _),
        not(visitedCity(O)),
        assert(visitedCity(O)),
        stdio::writef("Software dept. is located in %, %\n", O, T),
        fail.

    run() :-
        stdio::write("\n--- 40. Is there a Database project? ---\n"),
        record(_, _, _, _, _, _, _, _, _, _, _, course("Databases", _), _, _, task(S, _, _, _)),
        stdio::writef("YES, we have the task: %\n", S),
        fail.

    run() :-
        stdio::write("\n======================================================\n"),
        stdio::write("           TESTING COMPLETE   \n"),
        stdio::write("======================================================\n").

end implement main

goal
    console::runUtf8(main::run).
