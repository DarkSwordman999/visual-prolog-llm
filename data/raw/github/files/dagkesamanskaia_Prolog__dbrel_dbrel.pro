% Copyright

implement dbrel
    open core, stdio

facts - familyDb
    person : (unsigned Id, string Name, string).
    parent : (unsigned IdParent, unsigned IdChild).
    male : (unsigned).
    female : (unsigned).
    spouse : (unsigned IdHusband, unsigned IdWife).
    birthYear : (unsigned, integer).
    deathYear : (unsigned, integer).
    pict : (unsigned, string FileBmp).
    bio : (unsigned, string FileTxt).

facts
    filename : string.
    maxId : unsigned := 0.
    personList : person* := [].
    selectedPerson : optional{person} := core::none().

class facts
    currentDb : optional{dbrel} := core::none().

clauses
    new(Filename) :-
        filename := Filename.

    getNewId() = maxId :-
        maxId := maxId + 1.

    person_nd(Id, X, Y) :-
        person(Id, X, Y).

    parent_nd(X, Y) :-
        parent(X, Y).

    male_nd(X) :-
        male(X).

    female_nd(X) :-
        female(X).

    spouse_nd(X, Y) :-
        spouse(X, Y).

    birthYear_nd(X, Y) :-
        birthYear(X, Y).

    deathYear_nd(X, Y) :-
        deathYear(X, Y).

    load() :-
        try
            file::reconsult(filename, familyDb)
        catch Error do
            writef("Error %. Unable to load the database from %.\n", Error, filename)
        end try,
        L = [ Id || person_nd(Id, _, _) ],
        if L <> [] then
            maxId := list::maximum(L)
        end if,
        loadDb().

    save() :-
        file::save(filename, familyDb),
        write("\nИзменения сохранены в базе данных.\n").

predicates
    loadDb : ().
clauses
    loadDb() :-
        person(Id, Name, Titul),
        Person = person::new(Id),
        Person:name := Name,
        Person:titul := Titul,
        if female(Id) then
            Person:sex := "ж"
        end if,
        if parent(F, Id) and male(F) then
            Person:fatherId := F
        end if,
        if parent(M, Id) and female(M) then
            Person:motherId := M
        end if,
        if spouse(Id, W) then
            Person:spouseId := W
        end if,
        if spouse(H, Id) then
            Person:spouseId := H
        end if,
        Person:pictures := [ Bmp || pict(Id, Bmp) ],
        Person:biogr := [ Txt || bio(Id, Txt) ],
        personList := [Person | personList],
        fail.

    loadDb() :-
        personList := list::reverse(personList).

end implement dbrel
