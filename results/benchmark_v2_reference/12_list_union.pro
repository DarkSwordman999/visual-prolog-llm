implement main
    open core, stdio
class predicates
    union : (integer* A, integer* B) -> integer* U.

clauses
    union(A, []) = A.
    union(A, [H | T]) = union(A, T) :-
        list::isMember(H, A),
        !.
    union(A, [H | T]) = union(list::append(A, [H]), T).

clauses
    run() :-
        write(union([1, 2, 3], [2, 3, 4, 5]), "\n").

end implement main

goal
    console::runUtf8(main::run).
