/*****************************************************************************

                         Utah State University

******************************************************************************/
class cases
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end
     read:(string File) procedure (i).
     allWords:(string* L) procedure (o).
     declension:(string, string,  string*) procedure (i, i,  o).
     get_number_state:(string) procedure (o).
     next_number_state:() procedure.
end class cases