/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

interface person
    open core

predicates
    getName : () -> string Name.
    setName : (string Name) procedure (i).
    getNumber : () -> unsigned Number .

end interface person