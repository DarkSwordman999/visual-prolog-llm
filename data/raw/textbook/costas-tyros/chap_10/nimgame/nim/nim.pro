% File:nim.pro
implement nim
    open core, stdio

class predicates
    append:(hs, hs, hs) nondeterm anyFlow.
    takesome:(ms,  hs, hs) nondeterm anyFlow.
    move:(hs, hs) nondeterm anyFlow.
    winningMove:(hs, hs) nondeterm (i, o).
    iwin:(hs)  determ (i).
    youwin:(hs, hs) determ (i, o).

clauses
    classInfo("nim", "1.0").

    append([], Y, Y).
    append([U|X], Y, [U|Z]) :- append(X, Y, Z).

    takesome([_X], V, V).
    takesome([_X, X1|Y], V, [[X1|Y]|V]).
    takesome([_X|T], V,  Y) :- takesome(T, V, Y).

    move(X, Y) :- append(U, [X1|V], X),
                        takesome(X1, V, R),  append(U, R, Y).

    winningMove(X, Y) :- move(X, Y), not(winningMove(Y, _)).

    iwin([]) :- !, write("I win"), nl.
    youwin(L, L2) :- winningMove(L, L2), !.
    youwin(_L, _L2) :- write("You win"), nl, fail.

   game(L1) :- write("Your move: "),
       L= console::read(), move(L1, LTest),
       L= LTest,   youwin(L, L2), !,
       write("My move: "), write(L2), nl,
       not(iwin(L2)),  game(L2).
end implement nim
