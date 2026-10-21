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

class predicates
    copystream : (inputStream InputFile, outputStream OutputFile) procedure (i,i).
clauses
    copystream(InputFile, OutputFile) :-
        repeat(),
        String = InputFile:readLine(),
        stdIO::write(String), stdIO::nl,
        OutputFile:write(String, "\n"),
        InputFile:endOfStream(), !.
    copystream(_,_).

class predicates
    repeat : () multi ().
clauses
    repeat().
    repeat() :-
        repeat().

clauses
    run():-
        console::init(),
        InputFile = inputStream_file::openFile8("Source.txt"),
        OutputFile = outputStream_File::create("Destination.txt"),
        copystream(InputFile, OutputFile),
        InputFile:close(),
        OutputFile:close(),
        _ = stdIO::readChar(),
        succeed(). % place your own code here
end implement main

goal
    mainExe::run(main::run).
