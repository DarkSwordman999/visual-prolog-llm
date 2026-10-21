/*****************************************************************************

                         Utah State University

******************************************************************************/

implement main
    open core

constants
    className = "main".
    classVersion = "".
class predicates
    rev:(L*, L*, L*) procedure (i, i, o).

clauses
    classInfo(className, classVersion).

   rev([], L, L) :- !.
   rev([X|Xs], Acc, L) :- rev(Xs, [X|Acc], L).

    run():-
        console::init(),
         stdio::write("Type a list of integers: "), stdio::nl,
         hasdomain(core::integer_list, Xs),
          Xs= toTerm(stdio::readLine()),
         rev(Xs, [], L),
         stdio::write(L), stdio::nl,
        succeed(). % place your own code here
end implement main

goal
    mainExe::run(main::run).
