/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/

implement main
    open core

clauses
    run() :-
        console::init(),
        stdIO::nl,
        Intfile = inputstream_file::openFileUtf8("intsource.txt"),
        Stringfile = inputstream_file::openFileUtf8("stringsource.txt"),
        FunctorFile = inputstream_file::openFileUtf8("functorsource.txt"),
        readexamples::readsometerms(Intfile, Stringfile, FunctorFile),
        _ = stdIO::readchar().

end implement main

goal
    mainExe::run(main::run).
