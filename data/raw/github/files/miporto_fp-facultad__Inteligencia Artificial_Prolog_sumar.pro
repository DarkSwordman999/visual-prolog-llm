/*****************************************************************************

		Copyright (c) My Company

 Project:  PRUEBAS
 FileName: SUMAR.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "pruebas.inc"

predicates
       nondeterm sumar (integer,integer,integer)

clauses
       sumar(A,B,R):- free(R),R=A+B.
       sumar(A,B,R):- free(B),B=R-A.
       sumar(A,B,R):- free(A),A=R-B.

goal
       sumar(2,3,X),
       sumar(2,Y,5),
       sumar(Z,3,5).
