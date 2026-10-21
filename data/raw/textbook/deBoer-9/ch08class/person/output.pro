/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
implement output

clauses
    myWrite(ThingToWrite) :-
        stdIO::write(ThingToWrite).

end implement output
