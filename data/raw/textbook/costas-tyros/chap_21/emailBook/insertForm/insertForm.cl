/*****************************************************************************

                         Utah State University

******************************************************************************/
class insertForm : insertForm
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> insertForm InsertForm.

constructors
    new : (window Parent).

end class insertForm