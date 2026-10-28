implement main
    open core, stdio
class facts
    freq : (string Word, integer Count).

class predicates
    addWord : (string W).

clauses
    addWord(W) :-
        retract(freq(W, N)),
        !,
        assert(freq(W, N + 1)).
    addWord(W) :-
        assert(freq(W, 1)).

clauses
    run() :-
        Text = "мама мыла раму мама мыла пол папа мыл раму",
        foreach W in string::split(Text, " ") and W <> "" do
            addWord(W)
        end foreach,
        foreach freq(W, N) do
            write(W, ": ", N, "\n")
        end foreach.

end implement main

goal
    console::runUtf8(main::run).
