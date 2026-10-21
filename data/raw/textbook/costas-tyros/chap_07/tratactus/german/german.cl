%File: german.cl
class german
   open core, semantic
   predicates
      classInfo : core::classInfo.
      article:(tree, string*, string*) nondeterm (o, i, o).
      noun:(tree, string*, string*) nondeterm (o, i, o).
      nounphr:(tree, string*, string*) nondeterm (o, i, o).
      copula:(tree, string*, string*) nondeterm (o, i, o).
      phr:(tree, string*, string*) nondeterm (o, i, o).
end class german