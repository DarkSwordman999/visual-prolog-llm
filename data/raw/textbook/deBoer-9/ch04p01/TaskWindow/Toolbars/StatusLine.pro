/*****************************************************************************

                        Copyright (c) 2009 Some company

******************************************************************************/

implement statusLine
    open vpiToolbar, resourceIdentifiers

clauses
    create(Parent):-
        _ = vpiToolbar::create(style, Parent, controlList).

% This code is maintained automatically, do not update it manually. 09:55:56-19.6.2009
constants
    style : vpiToolbar::style = tb_bottom().
    controlList : vpiToolbar::control_list =
        [
        tb_text(idt_help_line,tb_context(),452,0,4,10,0x0,"")
        ].
% end of automatic code
end implement statusLine
