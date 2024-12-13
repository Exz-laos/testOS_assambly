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

.LOOP:  
        cdecl puts, .s0    ; Display "Hoge"
        
        mov   ah, 0x01     ; BIOS Function: Check for keystroke
        int   0x16         ; Call BIOS keyboard interrupt
        jz    .LOOP        ; If no key pressed (ZF=1), continue loop
        
        mov   ah, 0x00     ; BIOS Function: Get keystroke
        int   0x16         ; Read the key
        
        cmp   al, 0x0D     ; Compare with Enter key (0x0D)
        jne   .LOOP        ; If not Enter, continue loop
        
       ; cdecl puts, .s1    ; Display end message
        
       ; jmp   $            ; Infinite loop to show we're done
       int 0x19

.s0     db "Hoge", 0x0A, 0x0D, 0
;.s1     db "Program ended!", 0x0A, 0x0D, 0

ALIGN 2, db 0
BOOT:
.DRIVE: dw 0

%include "../modules/real/puts.s"

        times   510 - ($ - $$) db 0x00
        db      0x55, 0xAA