/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
class stackprocs

domains
    stringlist = string*.

predicates
    push : (string Element) procedure (i).
    peek : (string Element) determ (o).
    pop : (string Element) determ (o).
    dup : () determ.
    swap : () determ.
    showstack : () .

end class stackprocs