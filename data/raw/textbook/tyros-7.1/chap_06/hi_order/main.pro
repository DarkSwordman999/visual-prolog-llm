implement main
    open core
    
domains
   pp2 = (real Argument1, real Argument2) -> real ReturnType.
clauses
    classInfo("main", "hi_order").

class predicates
   sum:pp2.
   prod:pp2.
   quotient:pp2.
   sub:pp2.
   
   red:(pp2, real*, real, real) procedure (i, i, i,  o).
clauses
    sum(X, Y)= Z :- Z=X+Y.
    prod(X, Y)= Z :- Z=X*Y.
    quotient(X, Y)= Z :- Z=X/Y.
    sub(X, Y)= Z :- Z= X-Y.
    
    red(_P, [], A, A) :- !.
    red(P, [X|Xs], A, Ans) :- red(P, Xs, P(X, A), Ans).
 
    run():-
        console::init(),
        red(prod, [1,2,3,4,5],  1, X),
        stdio::write(X), stdio::nl,
        succeed().
end implement main

goal
    mainExe::run(main::run).
