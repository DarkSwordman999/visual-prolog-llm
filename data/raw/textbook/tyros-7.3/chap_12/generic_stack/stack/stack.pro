implement stack{@Elem}
    facts
        stack_fact : (@Elem Value).
    clauses
        push(Value) :-
            asserta(stack_fact(Value)).
    clauses
        pop() = Value :-
            retract(stack_fact(Value)),
            !.
end implement stack