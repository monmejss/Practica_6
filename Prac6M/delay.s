.align	1
.syntax unified
.thumb
.thumb_func
.type	delay, %function
.global	delay

delay:
        mov     r10, r0         
L1:     cmp     r10, #0         
        bne     L1              
        bx      lr              
.size	delay, .-delay    
  