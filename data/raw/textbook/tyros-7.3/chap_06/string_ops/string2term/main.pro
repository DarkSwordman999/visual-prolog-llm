implement main
clauses
   classinfo("main", "toTerm_example").
   run():- console::init(),
        Sx= stdio::readLine(),
        hasdomain(real, IX),
        IX= toTerm(Sx),
        stdio::write(IX^2).
end implement  main
goal mainExe::run(main::run).
