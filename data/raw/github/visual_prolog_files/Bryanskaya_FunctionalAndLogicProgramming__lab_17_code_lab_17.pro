/*****************************************************************************

		Copyright (c) My Company

 Project:  LAB_17
 FileName: LAB_17.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

	
PREDICATES
	max11(real, real, real).
	max12(real, real, real).
	
	max21(real, real, real, real).
	max22(real, real, real, real).

CLAUSES
	max11(A, B, A) :- A > B.
	max11(A, B, B) :- A <= B.
	
	max12(A, B, A) :- A > B, !.
	max12(_, B, B).
	
	max21(A, B, C, A) :- A > B, A > C.
	max21(A, B, C, B) :- B >= A, B > C.
	max21(A, B, C, C) :- C >= A, C >= B.
	
	max22(A, B, C, A) :- A > B, A > C, !.
	max22(_, B, C, B) :- B > C, !.
	max22(_, _, C, C).
	
	
GOAL
	%max11(-2, 2, Max).
	max21(3, 3, 1, Max).
