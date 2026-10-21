% Copyright (c) Taras Grynchuk

 implement main
    open core
    domains
        gender = female(); male().
    class facts - familyDB
        person : (string Name, gender Gender).
        parent : (string Person, string Parent).
    class predicates
        mather : (string Person, string Mather) nondeterm anyflow.
    clauses
        mather(Person, Mather) :-
            parent(Person, Mather),
            person(Mather, female()).
    class predicates
        grandMather : (string Person, string GrandMather) nondeterm (i,o).
    clauses
        grandMather(Person, GrandMather) :-
            parent(Person, Parent),
            mather(Parent, GrandMather).
    class predicates
        reconsult : (string FileName).
    clauses
        reconsult(FileName) :-
            retractFactDB(familyDB),
            file::consult(FileName, familyDB).
    clauses
        run():-
            console::init(),
            stdIO::write("Load data\n"),
            reconsult("..\\fa.txt"),
            stdIO::write("\nmather test\n"),
            mather(X, Y),
                stdIO::writef("% is the mather of %\n", Y, X),
            fail.
        run():-
            X = "Taras",
            stdIO::writef("\ngrand mother of % test\n",X),
            grandMather(X, Y),
                stdIO::writef("% is the grand mother of %\n", Y, X),
            fail.
        run():-
            stdIO::write("End of test\n").
end implement main
goal
    mainExe::run(main::run).
