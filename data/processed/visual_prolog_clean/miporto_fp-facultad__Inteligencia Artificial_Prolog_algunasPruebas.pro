/*****************************************************************************

		Copyright (c) My Company

 Project:  TP1
 FileName: ALGUNASPRUEBAS.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "tp1.inc"

predicates
	vof (Integer,Integer)

clauses
	vof (A,B):-
		not(A>B).

goal
	vof (5,2).