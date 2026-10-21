insertion_sort([], []).
insertion_sort([X|Tail], Sorted_List):- 
   insertion_sort(Tail, Sorted_Tail), 
   insert(X, Sorted_Tail, Sorted_List).
  
insert(X, [Y|Sorted_List], [Y|Sorted_List1]):- 
   asc_order(X,Y), !, 
   insert(X, Sorted_List, Sorted_List1).
insert(X, Sorted_List, [X|Sorted_List]).

asc_order(X, Y):- X > Y. 
