/*****************************************************************************

                         Utah State University

******************************************************************************/
class lawn : lawn
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> lawn Lawn.

constructors
    new : (window Parent).

end class lawn