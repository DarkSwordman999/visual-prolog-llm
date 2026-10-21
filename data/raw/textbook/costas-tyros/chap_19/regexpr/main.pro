/*****************************************
Project Name: regexpr.prj
UI Strategy: console
******************************************/

implement main
    open core
clauses
    classInfo("main",  "regexpr").

class predicates
   test:(string) procedure (i).

clauses
   test(Str) :- 
      regexp::search("-[0-9]+|[0-9]+",  Str, Pos, Len),  !,
        stdio::write(Pos), stdio::nl, 
        stdio::write(Len), stdio::nl.
   test(Str) :- stdio::write("No integer found in ", Str), stdio::nl.

clauses
    run():-
        console::init(),
       test( "There were 99 small Romans"),   
       succeed(). % place your own code here
end implement main  

goal
    mainExe::run(main::run).
