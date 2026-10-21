% File:account.i
interface account
    open core
predicates
    ssN:(string SocialSecurity) procedure (o).
    setSocialSecurity:(string SSN) procedure(i).
    deposit:(real).
end interface account
