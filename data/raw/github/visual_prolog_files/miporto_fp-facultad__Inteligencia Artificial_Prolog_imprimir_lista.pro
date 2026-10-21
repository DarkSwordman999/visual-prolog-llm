/*****************************************************************************

		Copyright (c) My Company

 Project:  PRUEBAS
 FileName: IMPRIMIR_LISTA.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "pruebas.inc"

domains

       elemento = i(integer);l(lista)
       lista = elemento*

predicates
       imp (lista)

clauses
       imp([]).
       imp([i(Ca)|Tl]):-write(Ca),imp(Tl).
       imp([l(Ca)|Tl]):-imp(Ca),imp(Tl).

goal
       imp( [ i(1),l([i(2),i(3)]) ] ).