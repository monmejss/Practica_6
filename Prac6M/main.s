.thumb              @ Assembles using thumb mode
.cpu cortex-m3      @ Generates Cortex-M3 instructions
.syntax unified

.include "ivt.s"
.include "gpio_map.inc"
.include "rcc_map.inc"
.include "systick_map.inc"
.include "scb_map.inc"
.include "afio_map.inc"
.include "exti_map.inc"
.include "nvic_reg_map.inc"

.extern delay
.extern Systick_isr
.extern output

.section .text
.align	1
.syntax unified
.thumb
.global __main

__main:
        # Prologo
        push    {r7, lr}
        sub     sp, #16
        add     r7, sp, #0
setup: 
        # Reloj puerto A
        ldr     r0, =RCC_BASE
        mov     r1, #0x4
        str     r1, [r0, RCC_APB2ENR_OFFSET]

        # Configuracion de pines 
        ldr     r0, =GPIOA_BASE
        ldr     r1, =0x33333333
        str     r1, [r0, GPIOx_CRL_OFFSET]

        ldr     r1, =0x84484433
        str     r1, [r0, GPIOx_CRH_OFFSET] 

        # Interrupciones externas PA
        ldr     r0, =AFIO_BASE
        eor     r1, r1
        str     r1, [r0, AFIO_EXTICR4_OFFSET]

        # Flanco de subida 
        ldr     r0, =EXTI_BASE
        ldr     r1, =0x9000                    
        str     r1, [r0, EXTI_RTST_OFFSET]

        # Flanco de bajada 
        ldr     r1, =0x0
        str     r1, [r0, EXTI_FTST_OFFSET]

        # Configurar interrupciones externas
        ldr     r1, =0x9000
        str     r1, [r0, EXTI_IMR_OFFSET]

        # Prioridad
        ldr     r0, =NVIC_BASE
        add     r0, r0, NVIC_IPR4_OFFSET
        ldr     r1, =0x20              
        strb    r1, [r0, #2]
        ldr     r1, =0x30             
        strb    r1, [r0, #3]

        # Configuracion de NVIC para EXTI10 - EXTI11
        ldr     r0, =NVIC_BASE
        ldr     r1, =0x100
        str     r1, [r0, NVIC_ISER1_OFFSET]

        # Configuracion Systick
        bl      SysTick_Initialize

        mov     r0, #0                 
        str     r0, [r7]               
        mov     r9,  #1      
        mov     r8,  #1
          
loop:  
        mov     r0, r8
        mov     r1, #1000
        lsr     r0, r1, r0 
        bl delay
        /* if modo (r9) = 0
                contador ++ */
        cmp     r9, #0 
        bne     L1
        @ contador ++  
        ldr     r0, [r7]
        add     r0, #1
        str     r0, [r7]
        b       L2 

L1:     /* else 
               contador -- */
        cmp     r9, #1
        bne     L2 

        @ contador --
        ldr     r0, [r7]
        sub     r0, #1
        str     r0, [r7]

L2:     ldr     r0, [r7]
        bl      output
        b       loop 


