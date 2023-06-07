.include "gpio_map.inc"
.include "exti_map.inc"
.cpu cortex-m3     
.section .text
.align	1
.syntax unified
.thumb
.global EXTI_Handler

/*velocidad es r8, modo es r9
EXTI11 - EXTI15 */


EXTI_Handler:
    ldr     r0, =EXTI_BASE
    ldr     r0, [r0, EXTI_PR_OFFSET] 
    cmp     r0, r1
    beq     EXTI12_Handler
    ldr     r1, =0x8000 
    cmp     r0, r1
    beq     EXTI15_Handler
    bx      lr 

EXTI12_Handler:
    cmp     r9, #0
    bne     E3 
    mov     r9, #1
    b       E4
E3: mov r9, #0
E4: ldr     r0, =EXTI_BASE
    ldr     r1, [r0, EXTI_PR_OFFSET]
    ldr     r2, =0x1000
    orr     r1, r2 
    str     r1, [r0, EXTI_PR_OFFSET]
    bx      lr 

EXTI15_Handler:
    cmp     r8, #4
    bge     E1
    add     r8, #1
    b       E2
    
E1: mov     r8, #1
E2: ldr     r0, =EXTI_BASE
    ldr     r1, [r0, EXTI_PR_OFFSET]
    ldr     r2, =0x8000
    orr     r1, r2
    str     r1, [r0, EXTI_PR_OFFSET]
    bx      lr
    

