.align	1
.global	output
.syntax unified
.thumb
.include "gpio_map.inc" 
.thumb_func
.type	output, %function
.section .text

output:
        ldr     r1, =GPIOA_BASE
        ldr     r2, =0x0000FFFC
        and     r0, r2
        str     r0, [r1, GPIOx_ODR_OFFSET]
        bx	lr
.size	output, .-output
