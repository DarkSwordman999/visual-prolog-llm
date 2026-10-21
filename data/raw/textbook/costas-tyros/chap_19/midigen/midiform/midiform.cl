/*****************************************************************************

                         Utah State University

******************************************************************************/
class midiform : midiform
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> midiform Midiform.

constructors
    new : (window Parent).

end class midiform