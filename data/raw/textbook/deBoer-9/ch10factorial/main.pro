/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
implement main

clauses
    run():-
        console::init(),
        stdIO::write("Type a number (0 to end) -> "),
        hasdomain(integer, Number),
        Number = stdIO::read(),
        Number <> 0, !,
        factorial::fac(Number, Factorial),
        stdIO::write("Factorial of ", Number, " is ", Factorial),
        stdIO::nl,
        _ = stdIO::readchar(),
        run().
    run().
end implement main

goal
    mainExe::run(main::run).
