/*****************************************************************************

                         University of Groningen, Faculty of Management and Organization

******************************************************************************/
implement main

clauses
    run():-
        console::init(),
        stdIO::writef("a <formatstring> without variables\n"),
        IntegerVar = 12345,
        stdIO::writef("Numbers %5\n wider %10 \n left justified %-10 <-end of field is here", IntegerVar, IntegerVar, IntegerVar),
        RealVar = 12345.6789,
        stdIO::writef("\nRealNumbers %5.4\n wider %10.10\n left justified %-10.4 <-end of field is here\n rounded %5.2", RealVar, RealVar, RealVar, RealVar),
        String = "This is a string",
        stdIO::writef("\nString \n %20|end is here\n %-20|end is here\n %5|end is here\n %20.7|end is here \n", String, String, String, String),
        stdIO::write("\n hit <Enter>"),
        _ = stdIO::readchar(),
        succeed(). % place your own code here
end implement main

goal
    mainExe::run(main::run).
