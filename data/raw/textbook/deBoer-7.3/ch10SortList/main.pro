/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/

implement main
    open core

constants
    className = "main".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
  run():-
        console::init(),
        UnsortedList = [4,2,5,3,1,2,6,4],
        stdIO::write("The unsorted list is: ", UnsortedList),
        stdIO::nl,
        sort::insertsort(UnsortedList, InSortedList),
        stdIO::write("The sorted list (insert sort) is: ",InsortedList),
        stdIO::nl,
        sort::selectsort(UnsortedList, SelSortedList),
        stdIO::write("The sorted list (select sort) is: ",SelsortedList),
        stdIO::nl,
        sort::bubblesort(UnsortedList, BubSortedList),
        stdIO::write("The sorted list (bubblesort) is: ",BubSortedList),
        stdIO::nl,
        sort::quicksort(UnsortedList, QuickSortedList),
        stdIO::write("The sorted list (quicksort) is: ",QuickSortedList),
        _X = stdIO::readchar(),
        succeed().
end implement main

goal
    mainExe::run(main::run).
