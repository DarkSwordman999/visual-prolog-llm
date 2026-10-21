/*****************************************************************************

                         Utah State University

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
        succeed(). % place your own code here
end implement main

goal
    mainExe::run(main::run).
