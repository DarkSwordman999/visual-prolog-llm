/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement counter
    open core

constants
    className = "counter".
    classVersion = "".

clauses
    classInfo(className, classVersion).

    count(11) :-
        stdIO::write("That's all folks!"), !.
    count(Number) :-
        stdIO::write(Number),
        stdIO::nl,
        NextNumber = Number + 1,
        count(NextNumber).

end implement counter
