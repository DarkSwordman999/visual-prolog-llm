/*****************************************************************************

                        Copyright © 

******************************************************************************/
class query : query
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> query Query.

constructors
    new : (window Parent).

end class query