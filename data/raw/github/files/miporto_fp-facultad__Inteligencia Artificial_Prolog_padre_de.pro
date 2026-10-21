/*****************************************************************************

		Copyright (c) My Company

 Project:  PRUEBAS
 FileName: PADRE_DE.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "pruebas.inc"

domains
       persona = symbol

predicates
       padre_de(persona,persona)

clauses
       padre_de(juan,pedro).

goal
       padre_de(juan,X).
