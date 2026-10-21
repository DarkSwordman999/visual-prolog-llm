%File: dopaint.pro
implement dopaint
    open core, vpiDomains
clauses
  bkg(W) :- P= vpi::pictLoad("frogs.bmp"),
        W:pictDraw(P, pnt(10, 10), rop_SrcCopy),
        Mask= vpi::pictLoad("a3Mask.bmp"),
        Eagle= vpi::pictLoad("a3.bmp"),
        W:pictDraw(Mask,pnt(50, 50),rop_SrcAnd),
       W:pictDraw(Eagle,pnt(50, 50),rop_SrcInvert).
end implement dopaint
