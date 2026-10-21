implement main
    open core
class predicates
     foldr:(function{L, B, B}, B,    L*) -> B.
     red:(function{L, B, B}, B, L*) -> B.
clauses
   classInfo("main", "1.0").

   foldr(_P, F, [])= C :- C= F.
   foldr(P,  F,  [X|Xs])= C :-  C= P(X, foldr(P, F, Xs)).

   red(_, Acc, [])= C :- C= Acc.
   red(P, Acc, [X|Xs]) = C :- C=red(P, P(X, Acc), Xs).

   run():- console::init(), L= [1,2,3,4],
        S= foldr({(X, Y)= C  :- C= X+Y},  0, L),
        stdio::write("Sum of ", L, "=", S, "\n"),
        Prod= foldr({(X, Y)= C :- C= X*Y},  1, L),
        stdio::write("Prod of ", L, "=", Prod, "\n"),
        R= red({(X, Xs)= C :- C= [X|Xs]}, [], L),
        stdio::write("Reverse of ", L, "=", R).
end implement main
goal
    mainExe::run(main::run).