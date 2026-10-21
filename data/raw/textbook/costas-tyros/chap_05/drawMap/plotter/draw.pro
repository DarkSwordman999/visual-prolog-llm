% File: draw.pro
implement draw
   open core, vpiDomains, vpi
class facts
   city:(string Name, pnt Position).
   conn:(pnt, pnt).
class predicates
   connections:( windowHandle).
   drawCities:(windowHandle).
clauses
   city("Salt Lake", pnt(30, 40)).
   city("Logan", pnt(100, 120)).
   city("Provo", pnt(100, 160)).
   city("Yellowstone", pnt(200, 100)).

   conn(pnt(30, 40) , pnt(100, 120)).
   conn(pnt(100, 120), pnt(100, 160)).
   conn(pnt(30, 40), pnt(200, 100)).

   drawCities(W) :- city(N, P), P= pnt(X1, Y1), X2= X1+10, Y2= Y1+10,
     drawEllipse(W, rct(X1, Y1, X2, Y2)),
     drawText(W, X1, Y1, N), fail.
   drawCities(_Win).

   connections(Win) :- conn(P1, P2), drawLine(Win, P1, P2), fail.
   connections(_Win).

   drawThem(Win) :- connections(Win), drawCities(Win).
end implement draw
