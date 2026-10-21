/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/
class person

predicates
    fillDatabase : () procedure.
    listDatabase : () procedure.
    addPerson : (string Name, integer Weight, integer Length, integer IQ) procedure.
    getAllNames : (string* NameList) procedure (o).
    getSomeIDs : (string Name, string* IDList) procedure (i,o) .
    getPerson : (string ID, string Name, integer Weight, integer Length, integer IQ) procedure (i,o,o,o,o) .
	deletePerson : (string ID) procedure (i) .
    changePerson : (string ID, string Name, integer Weight, integer Length, integer IQ) procedure (i, i, i, i, i) .
    saveDatabase : () procedure .
    consultDatabase : () procedure .

end class person