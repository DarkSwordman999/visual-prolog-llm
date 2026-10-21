/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement factorial
    open core

constants
    className = "factorial".
    classVersion = "".

clauses
    classInfo(className, classVersion).

    fac(1,1) :- !.
    fac(Number, Factorial) :-
        NumberMinus1 = Number - 1,
        fac(NumberMinus1, FactorialMinus1),
        Factorial = Number * FactorialMinus1,
        stdIO::write("Factorial of ", Number, " is ", Factorial),
        stdIO::nl.

end implement factorial
