/*****************************************************************************

                         Utah State University

******************************************************************************/

implement fibTab
    inherits userControlSupport
    open core, vpiDomains

constants
    className = "forms/fibTab".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    new(Parent):-
        new(),
        setContainer(Parent).

clauses
    new():-
        userControlSupport::new(),
        generatedInitialize().

class predicates
  fibo:(integer, integer) procedure (i, o).
 
clauses
   fibo(N, F) :-
      if N<2 then F=1
      else 
        fibo(N-1, F1), fibo(N-2, F2),
        F= F1+F2
      end if.

predicates
    onFibClick : button::clickResponder.
clauses
    onFibClick(_Source) = button::defaultAction :-
       Num= edit_ctl:getText(),
       I= toTerm(Num),
       fibo(I, F),  Ans= string::format("fibo(%d)= %d", I, F),
       edit_ctl:setText(Ans).


% This code is maintained automatically, do not update it manually. 22:32:43-4.8.2007
facts
    edit_ctl : editControl.
    fib_ctl : button.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("fibTab"),
        This:setSize(164, 38),
        edit_ctl := editControl::new(This),
        edit_ctl:setText(""),
        edit_ctl:setPosition(10, 10),
        edit_ctl:setWidth(70),
        fib_ctl := button::new(This),
        fib_ctl:setText("Fibonacci"),
        fib_ctl:setPosition(96, 8),
        fib_ctl:setClickResponder(onFibClick).
% end of automatic code
end implement fibTab
