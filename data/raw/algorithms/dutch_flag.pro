implement main
    open core, stdio
class predicates
    split : (integer* L, integer* Z [out], integer* O [out], integer* T [out]).

clauses
    split([], [], [], []).
    split([0 | Rest], [0 | Z], O, T) :-
        !,
        split(Rest, Z, O, T).
    split([1 | Rest], Z, [1 | O], T) :-
        !,
        split(Rest, Z, O, T).
    split([X | Rest], Z, O, [X | T]) :-
        split(Rest, Z, O, T).

clauses
    run() :-
        split([2, 0, 2, 1, 1, 0, 1, 2, 0], Z, O, T),
        write(list::append(Z, O, T), "\n").

end implement main

goal
    console::runUtf8(main::run).
