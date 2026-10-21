
implement main
    open core

constants
    className = "main".
    classVersion = "gmember 1.0".

clauses
    classInfo(className, classVersion).

clauses
    run():-
        console::init(),
        Flowers=gmember::new(),
        Flowers:search(E, ["rose", "daisy", "tulip"]),
        stdio::write(E), stdio::nl,
        Ints= gmember::new(),
        X= gmember::new(),
        Ints:search(N, [1, 2,3,4]),
        stdio::write(N), stdio::nl,
        X:search(N, [2, 4]),
        stdio::write(N), stdio::nl,
        fail. % place your own code here
    run() :- R= gmember::new(),
       R:app([1,2,3], [4,5,6], L),
       stdio::write(L), stdio::nl.
end implement main

goal
    mainExe::run(main::run).
