/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
implement main

clauses
    run():-
        console::init(),
        counter::count(1),
        _X = stdIO::readChar().

end implement main

goal
    mainExe::run(main::run).
