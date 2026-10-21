/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement main
    open core

constants
    className = "main".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    run():-
        console::init(),
        counter::count(1),
        _X = stdIO::readChar().

end implement main

goal
    mainExe::run(main::run).
