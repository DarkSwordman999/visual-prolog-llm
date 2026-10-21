/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
implement sort

clauses
    insertSort([], []) :- !.
    insertSort([Head | Tail], SortedList) :-
        insertSort( Tail, SortedTail),
        insert(Head, SortedTail, SortedList), !.

    insert(Element, [], [Element]) :- !.
    insert(Element, [Head | Tail], [Element, Head | Tail]) :-
        Element <= Head, !.
    insert(Element, [Head | Tail], [Head | TailWithElement] ) :-
        !,
        insert(Element, Tail, TailWithElement).

	selectsort([],[]):- !.
    selectsort(UnsortedList, [SmallestElement | SortedRestOfList]) :-
        smallest(UnsortedList, SmallestElement),
        remove(SmallestElement, UnsortedList, UnsortedRestOfList), !,
        selectSort(UnsortedRestOfList, SortedRestOfList).

    smallest([Element], Element) :- !.
    smallest([Head | Tail], Head) :-
        smallest(Tail, Element),
        Head <= Element, !.
    smallest([_ | Tail], Element) :-
        smallest(Tail, Element), !.
    smallest(_,0).

    remove(Element, [Element | Tail], Tail) :- !.
    remove(Elem1, [Elem2 | Tail1], [Elem2 | Tail2]) :-
        remove(Elem1, Tail1, Tail2), !.
    remove (_,_,[0]).

    bubbleSort(List, SortedList) :-
        bubble(List, List1), !,
        bubbleSort(List1, SortedList).
    bubbleSort(SortedList, SortedList).

    bubble( [X,Y | Rest], [Y,X | Rest] ) :-
        X > Y ,!.
    bubble( [Z|Rest], [Z | Rest1]) :-
        bubble(Rest, Rest1), !.

    quicksort( [], []) :- !.
    quicksort( [SplitElem | Tail], SortedList) :-
        split(SplitElem, Tail, LowerList, UpperList),
        quicksort(LowerList, SortedLowerList),
        quicksort(UpperList, SortedUpperList),
        append(SortedLowerList, [SplitElem | SortedUpperList], SortedList).

    split( _, [], [], []):- !.
    split(SplitElem, [Head | Tail], [Head | LowerList], UpperList) :-
        Head <= SplitElem, !,
        split(SplitElem, Tail, LowerList, UpperList).
    split(SplitElem, [Head | Tail], LowerList, [Head | UpperList]) :-
        split(SplitElem, Tail, LowerList, UpperList).

    append([], List, List) :- !.
    append([Head | Tail], List2, [Head | List3]) :-
        append(Tail, List2, List3).

end implement sort
