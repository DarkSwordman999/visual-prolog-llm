implement main
    open core, stdio
class predicates
    isPermutation : (integer* L) determ.

clauses
    isPermutation(L) :-
        list::sort(L) = [I || I = std::fromTo(1, list::length(L))].

clauses
    run() :-
        write(if isPermutation([3, 1, 2, 5, 4]) then 1 else 0 end if, "\n").

end implement main

goal
    console::runUtf8(main::run).
