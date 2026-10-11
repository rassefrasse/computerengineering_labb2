        .EQU LED_PIN1, 0
        .EQU LED_PIN2, 1
        .EQU LED_PIN3, 2
        .EQU GPIO_OUT, 1

        .EQU SLEEP_TIME, 300
        .EQU COUNT_TIME, 1000

.thumb_func
.global main



main:
        MOV R4, #0
        MOV	R0, #LED_PIN1
	BL	gpio_init
	MOV	R0, #LED_PIN1
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	MOV	R0, #LED_PIN2
	BL	gpio_init
	MOV	R0, #LED_PIN2
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir
	MOV	R0, #LED_PIN3
	BL	gpio_init
	MOV	R0, #LED_PIN3
	MOV	R1, #GPIO_OUT
	BL	link_gpio_set_dir

main_loop:
        LDR R0, = COUNT_TIME
        BL sleep_ms

        MOV R0, #LED_PIN1
        MOV R1, #0
        BL  link_gpio_put
        MOV R0, #LED_PIN2
        MOV R1, #0
        BL  link_gpio_put
        MOV R0, #LED_PIN3
        MOV R1, #0
        BL  link_gpio_put

        MOV R5, #0b001 @ mask
        MOV R6, R4 @ kopia av R4 så att räknaren inte ballar ur
        AND R6, R5 @ jämför bit
        CMP R6, #1 @ bit sparas som 1 om på
        BEQ lampa_ett

kolla_lampa_tva:
        MOV R5, #0b010
        MOV R6, R4
        AND R6, R5
        CMP R6, #2 @ bit sparas som 2 om på
        BEQ lampa_tva

kolla_lampa_tre:
        MOV R5, #0b100
        MOV R6, R4 
        AND R6, R5
        CMP R6, #4 @ bit sparas som 4 om på
        
        BEQ lampa_tre

check:
        CMP R4, #7
        BEQ reset
        ADD R4, #1
        B main_loop

lampa_ett:
        MOV R0, #LED_PIN1
        MOV R1, #1
        BL link_gpio_put
        
        B kolla_lampa_tva

lampa_tva:
        MOV R0, #LED_PIN2
        MOV R1, #1
        BL link_gpio_put

        B kolla_lampa_tre

lampa_tre:
        MOV R0, #LED_PIN3
        MOV R1, #1
        BL link_gpio_put

        B check

reset:
        MOV R4, #0
        B main_loop
