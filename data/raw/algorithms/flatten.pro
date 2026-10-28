implement main
    open core, stdio
domains
    nested = i(integer); l(nested*).

class predicates
    flatten : (nested* L) -> integer* F.
    append : (integer* A, integer* B) -> integer* C.

clauses
    flatten([]) = [].
    flatten([i(X) | T]) = [X | flatten(T)].
    flatten([l(Inner) | T]) = append(flatten(Inner), flatten(T)).

    append([], B) = B.
    append([H | T], B) = [H | append(T, B)].

clauses
    run() :-
        L = [i(1), l([i(2), l([i(3), i(4)])]), i(5), l([])],
        write(flatten(L), "\n").

end implement main

goal
    console::runUtf8(main::run).
