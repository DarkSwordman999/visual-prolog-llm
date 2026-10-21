%File: grammar.pro
implement grammar
    open core, string
    class predicates
       strTok:(string, string_list) procedure (i, o).
       addExplanation:(string, string) procedure (i, o).
    class facts
       entry:(string, string).
    clauses
       classInfo( "editor/grammar",  "1.0").

       entry("que", "that").
       entry("sine", "without").
       entry("es", "am, are, is, was, were, to be").
       entry("de", "of").
       entry("et", "and").

       addExplanation(T, R) :- entry(T, Meaning), !,
            R= format("%s= %s\n", T, Meaning).
       addExplanation(_T, "").

       strTok(S, [T1|L]) :- frontToken(S, T, Rest), !,
                  addExplanation(T, T1), strTok(Rest, L).
       strTok(_S, []).

        dic(S) :- strTok(S, SList),
           Resp= concatList(SList),
           stdio::write(Resp), stdio::nl.
end implement grammar
