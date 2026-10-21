/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
class person : person
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

constructors
    new : (string Name).

predicates
    getCreatedCount : () -> unsigned Count.

end class person