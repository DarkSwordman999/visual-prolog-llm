%File:objstate.pro
implement objstate
open core, vpiDomains
facts
       w:(integer, pnt) nondeterm. % worm
       d:(integer, integer) single. % direction

clauses
  init() :- assert(w(1, pnt(110, 100))),
     assert(w(2, pnt(120, 100))), assert(w(3, pnt(130, 100))),
     assert(w(4, pnt(140, 100))), assert(w(5, pnt(140, 100))).

  d(10, 0).

mov() :- retract(w(1, P)), P= pnt(X1, Y1),
           d(DX, DY), P1= pnt(X1+DX, Y1+DY), assert(w(1, P1)),
           retract(w(2, P2)), assert(w(2, P)),
           retract(w(3,  P3)), assert(w(3, P2)),
           retract(w(4, P4)), assert(w(4, P3)),
           retract(w(5, _)), assert(w(5, P4)), !.
mov().

segm(rct(X, Y, X+10, Y+10)) :- w(_, pnt(X, Y)).
    turn(DX, DY) :- assert(d(DX, DY)).
end implement objstate

