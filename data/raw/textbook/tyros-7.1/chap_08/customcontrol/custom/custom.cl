/*****************************************************************************

                         Utah State University

******************************************************************************/
class custom : custom
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

constructors
    new : ().

constructors
    new : (containerWindow Parent).

end class custom