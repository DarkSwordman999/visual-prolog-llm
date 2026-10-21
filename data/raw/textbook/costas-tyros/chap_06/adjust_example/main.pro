/*********************************
  
                      

***********************************/

implement main
clauses
  classInfo("main", "adjust:e.g.").
  run():- console::init(),
    FstLn=
      "Rage -- Goddess, sing the rage of Peleus' son Achilles,",
    Str= string::adjust(FstLn, 60, "*", string::right),
    stdio::write(Str), stdio::nl.
end implement main
goal mainExe::run(main::run).
