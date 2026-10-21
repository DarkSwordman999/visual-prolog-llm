%File: gmember.i

interface gmember{@Elem}
    open core
    
    domains
       list= @Elem*.
    predicates
       search:(@Elem Value, @Elem*) nondeterm (o,i).
       search:(@Elem Value, @Elem*) nondeterm(i, i).
       app:(list, list, list) procedure (i, i, o).
end interface gmember