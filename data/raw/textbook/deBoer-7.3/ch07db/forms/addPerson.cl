/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
class addPerson : addPerson
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> addPerson AddPerson.

constructors
    new : (window Parent).

end class addPerson