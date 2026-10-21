/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
class sort

predicates
    insertsort : (integer*, integer*) procedure (i,o).
    insert : (integer, integer*, integer*) procedure (i,i,o).

    selectsort : (integer*, integer*) procedure (i,o).
    smallest : (integer*, integer) procedure (i,o).
    remove : (integer, integer*, integer*) procedure (i,i,o).

    bubblesort : (integer*, integer*) procedure (i,o).
    bubble : (integer*, integer*) determ (i,o).

    quickSort : (integer*, integer*) procedure (i,o).
    split : (integer, integer*, integer*, integer*) procedure (i,i,o,o).
    append : (integer*, integer*, integer*) procedure (i,i,o).

end class sort