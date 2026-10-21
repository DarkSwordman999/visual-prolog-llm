implement main
clauses
   classInfo("main", "stringops").

   run():- console::init(),
     SndLn=  [ "murderous", "doomed",
               "that cost the Achaeans countless losses"],
     Str= string::concatWithDelimiter(SndLn, ", "),
     Rule= string::create(20, "-"),
     stdio::write(Str), stdio::nl,
     stdio::write(Rule), stdio::nl.
end implement main

goal mainExe::run(main::run).