/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/

implement main
    open core

constants
    className = "main".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    run():-
        console::init(),
        copystream::copy("source.txt","destination.txt"),
        _ = stdIO::readchar(),
        succeed(). % place your own code here
end implement main

goal
    mainExe::run(main::run).
