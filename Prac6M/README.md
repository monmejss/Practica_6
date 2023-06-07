# Practica 6
## Objetivo
EL objetivo de esta practica es implementar un contador binario. El contador va aumentando la cuenta cada segundo. Al oprimir un boton, el contador cambia su modo y trabaja descendentemente. Si se vuelve a presionas regresa a modo ascendente. 
Ademàs, el contador puede aumentar su velocidad a x2, x4, x8 al oprimir el otro boton. 

## Descripcion de archivos 
### main.s
El código ensamblador de la función `__main` configura el reloj del puerto A. Se configuran los pines de entrada y salida. Del pin A0 al pin A8 son salidas, mientras que el pin A12 y A15 son entradas. 
Ademas, se comienza con la configuracion de las interrupciones externas en la cual se deben habilitar los flancos de subida, deshabilitar flancos de bajada y establecer prioridades. 
Por ultimo, se tiene un bucle `loop` que establece cuando el contador debe aumentar y cuando debe decrementar. 

### exti_isr.s
En este archivo se configura el Systick Handler, esta funcion se ejecuta cuando se produce una interrupcion del SysTick. Para configurarla se debe: 
1. Habilitar el reloj del puerto GPIO (en este caso habilitamos el GPIOA)
2. Configurar entradas de pines
3. Establecer la configuracion de interrupciones externas. 
4. Seleccionar flancos que activen la interrupcion 
5. Habilitar EXTI 
6. Habilitar interrupciones en NVIC
7. Configurar interrupciones elegidas (en este caso EXTI12 - EXTI15) 

### Ejecución del proyecto 
1. Si está clonando el repositorio desde github, debe desvincularlo del repositorio remoto usando el comando 'make unlink'
2. Para eliminar los archivos que resultan del ensamble utilice el comando 'make clean' 
3. Para crear los archivos objeto de los archivos .s y el archivo .bin que se grabará en el microcontrolador emplea el comando 'make'
4. Por último, ejecuta el comando 'make write' para grabar el archivo con extensión .bin que se obtuvo en el paso 3.

### Implementacion 
![Captura desde 2023-06-07 15-07-01](https://github.com/monmejss/Practica_6/assets/122710250/a438180c-fa0a-412e-bbac-cb667dc76e84)


