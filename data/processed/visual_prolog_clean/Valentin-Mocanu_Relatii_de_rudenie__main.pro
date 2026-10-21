% Copyright

implement main
    open core

domains
    gen = fata; baiat.

class facts - fapteFamilia % faptele de baza (cele reale vor fi incarcate din fisierul "familia.txt")
    persoana : (string Nume, gen Gen).
    parinte : (string Persoana, string Copil).
    cupluCasatorit : (string Sot, string Sotie).

class predicates
    fiu : (string Fiu, string Parinte) nondeterm anyflow.
clauses
    fiu(Fiu, Parinte) :-
        parinte(Parinte, Fiu),
        persoana(Fiu, baiat).

class predicates
    tata : (string Tata, string Copil) nondeterm anyflow.
clauses
    tata(Tata, Copil) :-
        parinte(Tata, Copil),
        persoana(Tata, baiat).

class predicates
    bunic : (string Bunic, string Nepot) nondeterm anyflow.
clauses
    bunic(Bunic, Nepot) :-
        parinte(Bunic, Parinte),
        parinte(Parinte, Nepot),
        persoana(Bunic, baiat).

class predicates
    bunica : (string Bunica, string Nepot) nondeterm anyflow.
clauses
    bunica(Bunica, Nepot) :-
        parinte(Bunica, Parinte),
        parinte(Parinte, Nepot),
        persoana(Bunica, fata).

class predicates
    stramos : (string Stramos, string Persoana) nondeterm anyflow.
clauses
    stramos(Stramos, Persoana) :-
        parinte(Stramos, Persoana).
    stramos(Stramos, Persoana) :-
        parinte(Stramos, AltaPersoana),
        stramos(AltaPersoana, Persoana).

class predicates
    unchi : (string Unchi, string Nepot) nondeterm anyflow.
clauses
    unchi(Unchi, Nepot) :-
        parinte(Parinte, Nepot),
        frate(Unchi, Parinte).

class predicates
    matusa : (string Matusa, string Nepot) nondeterm anyflow.
clauses
    matusa(Matusa, Nepot) :-
        parinte(Parinte, Nepot),
        sora(Matusa, Parinte).

class predicates
    frate : (string Frate, string Persoana) nondeterm anyflow.
clauses
    frate(Frate, Persoana) :-
        parinte(Parinte, Frate),
        parinte(Parinte, Persoana),
        persoana(Frate, baiat),
        Frate <> Persoana.

class predicates
    sora : (string Sora, string Persoana) nondeterm anyflow.
clauses
    sora(Sora, Persoana) :-
        parinte(Parinte, Sora),
        parinte(Parinte, Persoana),
        persoana(Sora, fata),
        Sora <> Persoana.

class predicates
    cumnat : (string Cumnat, string Persoana) nondeterm anyflow.
clauses
    cumnat(Cumnat, Persoana) :-
        cupluCasatorit(Sot, Persoana),
        parinte(Parinte, Sot),
        parinte(Parinte, Frate),
        persoana(Frate, baiat),
        Cumnat = Frate.

class predicates
    cumnata : (string Cumnata, string Persoana) nondeterm anyflow.
clauses
    cumnata(Cumnata, Persoana) :-
        cupluCasatorit(Persoana, Sot),
        parinte(Parinte, Sot),
        parinte(Parinte, Sora),
        persoana(Sora, fata),
        Cumnata = Sora.

class predicates
    numeSot : (string NumeSot, string NumeSotie) nondeterm anyflow.
clauses
    numeSot(NumeSot, NumeSotie) :-
        cupluCasatorit(NumeSot, NumeSotie),
        persoana(NumeSot, baiat).

clauses
    run() :-
        file::consult("..\\familia.txt", fapteFamilia), % incarca faptele din fisierul "familia.txt"
        console::init(),
        stdio::write("-------------------------------------\n"),
        stdio::write("Lista fiilor:\n"),
        fiu(Fiu, Parinte),
        stdio::write("\t", Fiu, " este fiul lui ", Parinte, "\n"),
        fail.

    run() :-
        stdio::write("-------------------------------------\n"),
        stdio::write("Lista tatilor:\n"),
        tata(Tata, Copil),
        stdio::write("\t", Tata, " este tatal lui ", Copil, "\n"),
        fail.

    run() :-
        stdio::write("-------------------------------------\n"),
        stdio::write("Lista unchilor:\n"),
        unchi(Unchi, Nepot),
        stdio::write("\t", Unchi, " este unchiul lui ", Nepot, "\n"),
        fail.

    run() :-
        stdio::write("-------------------------------------\n"),
        stdio::write("Lista matusilor:\n"),
        matusa(Matusa, Nepot),
        stdio::write("\t", Matusa, " este matusa lui ", Nepot, "\n"),
        fail.

    run() :-
        stdio::write("-------------------------------------\n"),
        stdio::write("Lista cumnatilor:\n"),
        cumnat(Cumnat, Persoana),
        stdio::write("\t", Cumnat, " este cumnatul lui ", Persoana, "\n"),
        fail.

    run() :-
        stdio::write("-------------------------------------\n"),
        stdio::write("Lista cumnatelor:\n"),
        cumnata(Cumnata, Persoana),
        stdio::write("\t", Cumnata, " este cumnata lui ", Persoana, "\n"),
        fail.

    run() :-
        stdio::write("-------------------------------------\n"),
        stdio::write("Lista bunicilor (masculin):\n"),
        bunic(Bunic, Nepot),
        stdio::write("\t", Bunic, " este bunicul lui ", Nepot, "\n"),
        fail.

    run() :-
        stdio::write("-------------------------------------\n"),
        stdio::write("Lista bunicilor (feminin):\n"),
        bunica(Bunica, Nepot),
        stdio::write("\t", Bunica, " este bunica lui ", Nepot, "\n"),
        fail.

    run() :-
        stdio::write("-------------------------------------\n"),
        stdio::write("Lista stramosilor din partea tatalui:\n"),
        stramos(Stramos, Persoana),
        persoana(Stramos, baiat),
        stdio::write("\t", Stramos, " este stramosul lui ", Persoana, " din partea tatalui", "\n"),
        fail.

    run() :-
        stdio::write("-------------------------------------\n"),
        stdio::write("Lista stramosilor din partea mamei:\n"),
        stramos(Stramos, Persoana),
        persoana(Stramos, fata),
        stdio::write("\t", Stramos, " este stramosul lui ", Persoana, " din partea mamei", "\n"),
        fail.

    run() :-
        stdio::write("-------------------------------------\n"),
        stdio::write("\nSfarsitul testarii\n"),
        stdio::write("Apasati Enter pentru a iesi..."),
        _ = stdio::readLine().

end implement main

goal
    console::runUtf8(main::run).
