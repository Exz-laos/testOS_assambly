get_font_adr:
            push  bp
            mov   bp, sp

            push  ax
            push  bx
            push  si
            push  es
            push  bp
            
            ;start process
            mov   si,  [bp + 4]
            ;font
            mov   ax, 0x1130
            mov   bh, 0x06
            int   10h
            ;fontaddress save


            mov   [si + 0], es
            mov   [si + 2], bp
        



        
  
            pop   bp
            pop   es
            pop   si
            pop   bx
            pop   ax

            mov   sp, bp
            pop   bp

            ret



