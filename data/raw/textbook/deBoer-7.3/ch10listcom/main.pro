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
        L = [ Age || listcom::person(_, _, Age)],
        listcom::sumlist(L, Sum, N),
        Ave = Sum/N,
        stdio::write("Average=", Ave, ". "),
        _X = stdIO::readchar().

end implement main

goal
    mainExe::run(main::run).
