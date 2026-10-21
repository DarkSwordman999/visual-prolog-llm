/*****************************************************************************

                        Copyright (c) 2009 

******************************************************************************/
class projectToolbar
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    create : (vpiDomains::windowHandle Parent).

end class projectToolbar