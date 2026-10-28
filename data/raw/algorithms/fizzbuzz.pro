implement main
    open core, stdio
class predicates
    word : (integer N) -> string W.

clauses
    word(N) = "FizzBuzz" :-
        N mod 15 = 0,
        !.
    word(N) = "Fizz" :-
        N mod 3 = 0,
        !.
    word(N) = "Buzz" :-
        N mod 5 = 0,
        !.
    word(N) = toString(N).

clauses
    run() :-
        foreach N = std::fromTo(1, 15) do
            write(word(N), "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
