/*****************************************************************************

		Copyright (c) My Company

 Project:  LAB_20
 FileName: LAB_20.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

domains
	lst = integer*.
	
predicates
	create_lst_morethan(lst, integer, lst).
	create_lst_morethan(lst, integer, lst, lst).
	
	create_lst_morethan_2(lst, integer, lst).
	
	
	create_lst_oddpos(lst, lst).
	create_lst_oddpos(lst, lst, lst).
	
	create_lst_oddpos_2(lst, lst).
	
	
	delete_element_all(lst, integer, lst).
	delete_element_all(lst, integer, lst, lst).
	
	delete_element_all_2(lst, integer, lst).
	
	
	create_set(lst, lst).
	create_set(lst, lst, lst).
	
	create_set_2(lst, lst).

	
clauses
	% create list from elements that more than number
	% 1. non-optimized
	create_lst_morethan([X|T], Num, Res_temp, Res) :-	% X - 1st element [index = 0] 
		X > Num,					% T - tail
		Temp = [X|Res_temp], 				% Num - control number 
		create_lst_morethan(T, Num, Temp, Res),		% Res_temp - temporary list
		!.						% Res - result
	create_lst_morethan([_|T], Num, Res_temp, Res) :- 	% Temp - temporary var
		create_lst_morethan(T, Num, Res_temp, Res),	% Lst - list
		!.						
	create_lst_morethan([], _, Res, Res) :- !.		
	create_lst_morethan(Lst, Num, Res) :- 			
		create_lst_morethan(Lst, Num, [], Res), 
		!.
	
	
	% 2. optimized
	create_lst_morethan_2([X|T], Num, [X|Res_tail]) :-	% X - 1st element [index = 0]
		X > Num,					% T - tail 
		create_lst_morethan_2(T, Num, Res_tail),	% Num - control number
		!.						% Res_tail - result tail
	create_lst_morethan_2([_|T], Num, Res_tail) :- 
		create_lst_morethan_2(T, Num, Res_tail),
		!.
	create_lst_morethan_2([], _, []) :- !.
	
	
	%------------------------------------------------------------	
	% create list from elements that stands in the odd positions
	% 1. non-optimized
	create_lst_oddpos([_, X|T], Res_temp, Res) :-			% X - 2nd element [index = 1], T - tail
		Temp = [X|Res_temp],					% Res_temp - temporary list, Res - result
		create_lst_oddpos(T, Temp, Res),			% Temp - temporary var
		!.
	create_lst_oddpos([_], Res, Res) :- !.
	create_lst_oddpos([], Res, Res) :- !.
	create_lst_oddpos(Lst, Res) :- 
		create_lst_oddpos(Lst, [], Res),
		!.
		
		
	% 2. optimized
	create_lst_oddpos_2([_, X|T], [X|Res_tail]) :-			% X - 2nd element [index = 1], T - tail 
		create_lst_oddpos_2(T, Res_tail),			% Res_tail - result list
		!.
	create_lst_oddpos_2([_], []) :- !.
	create_lst_oddpos_2([], []) :- !.
	
	
	%------------------------------------------------------------
	% delete element (all occurrence)
	% 1. non-optimized
	delete_element_all([X|T], Num, Res_temp, Res) :-		% X - 1st element [index = 0], T - tail, Num - control number	
		X = Num,						% Res_temp - temporary list, Res - result
		delete_element_all(T, Num, Res_temp, Res),		% Lst - list
		!.							% Temp - temporary var
	delete_element_all([X|T], Num, Res_temp, Res) :-
		Temp = [X|Res_temp],
		delete_element_all(T, Num, Temp, Res),
		!.
	delete_element_all([], _, Res, Res) :- !.
	delete_element_all(Lst, Num, Res) :- 
		delete_element_all(Lst, Num, [], Res),
		!.
	
	
	% 2. optimized
	delete_element_all_2([Num|T], Num, Res_tail) :-			% Num - control number
		delete_element_all_2(T, Num, Res_tail),			% Res_tail - result list
		!.							% X - 1st element [index = 0]
	delete_element_all_2([X|T], Num, [X|Res_tail]) :-		% T - tail
		delete_element_all_2(T, Num, Res_tail),	
		!.							
	delete_element_all_2([], _, []) :- !.
	
	
	%------------------------------------------------------------
	% create set from list
	% 1. non-optimized
	create_set([X|T], Res_temp, Res) :- 				% X - 1st element [index = 0], T - tail, Res_temp - temporary list
		Temp = [X | Res_temp],					% Res - result
		delete_element_all(T, X, T_cor),			% Temp - temporary var
		create_set(T_cor, Temp, Res),				% T_cor - tail after delelition all elements = X
		!.							% Lst - list
	create_set([], Res, Res) :- !.
	create_set(Lst, Res) :- create_set(Lst, [], Res).
	
	
	% 2. optimized
	create_set_2([X|T], [X|Res_tail]) :- 				% X - 1st element [index = 0], T - tail
		delete_element_all_2(T, X, Temp),			% Res_tail - result list
		create_set_2(Temp, Res_tail),				% Temp - tail after delelition all elements = X
		!.			
	create_set_2([], []) :- !.
	
	
goal
	%create_lst_morethan([10, 0, -5, 0, 3], 0, Result).
	%create_lst_morethan_2([10, 0, -5, 0, 3], 0, Result).
	%create_lst_oddpos([10, 0, -5, 1, 9, -9], Result).
	%create_lst_oddpos_2([10, 0, -5, 1, 9, -9], Result).
	%delete_element_all([10, 5, -3, 0, 5], 5, Result).
	%delete_element_all_2([10, 5, -3, 0, 5], 5, Result).
	%create_set([1, 1, 1, 5], Result).
	%create_set_2([1, 1, 1, 5], Result).
	
