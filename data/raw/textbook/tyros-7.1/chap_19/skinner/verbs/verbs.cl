/*****************************************************************************

                         Utah State University

******************************************************************************/
class verbs
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end
     read:(string File) procedure (i).
     allVerbs:(string* L) procedure (o).
     pres_root_conj:(string, string, string, string*) procedure (i, i, i, o).
     get_verb_state:(string, string) procedure (o, o).
     next_verb_state:() procedure.
end class verbs