%File: english.cl
class english
open core, semantic
predicates
  classInfo : core::classInfo.
  article:(tree, string*) nondeterm (i,o)(o,o).
  noun:(tree, string*) nondeterm (i,o)(o,o).
  nounphr:(tree, string*) nondeterm (i,o)(o,o).
  copula:(tree, string*) nondeterm (o,o)(i, o).
  phr:(tree, string*) nondeterm (i,o).
end class english
