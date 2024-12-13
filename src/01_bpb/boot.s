entry: 
        jmp   ipl          ;IPL jump
        times 90 - ($ - $$) db 0x90 ;

ipl:  
        jmp   $           ; while(1);

        times   510 - ($ - $$) db 0x00
        db      0x55, 0xAA
 