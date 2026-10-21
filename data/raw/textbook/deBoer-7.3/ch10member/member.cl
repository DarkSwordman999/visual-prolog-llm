/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
class member
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    member : (integer, integer*) nondeterm (i,i) (o,i).

end class member