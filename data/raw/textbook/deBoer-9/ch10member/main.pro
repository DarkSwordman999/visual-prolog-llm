/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/

implement main

clauses
    run():-
        console::init(),
        stdIO::write("Type a number -> "),
        hasdomain (integer, Number),
        Number = stdIO::read(),
        List = [1,2,3,4,5,6],
        member::member(Number,List), !,
        stdIO::write(Number, " is in ", List),
        _ = stdIO::readchar(),
        _ = stdIO::readchar().
    run() :-
        stdIO::write(" is not in list"),
        _=stdIO::readchar(),
        _=stdIO::readchar().


end implement main

goal
    mainExe::run(main::run).
