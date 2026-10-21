implement main
    open core
domains
   pp2 = (real Argument1, real Argument2) -> real ReturnType.
clauses
    classInfo("main", "zip").
class predicates
   sum:pp2.
   prod:pp2.
   red:(pp2, real*, real, real) procedure (i, i, i,  o).
   zip:(pp2, real*, real*, real*) procedure (i, i, i, o).
   dotprod:(real*, real*, real) procedure (i, i, o).
clauses
    sum(X, Y)= Z :- Z=X+Y.
    prod(X, Y)= Z :- Z=X*Y.

    zip(_P, [], _, []) :- !.
    zip(_P, _, [], []) :- !.
    zip(P, [X|Xs], [Y|Ys], [Z|As]) :- Z= P(X, Y),  zip(P, Xs, Ys, As).

    red(_P, [], A, A) :- !.
    red(P, [X|Xs], A, Ans) :- red(P, Xs, P(X, A), Ans).

    dotprod(Xs, Ys, D) :- zip(prod, Xs, Ys, Z), red(sum, Z, 0, D).

    run():- console::init(),
        V1= [1,2,3,4,5], V2= [2,2,2,2,2],
        dotprod( V1, V2,  X),
        stdio::write(X), stdio::nl.
end implement main
goal
    mainExe::run(main::run).