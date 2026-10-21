/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement main

clauses
    run():-
        TaskWindow = taskWindow::new(),
        TaskWindow:show().
end implement main

goal
    mainExe::run(main::run).
