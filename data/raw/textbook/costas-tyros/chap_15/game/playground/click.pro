% File:click.pro
implement click
    open core
class facts
    tm:vpiDomains::timerId := null.

clauses

    bip(W) :- tm := W:timerSet(500).
    kill() :- vpi::timerKill(tm).

end implement click