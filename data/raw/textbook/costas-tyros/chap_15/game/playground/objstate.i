%File:objstate.i
interface objstate
    open core, vpiDomains
 predicates
     init:().
     turn:(integer, integer).
     mov:().
     segm:(rct) nondeterm (o).
end interface objstate
