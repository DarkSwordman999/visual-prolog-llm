/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
implement listcom

clauses
    sumlist([],0,0).
    sumlist([H|T], Sum, N):-
        sumlist(T, S1, N1),
        Sum=H+S1, N=1+N1.
    person("Sherlock Holmes",  "22B Baker Street", 42).
    person("Pete Spiers",  "Apt. 22, 21st Street", 36).
    person("Mary Darrow",  "Suite 2, Omega Home", 51).


end implement listcom
