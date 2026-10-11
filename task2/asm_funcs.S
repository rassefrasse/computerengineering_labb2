.syntax unified
.cpu cortex-m0plus
.thumb

@ int add_asm(int a, int b)   a in r0, b in r1, result returned in r0
.global add_asm
.type add_asm, %function
.thumb_func
add_asm:
    adds r0, r0, r1
    bx   lr
