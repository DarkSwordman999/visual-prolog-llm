/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
class output
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end
    myWrite : (string ToWrite).
    myWrite : (unsigned ToWrite).

end class output
