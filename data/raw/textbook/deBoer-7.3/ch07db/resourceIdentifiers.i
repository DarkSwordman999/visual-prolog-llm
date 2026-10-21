/************************************************************************
      This file is handled by the Visual Development Environment       
************************************************************************/

interface resourceIdentifiers
constants
    id_taskmenu = 10000.
    id_file = 10001.
    id_file_new = 10002.
    id_file_open = 10003.
    id_file_save = 10004.
    id_file_save_as = 10005.
    id_file_exit = 10006.
    id_edit = 10007.
    id_edit_undo = 10008.
    id_edit_redo = 10009.
    id_edit_cut = 10010.
    id_edit_copy = 10011.
    id_edit_paste = 10012.
    id_edit_delete = 10013.
    id_database = 10014.
    id_database_filldatabase = 10015.
    id_database_listdatabase = 10016.
    id_database_add_person = 10017.
    id_database_change_person = 10018.
    id_database_deleteperson = 10019.
    id_database_consult_database = 10020.
    id_database_save_database = 10021.
    id_help = 10022.
    id_help_contents = 10023.
    id_help_local = 10024.
    id_help_about = 10025.
    idi_errorpresentation_info = 10026.
    idi_errorpresentation_warning = 10027.
    idi_errorpresentation_error = 10028.
    idb_pastebitmap = 10029.
    idb_copybitmap = 10030.
    idb_cutbitmap = 10031.
    idb_redobitmap = 10032.
    idb_undobitmap = 10033.
    idb_helpbitmap = 10034.
    idb_savefilebitmap = 10035.
    idb_openfilebitmap = 10036.
    idb_newfilebitmap = 10037.
    idt_help_line = 10038.

    acceleratorList : vpiDomains::accel_List =
        [
        vpiDomains::a(vpiDomains::k_f1, vpiDomains::c_Nothing, id_help_local), 
        vpiDomains::a(vpiDomains::k_f1, vpiDomains::c_Control, id_help_contents), 
        vpiDomains::a(86, vpiDomains::c_Control, id_edit_paste), 
        vpiDomains::a(67, vpiDomains::c_Control, id_edit_copy), 
        vpiDomains::a(88, vpiDomains::c_Control, id_edit_cut), 
        vpiDomains::a(vpiDomains::k_backtab, vpiDomains::c_ShiftAlt, id_edit_redo), 
        vpiDomains::a(vpiDomains::k_backtab, vpiDomains::c_Alt, id_edit_undo), 
        vpiDomains::a(vpiDomains::k_f2, vpiDomains::c_Nothing, id_file_save), 
        vpiDomains::a(vpiDomains::k_f8, vpiDomains::c_Nothing, id_file_open), 
        vpiDomains::a(vpiDomains::k_f7, vpiDomains::c_Nothing, id_file_new)
        ].
end interface resourceIdentifiers
