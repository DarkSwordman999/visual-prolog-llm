/* File: main.pro */
implement main
open core, console
domains
    rList= real*.
class predicates
    len:(rList, real) procedure (i, o).
clauses
   classInfo("avg", "1.0").

   len([], 0) :- !.
   len([_X|Xs], 1.0+S) :- len(Xs, S).

   run():- console::init(),  List= read(),
        len(List, A),
        write(A), nl.
end implement main
goal
    mainExe::run(main::run).