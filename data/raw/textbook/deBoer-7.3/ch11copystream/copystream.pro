/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/

implement copystream
    open core

constants
    className = "copystream".
    classVersion = "".

clauses
    classInfo(className, classVersion).

   clauses
        copy(InFile, OutFile):-
            InputFile = inputStream_file::openFile8(InFile),
            OutputFile = outputStream_file::create(OutFile),
            copyStream(InputFile,OutputFile),
            InputFile:close(),
            OutputFile:close().

    class predicates
        copyStream : (inputStream InputFile, outputStream OutputFile) procedure (i,i).

    clauses
        copyStream(InputFile, OutputFile):-
            repeat(),
               String = InputFile:readLine(),
               stdIO::write(String), stdIO::nl,
               OutputFile:write(String, "\n"),
            InputFile:endOfStream(),
            !.
        copyStream(_InputFile, _OutputFile).

    class predicates
        repeat: () multi ().
    clauses
        repeat().
        repeat() :-
           repeat().

end implement copystream
