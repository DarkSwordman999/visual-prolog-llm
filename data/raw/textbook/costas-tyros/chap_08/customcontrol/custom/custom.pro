/*****************************************************************************

                         Utah State University

******************************************************************************/

implement custom
    inherits userControlSupport
    open core, vpiDomains

constants
    className = "custom/custom".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    new(Parent):-
        new(),
        setContainer(Parent).

clauses
    new():-
        userControlSupport::new(),
        generatedInitialize().

% This code is maintained automatically, do not update it manually. 00:20:35-1.8.2007
facts

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("custom"),
        This:setSize(192, 80).
% end of automatic code
end implement custom
