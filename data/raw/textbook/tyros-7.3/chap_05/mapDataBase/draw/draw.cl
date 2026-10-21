% File: draw.cl
class draw
    open core, vpiDomains
predicates
    classInfo : core::classInfo.
    drawThem:(vpiDomains::windowHandle, string) procedure.
end class draw