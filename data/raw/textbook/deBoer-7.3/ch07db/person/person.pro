/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement person
    open core, list, file

constants
    className = "person/person".
    classVersion = "".

class facts - personDB
    person : (string ID, string Name, integer Weight, integer Length, integer IQ).

clauses
    classInfo(className, classVersion).

clauses
	fillDatabase() :-
   		assert(person("1", "John", 85, 185, 110)),
        assert(person("2", "Thomas", 75, 190, 150)),
        assert(person("3","Anna", 65, 175, 123)),
        assert(person("4", "Lidy", 55, 160, 135)),
        stdIO::write("Database has been filled"), stdIO::nl.

    listDatabase() :-
        person(ID, Name, Weight, Length, IQ),
        stdIO::write("ID: ", ID, ", Name: ", Name, ", Weight: ", Weight, ", Length: ", Length, ", IQ: ", IQ),        stdIO::nl,
        fail.
    listDatabase().
    
    addPerson(Name, Weight, Length, IQ) :-
        findAll(ID, person(ID, _, _, _, _), IDList),
        IDList <> [], !,
        NewID = toString(toTerm(maximum(IDList)) + 1),
        assertz(person(NewID, Name, Weight, Length, IQ)),
        stdIO::write("Person ", Name, " has been added with ID: ", NewID),
        stdIO::nl.
    addPerson(Name, Weight, Length, IQ) :-
        assertz(person("1", Name, Weight, Length, IQ)),
        stdIO::write("Person ", Name, " has been added with ID: ", "1"),
        stdIO::nl.

    getAllNames(NameList) :-
        findAll(Name, person(_,Name,_,_,_), NameList),
        NameList <> [], !.
    getAllNames([]) :-
        vpiCommonDialogs::error("database is empty").
    
    getSomeIDs(Name,IDList) :-
        findall(ID, person(ID,Name,_,_,_), IDList).

    getPerson(ID, Name, Weight, Length, IQ) :-
        person(ID, Name, Weight, Length, IQ), !.
    getPerson(_ID, "0", 0, 0, 0).

    deletePerson(ID) :-
        retract(person(ID, Name, _, _, _)), !,
        stdIO::write("Person ", Name, " with ID: ", ID, " has been deleted"), stdIO::nl.
    deletePerson(_).

    changePerson(ID, Name, Weight, Length, IQ) :-
        retract(person(ID, _, _, _, _)),
        assertz(person(ID, Name, Weight, Length, IQ)), !,
        stdIO::write("Person ", Name, " with ID: ", ID, " has been changed"), stdIO::nl.
    changePerson(_, _, _, _, _).

    saveDatabase() :-
        file::existFile("personDB.txt"), !,
        file::delete("personDB.txt"),
        file::save("personDB.txt", personDB),
        stdIO::write("The database has been saved to file personDB.txt"), stdIO::nl.
    saveDatabase() :-
        file::save("personDB.txt", personDB),
        stdIO::write("The database has been saved to file personDB.txt"), stdIO::nl.
    
class predicates
    getData : () procedure .
clauses
    consultDatabase() :-
        file::existFile("personDB.txt"), !,
        getData().
    consultDatabase() :-
        vpiCommonDialogs::error("Sorry, can't do what you want", "No file called personDB.txt ").

    getData() :-
        Answer = vpiCommonDialogs::ask("What do you want me to do?",
                                            "Do you want to delete the existing records \n before consulting?",
                                            ["Yes", "No"] ),
        Answer = 0, !,
        retractFactDB(personDB),
        file::consult("personDB.txt", personDB),
        stdIO::write("Existing records have been deleted \n New records have been added from file personDB.txt"), stdIO::nl.
    getData() :-
        file::consult("personDB.txt", personDB),
        stdIO::write("New records have been added from file personDB.txt"), stdIO::nl.

end implement person
