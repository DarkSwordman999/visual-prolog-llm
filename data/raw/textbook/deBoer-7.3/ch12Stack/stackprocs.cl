/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
class stackprocs
    open core

domains
    stringlist = string*.

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    push : (string Element) procedure (i).
    peek : (string Element) determ (o).
    pop : (string Element) determ (o).
    dup : () determ.
    swap : () determ.
    showstack : () .

end class stackprocs