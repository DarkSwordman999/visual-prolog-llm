implement main
    open core, string
class predicates
   tokenize:(string, string_list) procedure (i, o).
clauses
    classInfo("main",  "string_example").

    tokenize(S, [T|Ts]) :-
        frontToken(S, T, R), !, tokenize(R, Ts).
    tokenize(_, []).

    run():- console::init(),
         L= ["it ", "was ", "in ", "the ",
               "bleak ", "December!"],
         S= concatList(L), UCase= toUpperCase(S),
         RR= string::concat("case: ", Ucase),
         R1= string::concat("It is ", "upper ", RR),
         stdio::write(R1), stdio::nl, tokenize(R1, Us),
         stdio::write(Us), stdio::nl.
end implement main

goal
    mainExe::run(main::run).