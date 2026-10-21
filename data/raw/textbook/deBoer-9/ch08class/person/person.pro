/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement person

class facts
    createdCount : unsigned := 0.

clauses
    getCreatedCount() = createdCount.

facts
    name : string.

clauses
    new(Name) :-
        name := Name,
        createdCount := createdCount + 1,
        output::myWrite("Hello world, I am a new object. My name is "),
        output::myWrite(getName()),
        output::myWrite(". I am person number "),
        Number = person::getCreatedCount(),
        output::myWrite(Number),
        stdIO::nl().

clauses
    getName() = name.

clauses
    setName(Name) :-
        name := Name.

end implement person
