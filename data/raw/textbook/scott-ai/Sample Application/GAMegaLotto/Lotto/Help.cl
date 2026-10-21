/*****************************************************************************

                        Copyright (c) 2009 

******************************************************************************/
class help : help
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> help Help.

constructors
    new : (window Parent).

end class help