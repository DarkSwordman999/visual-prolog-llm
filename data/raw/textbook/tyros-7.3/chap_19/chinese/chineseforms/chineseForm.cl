/*****************************************************************************

                         Utah State University

******************************************************************************/
class chineseForm : chineseForm
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> chineseForm ChineseForm.

constructors
    new : (window Parent).

end class chineseForm