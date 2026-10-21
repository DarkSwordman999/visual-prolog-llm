/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
implement main

clauses
    run():-
        TaskWindow = taskWindow::new(),
        TaskWindow:show().
end implement main

goal
    mainExe::run(main::run).
