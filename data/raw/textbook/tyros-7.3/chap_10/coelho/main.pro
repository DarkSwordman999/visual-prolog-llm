implement main
    open core
domains
   ms= integer*.
   hs= ms*.
class predicates
    append:(E*, E*, E*) nondeterm anyFlow.
    takesome:(ms,  hs, hs) nondeterm anyFlow.
    move:(hs, hs) nondeterm anyFlow.
    winningMove:(hs, hs) nondeterm (i, o).
clauses
    classInfo("main",  "nimgame").

    append([], Y, Y).
    append([U|X], Y, [U|Z]) :- append(X, Y, Z).

    takesome([_X], V, V).
    takesome([_X, X1|Y], V, [[X1|Y]|V]).
    takesome([_X|T], V,  Y) :- takesome(T, V, Y).

    move(X, Y) :- append(U, [X1|V], X),
         takesome(X1, V, R),  append(U, R, Y).

    winningMove(X, Y) :- move(X, Y), not(winningMove(Y, _)).

    run():- console::init(), L= [[1, 1, 1], [1, 1]],
          winningMove(L, S),
          stdio::write("Winning move: ", S),
          stdio::nl, fail; succeed().
end implement main

goal mainExe::run(main::run).
