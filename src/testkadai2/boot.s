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

        mov   cx, 0
.LOOP:  cmp   cx, 15
        jge   .READ_KEY

        cdecl puts, .s0

        inc   cx
        jmp   .LOOP

; .WAIT_KEY:
       ; cdecl puts, .s1    ; Display "Press Enter to exit" message
        
.READ_KEY:
        mov   ah, 0x00    ; BIOS Function: Wait for keypress
        int   0x16        ; Call BIOS keyboard interrupt
        
        cmp   al, 0x0D    ; Compare with Enter key (0x0D)
        jne   .READ_KEY   ; If not Enter, keep waiting
        ;cdecl puts, .s2    ; Display end message
        int 0x19        ; Infinite loop to show we're done

.s0     db "Hoge", 0x0A, 0x0D, 0
; .s1     db "Press Enter to exit", 0x0A, 0x0D, 0
; .s2     db "Program ended!", 0x0A, 0x0D, 0

ALIGN 2, db 0
BOOT:
.DRIVE: dw 0

%include "../modules/real/puts.s"

        times   510 - ($ - $$) db 0x00
        db      0x55, 0xAA