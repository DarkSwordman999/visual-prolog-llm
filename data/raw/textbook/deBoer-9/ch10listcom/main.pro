/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
implement main

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
