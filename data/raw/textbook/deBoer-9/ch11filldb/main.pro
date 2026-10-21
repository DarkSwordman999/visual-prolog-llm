/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
implement main

clauses
    run():-
        console::init(),
        database::fill(),
        _=stdIO::readchar(),
        succeed(). % place your own code here
end implement main

goal
    mainExe::run(main::run).
