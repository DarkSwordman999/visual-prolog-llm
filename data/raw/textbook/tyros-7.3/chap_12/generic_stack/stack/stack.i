interface stack{@Elem}
    predicates
        push : (@Elem Value).
        pop : () -> @Elem Value determ.
end interface stack