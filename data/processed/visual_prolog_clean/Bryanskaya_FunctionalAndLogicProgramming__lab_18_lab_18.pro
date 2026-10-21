/*****************************************************************************

		Copyright (c) My Company

 Project:  LAB_18
 FileName: LAB_18.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

	
PREDICATES
	fact(integer, integer).
	fact(integer, integer, integer).
	
	fib(integer, integer).
	fib(integer, integer, integer, integer).
	
CLAUSES
	fact(X, -100500) :- X < 0, !.
	fact(0, 1) :- !.
	fact(X, Result) :- fact(X, 1, Result), !.
	
	fact(1, Result, Result) :- !.
	fact(X, Temp, Result) :- 
		Item = X * Temp,
		NewX = X - 1,
		fact(NewX, Item, Result).
		
		
	%----------------------------------------------
	% 0 1 1 2 3 5 8 ...
	
	fib(N, -100500) :- N < 0, !.
	fib(N, Result) :- fib(N, 0, 1, Result), !.
	
	fib(1, Result, _, Result) :- !.	
	fib(N, Sum, Num, Result) :- 
		N_temp = N - 1,
		Sum_temp = Sum + Num,
		fib(N_temp, Num, Sum_temp, Result). 
		
	
GOAL
	%fact(5, Result).
	fib(1, Result).	