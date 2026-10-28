implement main
    open core, stdio
class predicates
    shift : (char C, integer K) -> char R.
    encrypt : (string S, integer K) -> string R.

clauses
    shift(C, K) = string::getCharFromValue(convert(unsigned16, (V - 97 + K) mod 26 + 97)) :-
        V = string::getCharValue(C),
        V >= 97,
        V <= 122,
        !.
    shift(C, _) = C.

    encrypt(S, K) = string::createFromCharList([shift(C, K) || C in string::toCharList(S)]).

clauses
    run() :-
        Text = "hello, world",
        Secret = encrypt(Text, 3),
        write("Исходный текст: ", Text, "\n"),
        write("Шифр: ", Secret, "\n"),
        write("Расшифровка: ", encrypt(Secret, 26 - 3), "\n").

end implement main

goal
    console::runUtf8(main::run).
