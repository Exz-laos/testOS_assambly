
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
        
        cdecl puts, .s0   
        cdecl reboot

        


        jmp   $           ; while(1);
        ;data
       
.s0     db "Booting...",  0x0A, 0x0D, 0
.s1     db "--------", 0x0A, 0x0D, 0

ALIGN 2, db 0
BOOT:
.DRIVE:    dw 0

%include "../modules/real/puts.s"
%include "../modules/real/itoa.s"
%include "../modules/real/reboot.s"

        times   510 - ($ - $$) db 0x00
        db      0x55, 0xAA
       
       
 