/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
class listcom
    open core

domains
    name = string.
    address = string.
    age = integer.
 
predicates
    person : (name, address, age) multi (o,o,o).
    sumlist : (age*, age, integer)  procedure(i,o,o).

predicates
    classInfo : core::classInfo.
    % @short Class information  predicate. 
    % @detail This predicate represents information predicate of this class.
    % @end

end class listcom