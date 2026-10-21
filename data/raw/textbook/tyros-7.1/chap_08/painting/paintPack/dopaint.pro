%File: dopaint.pro
implement dopaint
    open core, vpiDomains
clauses
    bkg(W) :-
       P= [pnt(0,0), pnt(10,80), pnt(150, 100)],
       W:drawPolygon(P).
end implement dopaint
