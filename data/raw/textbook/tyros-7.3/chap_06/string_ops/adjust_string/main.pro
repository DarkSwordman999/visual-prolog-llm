/*********************************
Project Name: adjust_example
UI Strategy:  console
***********************************/

implement main
clauses
  classInfo("main", "adjust_example").
  run():- console::init(),
    FstLn=
      "Rage -- Goddess, sing the rage of Peleus' son Achilles,",
    Str= string::adjust(FstLn, 60, "*", string::right),
    stdio::write(Str), stdio::nl.
end implement main
goal mainExe::run(main::run).