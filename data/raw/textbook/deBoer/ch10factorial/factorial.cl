/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
class factorial
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end
    fac : (integer Number, integer Factorial) procedure (i,o).

end class factorial