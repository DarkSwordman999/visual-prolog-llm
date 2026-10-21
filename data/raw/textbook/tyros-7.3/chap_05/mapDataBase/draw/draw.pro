% File:draw.pro
implement draw
    open core, vpiDomains, vpi

constants
    className = "draw".
    classVersion = "".

class facts
    city:(string, pnt).

clauses
    classInfo(className, classVersion).

    city("Salt Lake", pnt(30, 40)).
    city("Logan", pnt(100, 120)).
    city("Provo", pnt(100, 80)).
    city("Yellowstone", pnt(200, 100)).

    drawThem(Win, Name) :- B= brush(pat_solid, color_red),
       vpi::winSetBrush(Win, B),
       city(Name, P), !, P= pnt(X1, Y1),
       X2= X1+20, Y2= Y1+20,
       vpi::drawEllipse(Win, rct(X1, Y1, X2, Y2)).
    drawThem(_Win, _Name).
end implement draw
