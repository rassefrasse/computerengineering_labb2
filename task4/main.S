.EQU GPIO_OUT, 1
.EQU COUNT_TIME, 1000

.thumb_func
.global main

main:
        
        MOV R4, #0
        MOV R5, #0

initiering:
        MOV R0, R5                    
        BL  gpio_init                 
        MOV R0, R5             
        MOV R1, #GPIO_OUT             
        BL  link_gpio_set_dir         
        ADD R5, #1                    
        CMP R5, #7                    
        BNE initiering          
        B main_loop                   


main_loop:
        LDR R2, =one_to_nine
        LDRB R0, [R2, R4] @ hämtar en byte från minnet och lägger i R0
        BL link_gpio_put_all

        LDR R0, =COUNT_TIME
        BL sleep_ms

        B rakna

rakna:
        ADD R4, #1
        CMP R4, #10
        BNE main_loop
        MOV R4, #0
        B main_loop


.data
.align 4
        one_to_nine: .byte 0b1111110, 0b0110000, 0b1101101, 0b1111001, 0b0110011, 0b1011011, 0b1011111, 0b1110000, 0b1111111, 0b1110011
