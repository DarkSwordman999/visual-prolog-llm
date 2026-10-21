% File: english.pro
implement english
open core, semantic
clauses
  classInfo("english", "1.0").

  article(case(art, ""), ["the"]).

  noun(case(nom, "Welt"), ["world"]).
  noun(case(nom, "Fall"), ["case"]).
  noun(case(nom, "alles"), ["all"]).

  nounphr( world(T1, T2), list::append(A,N)) :-
          article(T1, A),  noun(T2, N).
  nounphr( case(nom, "alles"), ["all"]).

  copula(world(case(cop, "ist"), T), list::append(["is"], R1)) :-
               nounphr(T, R1).

  phr(world(T1, T2), list::append(Start, S1)) :-
                       nounphr(T1, Start), copula(T2, S1).
end implement english
