implement main /* kalahGame */
open mv
   
clauses
  classInfo("kalahGame", "1.0").
        
  class predicates
   maxeval:(mv::board, integer, integer, integer, mv::board, integer) procedure (i, i, i, i, o, o).
   mineval:(mv::board, integer, integer, integer, mv::board, integer) procedure (i, i, i, i, o, o).
   bestMax:(mv::board*, integer, integer, integer, mv::board, integer) determ (i, i, i, i, o, o).
   bestMin:(mv::board*, integer, integer, integer, mv::board, integer) determ (i, i, i, i, o, o).
   betaPruning:(mv::board*, integer, integer, integer, mv::board, integer, mv::board, integer) procedure (i, i, i, i, i, i, o, o).
   alphaPruning:(mv::board*, integer, integer, integer, mv::board, integer, mv::board, integer) procedure (i, i, i, i, i, i, o, o).
clauses

   maxeval(Pos, LookAhead, Alpha, Beta, Mov, Val) :-
      LookAhead > 0,
        Lcs = [P || play(Pos, P)],
      bestMax(Lcs, LookAhead - 1, Alpha, Beta, Mov, Val), ! ;
      stateval(Pos, Val),    Mov= none. 
      
   bestMax([Lnc|Lncs], LookAhead, Alpha, Beta, BestMove, BestVal) :- !,
       mineval(Lnc, LookAhead, Alpha, Beta, _, Val),
       betaPruning(Lncs, LookAhead, Alpha, Beta, Lnc, Val, BestMove,  BestVal).

   betaPruning([], _, _, _, Lnc, Val, Lnc, Val) :- !.
   betaPruning(_, _,  _Alpha, Beta, Lnc,  Val, Lnc, Val) :- Val > Beta, !.
   betaPruning(Lncs, LookAhead, Alpha, Beta, Lnc, Val, MLnc, MVal) :-
      if Val > Alpha then NewAlpha= Val else NewAlpha= Alpha end if,
      if bestMax(Lncs, LookAhead, NewAlpha, Beta, Lnc1, Val1),
         Val1 > Val then MLnc= Lnc1, MVal= Val1 else MLnc= Lnc, MVal= Val end if.
      
   mineval(Pos, LookAhead, Alpha, Beta, Mov, Val) :-
        LookAhead > 0,
         Lcs = [P || play(Pos, P)],  
         bestMin(Lcs, LookAhead - 1, Alpha, Beta, Mov, Val), ! ;
          stateval(Pos, Val),    Mov= none. 
          
   bestMin([Lnc|Lncs], LookAhead, Alpha, Beta, BestMove, BestVal) :- !,
       maxeval(Lnc, LookAhead, Alpha, Beta, _, Val),
       alphaPruning(Lncs, LookAhead, Alpha, Beta, Lnc, Val, BestMove,  BestVal).

   alphaPruning([], _, _, _, Lnc, Val, Lnc, Val) :- !.
   alphaPruning(_, _, Alpha, _Beta, Lnc,  Val, Lnc, Val) :- Val < Alpha, !.
   alphaPruning(Lncs, LookAhead, Alpha, Beta, Lnc, Val, MLnc, MVal) :-
      if Val < Beta then NewBeta= Val else NewBeta= Beta end if,
      if bestMin(Lncs, LookAhead, Alpha, NewBeta, Lnc1, Val1),
         Val1 < Val then MLnc= Lnc1, MVal= Val1 else MLnc= Lnc, MVal= Val end if.

  class predicates
      readMove:(board, board) procedure (i, o).
   
      legalMove:(core::positive, board) determ.
     game:(board, integer) procedure (i, i).
     endGame:(board) determ (i).
    
     announceWinner:(integer) procedure (i).
   clauses
      
   legalMove(I, t(a, _LM, _P1, _P2, X)) :-
      I >= 0, I < 4,
     list::nth(I, X) > 0. 
                              
   readMove(Pos, ReadPos) :-
       stdio::write("Present situation: "), stdio::nl,
       prtBoard(Pos),
       %stdio::write("Your move: "),
       SR= stdio::readLine(),
       trap(I1= toTerm(SR), _, fail),
       stdio::nl,
       
       legalMove(I1, Pos),
     
       sow(I1, Pos, ReadPos), 
       prtBoard(ReadPos),  !. 
   readMove(Pos, ReadPos) :- 
       stdio::write("Something failed"), stdio::nl,
       readMove(Pos, ReadPos).

   
  endGame(X) :- stateval(X, V),  math::abs(V) > 10, !. 
  endGame(t(a, _LM, _P1, _P2, [I0, I1, I2, I3|_])) :- 
        I0 < 1, I1 < 1, I2 < 1, I3 < 1, !.
  endGame(t(b, _LM, _P1, _P2, [_I0, _I1, _I2, _I3, I4, I5, I6, I7])) :-
        I4 < 1, I5 < 1, I6 < 1, I7 < 1, !.

  game(X, _Val) :-
       endGame(X), !, stateval(X, V),
       prtBoard(X),
       announceWinner(V). 
   game(none, Val) :-
      stdio::write("End game: ", Val),
      announceWinner(Val), !.
   game(Pos, _Val) :-
       readMove(Pos, NewPos),
       maxeval(NewPos, 10, -10, 10, BestMove, BestVal), !,
       
       game(BestMove, BestVal).

   
   
   announceWinner(Val) :- Val > 0, stdio::write("\n I won!\n", Val), !.
   announceWinner(Val) :- Val < 0, stdio::write("\n You won!\n", Val), !.
   announceWinner(_Val) :- stdio::write("\n It is a draw!\n").

           
   run():-  console::init(),
        newboard(a, B),
        stateval(B, Val),
        game(B, Val).

end implement main /* kalahGame */

goal mainExe::run(main::run).
