/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
class person : person

predicates
    getcreatedcount : () -> unsigned Count.
    showAllPersons : () procedure.
    getAllNames : (string* Nameslist) procedure (o).
    showSinglePerson : (string Name) procedure (i).
    deletePerson : (string Name) procedure (i).

constructors
    new : (string Name).

end class person