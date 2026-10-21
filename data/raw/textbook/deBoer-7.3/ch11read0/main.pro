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
        stdIO::nl,
        Intfile = inputstream_file::openfile("intsource.txt"),
        Stringfile = inputstream_file::openfile("stringsource.txt"),
        FunctorFile = inputstream_file::openfile("functorsource.txt"),
        readexamples::readsometerms(Intfile, Stringfile,FunctorFile),
        _ = stdIO::readchar().

end implement main

goal
    mainExe::run(main::run).
