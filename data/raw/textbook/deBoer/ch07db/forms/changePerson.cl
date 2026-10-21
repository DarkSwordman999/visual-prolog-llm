/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
class changePerson : changePerson
    open core

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

predicates
    display : (window Parent) -> changePerson ChangePerson.

constructors
    new : (window Parent).

end class changePerson