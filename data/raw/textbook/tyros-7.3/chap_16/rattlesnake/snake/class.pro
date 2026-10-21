%File: click.pro
implement click
    open core
class facts
    tm:vpiDomains::timerId := nullHandle.
clauses
       bip(W) :- tm := W:timerSet(1000).
       kill(W) :- W:timerKill(tm).
end implement click