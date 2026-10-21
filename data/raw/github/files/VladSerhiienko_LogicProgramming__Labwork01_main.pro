% Vlad Serhiienko, 10/19/14

implement main
    open core, systemInformation_api

class facts - historicalFactsDb
    historicalEvent : (string Country, unsigned Century, string Desc).

class predicates
    reconsult : (string FileName).
clauses
    reconsult(FileName) :-
        retractFactDb(historicalFactsDb),
        file::consult(FileName, historicalFactsDb).

class predicates
    eventsInRange : (string Country, unsigned Century, string Event, unsigned CenturyFrom, unsigned CenturyTill) nondeterm (o, o, o, i, i).
clauses
    eventsInRange(Country, Century, Event, CenturyFrom, CenturyTill) :-
        historicalEvent(Country, Century, Event),
        Century <= CenturyFrom,
        Century >= CenturyTill.

class predicates
    eventsInCountry : (string Country, unsigned Century, string Event, string DesiredCountry) nondeterm (o, o, o, i).
clauses
    eventsInCountry(Country, Century, Event, DesiredCountry) :-
        historicalEvent(Country, Century, Event),
        Country = DesiredCountry.

clauses
    run() :- % allocate console, read database
        console::init(),
        stdio::write("Vlad Serhiienko, Labwork 1, Task 6\n"),
        reconsult("..\\historicalFactsDb.txt"),
        stdio::nl(),
        fail.

    run() :- % prints all the events to console
        stdio::write("Data:\n"),
        historicalEvent(X, Y, Z),
        stdio::writef("% - %: %\n", Y, X, Z),
        fail.
    run() :-
        stdio::nl(), fail.

    run() :- % prints all Greece events to console
        DesiredContry = "Greece",
        stdio::writef("%:\n", DesiredContry),
        eventsInCountry(X, Y, Z, DesiredContry),
        stdio::writef("% - %: %\n", Y, X, Z),
        fail.
    run() :-
        stdio::nl(), fail.

    run() :- % selects all the events within the specified range
        stdio::write("Query:\n"),
        eventsInRange(X, Y, Z, 18, 11),
        stdio::writef("% - %: %\n", Y, X, Z),
        fail.
    run() :-
        stdio::nl().

end implement main

goal
    console::runUtf8(main::run).