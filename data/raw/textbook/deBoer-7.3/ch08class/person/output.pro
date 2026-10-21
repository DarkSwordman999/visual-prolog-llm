/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement output
    open core

constants
    className = "person/output".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    myWrite(ThingToWrite) :-
        stdIO::write(ThingToWrite).

end implement output
