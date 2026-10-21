/*****************************************************************************

		Copyright (c) My Company

 Project:  PRUEBAS
 FileName: FACTORIAL.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "pruebas.inc"

predicates
       nondeterm factorial(Integer,Integer)

clauses
       factorial(0,1).
       factorial(N,R):-N>0,N1=N-1,factorial(N1,R1),R=N+R1.

goal
       factorial(3,X).