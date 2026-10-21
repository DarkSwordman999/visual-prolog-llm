implement main
    open core
class predicates
    foldr:(function{L, B, B}, B,    L*) -> B.
    hd:(L**) -> L*.
    tl:(L**) -> L**.
    tokens:(char*) -> char**.
clauses
   classInfo("main", "1.0").

   foldr(_P, F, [])= C :- C= F.
   foldr(P,  F,  [X|Xs])= C :-  C= P(X, foldr(P, F, Xs)).

   hd(Xs)= C :- if [X|_] = Xs then C=X else C= [] end if.
   tl(Xs)= C :- if [_|R]=Xs then C=R else C=[] end if.

   tokens(List_of_chars)= Words :-
            Wop= {(X, XSS) = C :-
                   if list::isMember(X, [' ', '\n'])
                   then C= [[]|XSS]
                   else if list::isMember(X, [',', '.'])
                             then C=[[],[X]|tl(XSS)]
                             else C= [[X|hd(XSS)]|tl(XSS)]
                          end if
                   end if},
             Words= foldr( Wop , [[]], List_of_chars).

  run():-  console::init(), stdio::nl, stdio::nl,
       ToHelen= "Helen, thy beauty is to me",
        L= string::toCharList(ToHelen), S= tokens(L),
        Words= list::map(S, string::createFromCharList),
        stdio::write(Words).
end implement main

goal
    mainExe::run(main::run).
    