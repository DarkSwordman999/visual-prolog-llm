%File: gmember.pro

implement gmember{@Elem}
    open core
    
clauses
    search(H, [H|_] ).
    search(H, [_|T]) :- search(H, T).

    app([], L, L) :- !.
    app([X|Xs], L, [X|Rest]) :- app(Xs, L, Rest). 
end implement gmember
