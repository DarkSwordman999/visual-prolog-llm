implement ideograms
    open core
clauses
    classInfo("chineseforms/ideograms", "1.0").
class facts - pideograms
    pinyin:(string, string).
class predicates
   pinyin2ideogram:(string, string) procedure (i, o).
   converList:(string*, string) procedure (i, o).
   
clauses
    pinyin("ni^", "\u4f60").
    pinyin("ha^o", "\u597d").
    pinyin("ma", "\u55ce").
    pinyin("wo^", "\u6211").
    pinyin("Ni^", "\u4f60").
    pinyin("`e","\u997f").
    pinyin("bu´","\u4e0d").
    pinyin("zho-ng",  "\u4e2d").
    pinyin("nl", "\n").

pinyin2ideogram(P, Idea) :- pinyin(P, Idea), !.
pinyin2ideogram(P, P).

ideograms(S, Idea) :-
    L= string::split(S, " \n"),
    converList(L, Idea).

converList([], "") :- !. 
converList([P|Ps], Acc) :-
    pinyin2ideogram(P, Idea),
    converList(Ps, Rest),
    Acc= string::concat(Idea, Rest).
end implement ideograms
