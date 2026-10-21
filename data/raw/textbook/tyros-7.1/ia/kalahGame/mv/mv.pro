implement mv
    open core

clauses
     prtBoard(t(S, LM, P1, P2, [I0, I1, I2, I3, I4, I5, I6, I7])) :- !,
            stdio::write("Move: ", LM), stdio::nl,
            if S= a then T= "a" else T= "b" end if,
            stdio::writef("   %4d %4d  %4d %4d\n",   I3, I2, I1,I0), 
            stdio::writef("%4d                   %4d   %s\n", P1, P2, T),  
            stdio::writef("   %4d %4d  %4d %4d\n", I4, I5, I6, I7).
      prtBoard(_) :- stdio::write("None\n").
      
       newBoard(Side, t(Side, -1,  0, 0, [6,6,6,6,  6,6,6,6])).
       
        addPot(a, C,  P1, P2, P1+C+1, P2) :- !.
        addPot(b, C, P1, P2, P1, P2+C+1).
        
        changeSides(a, b) :- !.
        changeSides(b, a).
        
          sow(I, t(Side, _LastMove,  P1, P2, B), NewBoard) :-
          J= I rem 8,
          Counts= list::nth(J, B), !,
          list::setNth(J, B, 0, BA),
          K= (J+1) rem 8,
          sowing(Side, J, Counts, K, P1, P2,  BA,  NewBoard).
  sow(_, T, T).

  sowing(S, LM,  N, K, P1, P2,  BA, NuB) :- N>0,
        C= list::nth(K, BA),
        C > 0,
        C < 3, !,
        list::setNth(K, BA, 0, BB),
        J= (K+1) rem 8,
        addPot(S, C, P1, P2, PP1, PP2),
        sowing(S, LM,  N-1, J, PP1, PP2, BB, NuB).
  sowing(S, LM,  N, K, P1, P2, BA, NuB) :- N > 0, !,
         list::setNth(K, BA, list::nth(K, BA) + 1, BB),
         J= (K+1) rem 8,
         sowing(S, LM,  N-1, J, P1, P2, BB, NuB).
  sowing(S, LM, _, _, P1, P2, BB, t(S1, LM, P1, P2, BB)) :-
       changeSides(S, S1).
  
    stateval(t(_, _, P1, P2, _), P2-P1) :-  !.
    stateval(_, 0).
    
    play(t(a, LM,  P1, P2, L), X) :-
        list::nth(0, L) > 0,
        sow(0, t(a, LM, P1, P2, L), X).
    play(t(a, LM,  P1, P2, L), X) :-
        list::nth(1, L) > 0,
        sow(1, t(a, LM,  P1, P2, L), X).
     play(t(a, LM, P1, P2, L), X) :-
        list::nth(2, L) > 0,
        sow(2, t(a, LM, P1, P2, L), X).
     play(t(a, LM, P1, P2, L), X) :-
        list::nth(3, L) > 0,
        sow(3, t(a, LM, P1, P2, L), X).
      play(t(b, LM, P1, P2, L), X) :-
        list::nth(4, L) > 0,
        sow(4, t(b, LM, P1, P2, L), X).
      play(t(b, LM, P1, P2, L), X) :-
        list::nth(5, L) > 0,
        sow(5, t(b, LM, P1, P2, L), X).
      play(t(b, LM, P1, P2, L), X) :-
        list::nth(6, L) > 0,
        sow(6, t(b, LM, P1, P2, L), X).
      play(t(b, LM, P1, P2, L), X) :-
        list::nth(7, L) > 0,
        sow(7, t(b, LM, P1, P2, L), X).       
end implement mv
