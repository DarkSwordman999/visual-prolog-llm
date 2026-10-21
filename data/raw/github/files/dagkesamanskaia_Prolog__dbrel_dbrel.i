% Copyright

interface dbrel
    open core

predicates
    person_nd : (unsigned Id, string Name, string) nondeterm (o,o,o) (i,o,o) (o,o,i) (o,i,o) (i,i,o) (i,o,i) (o,i,i) (i,i,i).
    parent_nd : (unsigned IdParent, unsigned IdChild) nondeterm (o,o) (i,o) (o,i) (i,i).
    male_nd : (unsigned) nondeterm (o) (i).
    female_nd : (unsigned) nondeterm (o) (i).
    spouse_nd : (unsigned IdHusband, unsigned IdWife) nondeterm (o,o) (i,o) (o,i) (i,i).
    birthYear_nd : (unsigned Id, integer Year) nondeterm (o,o) (i,o) (o,i) (i,i).
    deathYear_nd : (unsigned Id, integer Year) nondeterm (o,o) (i,o) (o,i) (i,i).
    load : ().
    save : ().
    getNewId : () -> unsigned.

properties
    personList : person*.
    selectedPerson : optional{person}.

end interface dbrel
