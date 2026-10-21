class mv
    open core

domains
   side= a;b.
   board= none ; t(side, integer LastMove,  integer Pot, integer Pot, integer* Brd).
   
predicates
     prtBoard:(board) procedure (i).
     newBoard:(side, board) procedure (i, o).
     addPot:(side, integer, integer, integer,
                   integer, integer) procedure (i,i,i,i, o,o).
     changeSides:(side, side) procedure (i, o).
     sowing:(side, integer,  integer, positive,
                   integer, integer,  integer*,
                   board) procedure (i, i, i, i, i, i, i, o).
     sow:(integer, board, board) procedure (i,i,o).
     
     play:(board, board) nondeterm (i, o).
     stateval:(board, integer) procedure (i, o).
    
end class mv
