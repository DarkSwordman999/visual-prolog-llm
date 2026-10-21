/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
class listcom

domains
    name = string.
    address = string.
    age = integer.

predicates
    person : (name, address, age) multi (o,o,o).
    sumlist : (age*, age, integer)  procedure(i,o,o).

end class listcom