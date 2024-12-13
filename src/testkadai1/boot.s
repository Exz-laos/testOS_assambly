
        BOOT_LOAD equ 0x7c00
        ORG    BOOT_LOAD
%include "../include/macro.s"
entry: 
        jmp   ipl          ;IPL jump
        times 90 - ($ - $$) db 0x90 ;

ipl:    
        cli
        mov   ax, 0x0000
        mov   ds, ax
        mov   es, ax
        mov   ss, ax
        mov   sp, BOOT_LOAD
        sti
       
        mov   [BOOT.DRIVE], dl

        mov cx, 0
.LOOP:     cmp cx, 15
            jge  .E

            cdecl  puts, .s0

            inc  cx
            jmp  .LOOP
.E:
        
        jmp   $           ; while(1);
        ;data
       
.s0    db "Hoge",  0x0A, 0x0D, 0

ALIGN 2, db 0
BOOT:
.DRIVE: dw 0

%include "../modules/real/puts.s"

        times   510 - ($ - $$) db 0x00
        db      0x55, 0xAA
