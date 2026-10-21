% File: nim.cl
class nim
    open core
domains
   ms= integer*.
   hs= ms*.
predicates
    classInfo : core::classInfo.
     game:(hs) determ (i).
end class nim
