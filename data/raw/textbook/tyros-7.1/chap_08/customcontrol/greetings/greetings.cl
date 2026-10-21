/*****************************************************************************

                         Utah State University

******************************************************************************/
class greetings : greetings
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> greetings Greetings.

constructors
    new : (window Parent).

end class greetings