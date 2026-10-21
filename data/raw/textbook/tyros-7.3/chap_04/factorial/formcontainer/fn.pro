% File fn.pro
implement fn
    open core
class predicates
   fact:(integer, integer)
               procedure (i,o).
clauses
    classInfo("forms/fn", "1.0").

    fact(0, 1) :- !.
    fact(N, N*F) :- fact(N-1, F).
    calculate(X) :-  N= toterm(X),
        fact(N, F), stdio::write(F, "\n").
end implement fn