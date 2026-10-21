/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
class classQ

predicates
    push : (string Name, real Amount) procedure (i,i).
    peek : (string Name, real Amount) procedure (o,o).
    pop : (string Name, real Amount) procedure (o,o).
    listQ : ().
    duplicate : (string Name, real Amount) procedure (o,o).
    swap : (string Name1, real Amount1, string Name2, real Amount2) determ (o,o,o,o).

end class classQ