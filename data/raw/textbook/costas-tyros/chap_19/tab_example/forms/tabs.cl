/*****************************************************************************

                         Utah State University

******************************************************************************/
class tabs : tabs
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> tabs Tabs.

constructors
    new : (window Parent).

end class tabs