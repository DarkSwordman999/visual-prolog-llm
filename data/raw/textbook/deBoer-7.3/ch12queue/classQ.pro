/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement classQ
    open core

constants
    className = "classQ".
    classVersion = "".

class facts
    q : (string Name, real Amount) nondeterm.
    qout : (string Name, real Amount) determ.

clauses
    classInfo(className, classVersion).

    push(Name, Amount) :-
        assertz(q(Name, Amount)).

    peek(Name, Amount) :-
        q(Name, Amount), !.
    peek("0",0).

    pop(Name, Amount) :-
        retract(q(Name, Amount)), !.
    pop("0",0).

class predicates
    listAllInQueue : () procedure .
clauses
    listQ() :-
        q(_Name, _Amount), !,                                      % Look if there is something in the queue
        listAllInQueue().
    listQ() :-                                                     % When the queue is empty, say so
        stdIO::write("nothing"), stdIO::nl.

    listAllInQueue() :-
        foreach q(Name, Amount)
        do stdIO::write(Name, " ", Amount),
            stdIO::nl
        end foreach.

    duplicate(Name, Amount) :-
        q(Name, Amount), !,
        asserta(q(Name, Amount) ).
    duplicate("0",0).
    
    swap(Name1, Amount1, Name2, Amount2) :-
        retract(q(Name1, Amount1)),                                          % remove the first one in the queue
        assert(qout(Name1, Amount1)),                                      % put the first one in a temporary place
        retract(q(Name2, Amount2)), !,                                           % try get the second one in the queue
        asserta(q(Name1, Amount1)),                                         % put them back in the queue in reversed order
        asserta(q(Name2, Amount2)),
        retract(qout(Name1, Amount1)).                                      % remove the temporary fact
    swap("0",0,"0",0) :-
        retract(qout(Name1, Amount1)),                                     % remove the temporary item
        asserta(q(Name1, Amount1)).                                         % restore it's position in the queue

end implement classQ
