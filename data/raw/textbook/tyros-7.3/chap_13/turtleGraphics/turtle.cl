% File: turtle.cl
class turtle
    open core, vpiDomains

    predicates
        classInfo : core::classInfo.
        forward:(windowHandle, integer) procedure.
        move:(integer) procedure.
        right:(real) procedure.
        left:(real) procedure.
end class turtle