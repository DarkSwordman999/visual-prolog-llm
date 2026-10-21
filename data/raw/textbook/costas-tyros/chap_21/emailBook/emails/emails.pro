%File: emails.pro
implement emails
    open core

domains
    contact= email(string, string,  string).

class facts - dbState
   dbase:(chainDB, chainDB::bt_selector) determ.

clauses
    classInfo("db/emails/emails", "1.0").

    data_base_create(FileName) :-
        ChainDB= chainDB::db_create(FileName, chainDB::in_file),
        ChainDB:bt_create("email", ContactName, 40,  21,  1),
        ChainDB:bt_close(ContactName),
        ChainDB:db_close(), !.
    data_base_create(_).

    data_base_open(FileName) :-
        ChainDB= chainDB::db_open(FileName, chainDB::in_file),
        ChainDB:bt_open("email", ContactName),
        assert(dbase(ChainDB, ContactName)).


    data_base_close() :-
        retract(dbase(ChainDB, BTREE)), !,
        ChainDB:bt_close(BTREE),
        ChainDB:db_close().
    data_base_close().

     insert_info(Key, Email, Tipo) :-
       dbase(ChainDB, BTREE),  !,
       ChainDB:chain_insertz( "Contacts",
                            email(Key, Email, Tipo),
                            RefNumber),
       ChainDB:key_insert(BTREE, Key, RefNumber).
    insert_info( _, _, _).


     data_base_search(Name, Contact, Tipo) :- dbase(ChainDB, BTREE),
         ChainDB:key_search(BTREE, Name, Ref),
         ChainDB:ref_term(Ref, Term),
         Term= email(Name,  Contact, Tipo), !.
     data_base_search(_Name, "none", "none").

     class predicates
        getInfo:(chainDB, chainDB::ref, string, string)
                                        procedure (i, i, o, o).
        dbLoop:().
     clauses
        getInfo(ChainDB, Ref, Name, Email) :-
            ChainDB:ref_term(Ref, Term),
            Term= email(Name, Email, _), !.
       
        db_list() :-
            dbase(ChainDB, BTREE),
            ChainDB:key_first(BTREE, Ref), !,
            getInfo(ChainDB, Ref, Name, Email),
            stdio::write(Name, ", ", Email), stdio::nl,
            dbLoop().
        db_list() :- stdio::write("None"), stdio::nl.

        dbLoop() :- dbase(ChainDB, BTREE),
            ChainDB:key_next(BTREE, Ref), !,
            getInfo(ChainDB, Ref, Name, Email),
            stdio::write(Name, ", ", Email), stdio::nl,
            dbLoop().
        dbLoop().

        del(Key) :-
            dbase(ChainDB, BTREE),
            ChainDB:key_search(BTREE, Key, Ref), !,
            ChainDB:key_delete(BTREE, Key, Ref),
            ChainDB:term_delete("Contacts", Ref).
         del(_Key).

end implement emails
