/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
class counter
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end
    count : (integer Number) procedure .
    
end class counter