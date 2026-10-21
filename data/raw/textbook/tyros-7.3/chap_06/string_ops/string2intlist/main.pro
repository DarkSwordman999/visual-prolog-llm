implement main
clauses
    classInfo("main", "hasdomain_example").

    run():- console::init(),
         hasdomain(core::integer_list, Xs),
         Xs= toTerm(stdio::readLine()),
         stdio::write(Xs), stdio::nl.
end implement  main
goal   mainExe::run(main::run).
