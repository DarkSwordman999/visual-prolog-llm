/*****************************************************************************

		Copyright (c) My Company

 Project:  LAB_19
 FileName: LAB_19.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

domains
	lst = integer*.
	
predicates
	len(lst, integer).
	len(lst, integer, integer).
	
	sum(lst, integer).
	sum(lst, integer, integer).
	
	sum_odd_pos(lst, integer).
	sum_odd_pos(lst, integer, integer).

clauses
	% list's length
	len([_|T], Len_temp, Len) :- 		% T - tail
		Temp = Len_temp + 1,		% Len_temp - temporary length
		len(T, Temp, Len), 		% Len - length
		!.				% Temp - temporary var
	len([], Len, Len).			% Lst - currect list
	len(Lst, Len) :- len(Lst, 0, Len). 	
		
	% sum of elements
	sum([X|T], Sum_temp, Sum) :- 		% X - 1st element
		Temp = Sum_temp + X,		% T - tail
		sum(T, Temp, Sum).		% Sum_temp - temporary sum, Sum - sum
	sum([], Sum, Sum) :- !.			% Temp - temporary var
	sum(Lst, Sum) :- sum(Lst, 0, Sum), !.	% Lst - currect list
		
	% sum of elements in odd positions
	sum_odd_pos([_, X|T], Sum_temp, Sum) :-			% X - 2nd element from head = 1st index
		Temp = Sum_temp + X,				% T - tail
		sum_odd_pos(T, Temp, Sum).			% Sum_temp - temporary sum, Sum - sum
	sum_odd_pos([_], Sum, Sum) :- !.			% Temp - temporary var
	sum_odd_pos([], Sum, Sum) :- !.				% Lst - currect list, result
	sum_odd_pos(Lst, Sum) :- sum_odd_pos(Lst, 0, Sum), !.	
	
goal
	len([1, 2, 4], Len).
	%sum([-5, 0, 5, -9], Sum).
	%sum_odd_pos([-5, 1, 3], Sum).