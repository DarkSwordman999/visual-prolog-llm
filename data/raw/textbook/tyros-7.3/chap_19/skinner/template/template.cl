/*****************************************************************************

                         Utah State University

******************************************************************************/
class template
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end
check_present:(string, string*, string) procedure (i, i, o).
check_it:(string, string*, string) determ (i,i,o).
end class template