%File: dopaint.cl
class dopaint
    open core
predicates
    classInfo : core::classInfo.
    draw:(windowGDI).
    invalidrectangle:(vpiDomains::rct) procedure (o).
end class dopaint
