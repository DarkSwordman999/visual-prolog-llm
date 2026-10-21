/*****************************************************************************

                        Copyright (c) 2009 

******************************************************************************/

implement projectToolbar
    open core, vpiDomains, vpiToolbar, resourceIdentifiers

constants
    className = "TaskWindow/Toolbars/projectToolbar".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    create(Parent):-
        _ = vpiToolbar::create(style, Parent, controlList).

% This code is maintained automatically, do not update it manually. 15:14:06-22.12.2009
constants
    style : vpiToolbar::style = tb_top().
    controlList : vpiToolbar::control_list =
        [
        ].
% end of automatic code
end implement projectToolbar
