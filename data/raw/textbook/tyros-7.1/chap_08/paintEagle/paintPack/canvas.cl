/*****************************************************************************

                         Utah State University

******************************************************************************/
class canvas : canvas
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> canvas Canvas.

constructors
    new : (window Parent).

end class canvas