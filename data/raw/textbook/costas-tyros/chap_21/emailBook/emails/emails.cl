%File: emails.cl
class emails
    open core
predicates
    classInfo : core::classInfo.
    data_base_create:(string FileName) procedure (i).
    data_base_open:(string FileName).
    data_base_close:().
    insert_info:(string Name,  string Contact, string Tipo).
    data_base_search:(string Name, string Contact, string Tipo)
                                             procedure (i, o, o).
    db_list:().
    del:(string).
end class emails
