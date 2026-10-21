% File: account.pro
implement account
    open core
facts - customer
   funds:real := 3.0.
   personalData:(string Name,
          string SocialSecurity) single.
clauses
    classInfo("account", "1.0").

    personalData("", "").

    ssN(SS) :- personalData(_, SS).

    setSocialSecurity(SSN) :- personalData(N, _),
        assert(personalData( N, SSN)).

    deposit(Value) :-  funds := funds+Value.
end implement account
