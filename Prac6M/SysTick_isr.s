.cpu cortex-m3    
.section .text
.align	1
.syntax unified
.thumb
.global SysTick_Initialize
.global SysTick_Handler

.include "ivt.s"
.include "systick_map.inc"
.include "scb_map.inc"

SysTick_Initialize:
    ldr     r0, =SYSTICK_BASE
    mov     r1, #0
    str     r1, [r0, STK_CTRL_OFFSET]
    ldr     r2, =262                         
    str     r2, [r0, STK_LOAD_OFFSET]           
    mov     r1, #0
    str     r1, [r0, STK_VAL_OFFSET]            
   
    ldr     r2, =SCB_BASE
    add     r2, SCB_SHPR1_OFFSET               
    mov     r3, #1<<4                             
    strb    r3, [r2, #11]  
    ldr     r1, [r0, STK_CTRL_OFFSET] 
    orr     r1, r1, #3                                        
    str     r1, [r0, STK_CTRL_OFFSET]
    bx      lr 
.size	SysTick_Initialize, .-SysTick_Initialize


SysTick_Handler:
    sub     r10, r10, #1            
    bx      lr                      
.size	SysTick_Handler, .-SysTick_Handler
