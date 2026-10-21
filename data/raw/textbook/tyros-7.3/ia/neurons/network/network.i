%File: network.i
interface network
    open core
domains
   example= e(real, real, real).
   examples= example*.
predicates
   setWeight:(tuple{unsigned, real}*) procedure.
   predicted_out:(unsigned, real) procedure (i, o).
   egratia:(unsigned, real, real, real) procedure (i, o, o, o).
   getWgt_nd:(unsigned, real) nondeterm (o, o).
   assertWgt:(unsigned I, real W) procedure (i, i).
   popweight:(unsigned I, real W) procedure (i, i).
   usit:( real*, real) procedure ( i, o).
   setExamples:(examples) procedure (i).
   getWgt:(unsigned, real) procedure (i, o).
   hidden:(unsigned, unsigned*, real) procedure (i, i, o).
   setEx:(unsigned, examples).
end interface network
