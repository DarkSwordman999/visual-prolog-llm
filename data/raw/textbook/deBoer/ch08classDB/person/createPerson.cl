/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
class createPerson : createPerson
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> createPerson CreatePerson.

constructors
    new : (window Parent).

end class createPerson