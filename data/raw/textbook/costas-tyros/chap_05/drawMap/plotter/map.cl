/*****************************************************************************

                         Utah State University

******************************************************************************/
class map : map
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> map Map.

constructors
    new : (window Parent).

end class map