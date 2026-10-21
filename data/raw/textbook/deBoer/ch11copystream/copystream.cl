/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
class copystream
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end
    copy : (string InputFileName, string OutputFileName) procedure (i,i).
 
end class copystream