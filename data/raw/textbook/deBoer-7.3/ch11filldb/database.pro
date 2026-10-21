/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/

implement database
    open core

constants
    className = "database".
    classVersion = "".

clauses
    classInfo(className, classVersion).

class facts - persons
    person : (string Name).

clauses
    storeNames(N) = N :-
        stdIO::write("\nInput Name (<Enter> '0' to stop): "),
        '0' = stdIO::readchar(),
        !.
    storeNames(I) = Number :-
        stdIO::ungetchar(),
        Term = stdIO::readline(),
        assert(person(Term)),
        N=I+1,
        Number = storeNames(N).
    
    fill() :-
% Fill local database
        N = storeNames(0),
        stdIO::writef("\n %d terms were stored \n", N),
        stdIO::save(persons),
    % Wait
        _Char = stdIO::readchar(),
        DBFile = outputStream_file::create8("persons.txt"),
        stdIO::setoutputstream(DBFile),
        stdIO::save(persons),
        stdIO::flush(),
        In = stdIO::getinputstream(),
        Out = stdIO::getOutputStream(),
        NewOutput = console::getconsoleoutputstream(),
        stdIO::setoutputstream(NewOutput),
        stdIO::write(In, "  ", Out, "\nThats all").
        
end implement database
