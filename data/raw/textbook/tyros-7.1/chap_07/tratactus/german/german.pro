%File: german.pro
implement german
   open core, semantic
   clauses
      classInfo("german", "1.0").

      article(case(art, ""), ["die"|Rest], Rest).
      article(case(art, ""), ["der"|Rest], Rest).

      noun(case(nom, "Welt"), ["Welt"|R], R).
      noun(case(nom, "Fall"), ["Fall"|R], R).

      copula(world(case(cop, "ist"), T), ["ist"|R1], R) :-
                     nounphr(T, R1, R).



      nounphr( world(T1, T2), S, End) :-
               article(T1, S, S1), noun(T2, S1, End).
      nounphr( case(nom, "alles"), ["alles"|R], R).

      phr(world(T1, T2), Start, End) :-
              nounphr(T1, Start, S1), copula(T2, S1, End).
end implement german
