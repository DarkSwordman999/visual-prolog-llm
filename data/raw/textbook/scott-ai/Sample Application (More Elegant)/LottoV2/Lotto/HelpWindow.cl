/*****************************************************************************

                        Copyright (c) 2009 

******************************************************************************/
class helpWindow : window
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

constructors
    new : (window Parent, string Filename).

end class helpWindow