memcpy:

       push   bp
       mov    bp, sp
       ;store register
       push   cx
       push   si
       push   di
       ;copy by bite unit 
       cld
       mov    di, [bp + 4]
       mov    si, [bp + 6]
       mov    cx, [bp + 8]

       rep movsb

       pop    di
       pop    si
       pop    cx

       mov    dp, bp
       pop    bp

       ret




