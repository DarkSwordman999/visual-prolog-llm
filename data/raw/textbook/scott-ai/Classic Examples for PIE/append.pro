append([], List, List).
append([X | L1], List2, [X | L3]) :- append(L1, List2, L3).
