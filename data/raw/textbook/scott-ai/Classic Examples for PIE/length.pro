length_of([], 0).
length_of([_ | T], L) :- length_of(T, TailLength), L = TailLength + 1.
