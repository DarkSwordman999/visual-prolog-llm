/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
class enterdata : enterdata
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> enterdata Enterdata.

constructors
    new : (window Parent).

end class enterdata