/*****************************************************************************

                        Copyright (c) 2009 

******************************************************************************/

implement helpWindow
inherits documentwindow

    open core, lottoDomains, vpidomains, resourceidentifiers

constants
    className = "Lotto/helpWindow".
    classVersion = "".

    windowFlags : vpiDomains::wsflags = [wsf_SizeBorder, wsf_TitleBar, wsf_Maximize, wsf_Minimize, wsf_Close, wsf_ClipSiblings, wsf_ClipChildren].
    rectangle : vpiDomains::rct = rct(100, 80, 752, 462).
    menu : vpiDomains::menu = resMenu(id_TaskMenu).
    
    
facts
    filename : string.
    parent : window.
    % isUnicode : boolean.
    
clauses
    new(Parent, FileName) :-
        documentWindow::new(Parent),
        filename := FileName,
        parent := Parent.
        % isUnicode := false.
        
class predicates
    getFileContent : (string Filename, string InputStr, boolean IsUnicode) procedure (i,o,o).
        
clauses
    getFileContent("", "", true) :- !.
    getFileContent(FileName, InputStr, IsUnicode) :-
        InputStr = file::readString(FileName, IsUnicode).

    show():-
        getFileContent(filename, InputStr, _IsUnicode), !,
        ReadOnly = b_false,
        Indent = b_true,
        InitPos = 1,
        % isUnicode := IsUnicode,
        Font = vpi::fontCreate(ff_fixed, [], 8),
        HWND = vpiEditor::create(w_toplevel, rectangle, "Downloaded Lottery Data Preparation for Importing Help", 
            menu, parent:getvpiwindow(), windowFlags, Font, ReadOnly, Indent, InputStr, InitPos, geteventHandler()),
        vpi::winSetFont(HWND, Font).

%    show():-
%        vpiCommonDialogs::note(string::format("File <%s> does not exist", filename)).

clauses
    classInfo(className, classVersion).

end implement helpWindow
