/*****************************************************************************

                        Copyright (c) 2009 

******************************************************************************/
class numbers : numbers
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> numbers Numbers.

constructors
    new : (window Parent).

end class numbers