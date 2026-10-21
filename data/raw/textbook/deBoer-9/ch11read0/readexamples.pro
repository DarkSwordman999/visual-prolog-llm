/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/

implement readexamples

domains
    person = person(string Name).

class facts
    intfact : integer := 1.
    stringFact : string := "This is a string".
    functorFact : person := person("Thomas").

clauses
    readSomeTerms(Intfile, StringFile, FunctorFile) :-
        intfact := Intfile:read(),
        stringfact := StringFile:read(),
        functorFact := FunctorFile:read(),
        stdIO::write("I have read: "),
        stdIO::nl,
        stdIO::write("intfact = ", intfact, "\nstringfact = ", stringfact, "\nfunctorFact = ", functorfact),
        stdIO::nl.

end implement readexamples
