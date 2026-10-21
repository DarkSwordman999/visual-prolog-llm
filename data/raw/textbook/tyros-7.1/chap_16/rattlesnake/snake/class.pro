%File: click.pro
implement click
    open core
class facts
    tm:vpiDomains::timerId := null.
clauses
       bip(W) :- tm := W:timerSet(1000).
       kill(W) :- W:timerKill(tm).
end implement click