/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement person

class facts
    createdCount : unsigned := 0.
    createdObjects : person* :=[] .

facts
    name : string.
    number : unsigned :=0.

clauses
    getName() = name.

    setName(Name) :-
        name := Name.

    getNumber() = number.

clauses
    new(Name) :-
        name := Name,
        createdCount := createdCount + 1,
        stdIO::write("Hello World, I am a new object person. My name is: ", getName()),
        number := getCreatedCount(),
        stdIO::write(". My number is: ", number),
        addToObjectsList(This),
        stdIO::nl.

clauses
    getCreatedCount() = createdCount.

predicates
    addToObjectsList : (person NewPerson) procedure (i).
clauses
    addToObjectsList(NewPerson) :-
        createdObjects := [NewPerson | createdObjects].

    showAllPersons() :-
        stdIO::write("These are the persons in the database \n"),
        showAllObjects(createdObjects).

class predicates
    showAllObjects : (person* CreatedObjects).
clauses
    showAllObjects( [Head | Tail]) :-
        stdIO::write("Name: ", Head:getName(), " with number: ", Head:getNumber() ),
        stdIO::nl, !,
        showAllObjects(Tail).
    showAllObjects( [ ] ).

	clauses
	    getAllNames(NamesList) :-
	        getNames(createdObjects, NamesList).

	class predicates
	    getNames : (person* CreatedObjects, string* NamesList) procedure (i,o).
	clauses
	    getNames(ObjectsList, NamesList) :-
	        [Head | Tail] = ObjectsList, !,
	        Name = Head:getName(),
	        getNames(Tail, TailNamesList),
	        NamesList = [Name | TailNamesList].
	    getNames([], []) :- !.

	showSinglePerson(Name) :-
	        getData(Name, createdObjects, Number), !,
	        stdIO::write("You have selected: ", Name, " with number: ", Number),
	        stdIO::nl.
	       	showSinglePerson(_Name).

	class predicates
	    getData : (string Name, person* ObjectList, unsigned Number) determ (i,i,o).
	clauses
	    getData(Name, ObjectsList, Number) :-
	        [Head | Tail] = ObjectsList,
	        Name <> Head:getName(), !,
	        getData(Name, Tail, Number).
	    getData(_Name, ObjectList, Number) :-
	        [Head | _ ] = ObjectList,
	        Number = Head:getNumber().

    deletePerson(Name) :-
        [Object | Tail] = createdObjects,
        Name = Object:getName(), !,
        createdObjects := Tail,
        stdIO::write("Person ", Name, " has been deleted \n").
    deletePerson(Name) :-
        [Object | Tail] = createdObjects,
        createdobjects := Tail,
        deleteperson(Name), !,
        createdObjects := [Object | createdObjects].
    deletePerson(_).

end implement person
