%File: main.pro
implement main
open core, console

class predicates
   avg:(real*, real, real, real) procedure (i, i, i, o).
clauses
   classInfo("avg", "1.0").

   avg([], S, L, S/L).
   avg([X|Xs], S, L, A) :-
       avg( Xs,
            X+S,              % add X to the sum acc
            L+1.0,            % increments the length acc
            A).


   run():- console::init(), List= read(),
        avg(List, 0, 0,  A), write(A), nl.
end implement main

goal
    mainExe::run(main::run).