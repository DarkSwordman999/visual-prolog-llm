/*****************************************************************************

                         Utah State University

******************************************************************************/
class txtWin : txtWin
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> txtWin TxtWin.

constructors
    new : (window Parent).

end class txtWin