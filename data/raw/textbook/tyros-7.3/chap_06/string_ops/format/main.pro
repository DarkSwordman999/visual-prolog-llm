implement main
clauses
 classInfo("main",  "formatting").
 run():- console::init(),
    Str1= string::format("%8.3f\n  %10.1e\n", 3.45678,  35678.0),
    Str2= string::format("%d\n %10d\n", 456, 18),
    Str3= string::format("%-10d\n %010d\n", 18, 18),
    stdio::write(Str1, Str2, Str3).
end implement main
goal
    mainExe::run(main::run).
    