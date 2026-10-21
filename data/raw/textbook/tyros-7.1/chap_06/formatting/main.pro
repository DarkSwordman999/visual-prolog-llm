implement main
clauses
    classInfo("main", "stringops").

    run():-
        console::init(),
        Str=  "       murderous,      doomed      ",
        T= string::trim(Str),
        stdio::write(T), stdio::nl,
        T1= string::trimInner(T),
        stdio::write(T1), stdio::nl.
end implement main

goal mainExe::run(main::run).
