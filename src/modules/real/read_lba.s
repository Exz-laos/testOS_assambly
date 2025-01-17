read_lba: 

        push  bp
        mov   bp, sp

        push  si

        mov   si, [bp + 4]
        ;--------------------
        ; LBA --> CHS change
        mov   ax, [bp + 6]
        cdecl  lba_chs, si, .chs, ax



        mov     al, [si + drive.no]
        mov   [.chs + drive.no], al
        cdecl  read_chs, .chs, word[bp + 8], word[bp + 10]

        pop    si
        mov    sp, bp
        pop    bp

        ret

.chs:  times   drive_size    db   0