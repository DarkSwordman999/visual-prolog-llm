/*****************************************************************************

		Copyright (c) My Company

 Project:  PARCIALES
 FileName: MENORELEMENTO.PRO
 Purpose: Dada una lista, devolver el menor elemento
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "parciales.inc"

domains
	lista = Integer*

predicates
	nondeterm menor (lista,Integer)
	nondeterm masChico(Integer,Integer,Integer)

clauses
	menor ([Ca],Ca).
	
	menor ([Ca|[Ca1|Co]],Menor):-
		masChico(Ca,Ca1,N),
		menor ([N|Co],Menor).

	masChico (X,Y,Z):-
		X>Y,Z=Y.

	masChico (X,Y,Z):-
		Y>=X, Z=X.

goal
	menor ([6,16,13,4],Menor).
	