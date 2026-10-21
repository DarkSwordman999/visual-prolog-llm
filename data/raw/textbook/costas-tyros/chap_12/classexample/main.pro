/*****************************************************************************

                         Utah State University

******************************************************************************/

implement main
    open core

constants
    className = "main".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
     run():- console::init(),
        A= account::new(), A:setSocialSecurity("AA345"),
        A:ssN(SocialSecurity),
        stdio::write(SocialSecurity), stdio::nl.
end implement main

goal
    mainExe::run(main::run).
