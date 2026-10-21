/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
class form1 : form1
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> form1 Form1.

constructors
    new : (window Parent).

end class form1