/*****************************************************************************

                         Utah State University

******************************************************************************/
class edform : edform
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> edform Edform.

constructors
    new : (window Parent).

end class edform