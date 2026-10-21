implement main
 clauses
    classInfo("main", "toString_example").

    run():- console::init(),
        Xs= [3.4, 2, 5, 8],
        Str= toString(Xs),
        Msg= string::concat("String representation: ", Str),
        stdio::write(Msg), stdio::nl.
end implement main
goal mainExe::run(main::run).
