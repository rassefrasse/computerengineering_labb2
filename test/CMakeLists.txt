cmake_minimum_required(VERSION 3.13)
set(PICO_BOARD pico)
include(pico_sdk_import.cmake)

project(test C CXX ASM)
set(CMAKE_C_STANDARD 11)
pico_sdk_init()

add_executable(test             
             
    main.S
)

target_link_libraries(test pico_stdlib)

# printf goes over USB serial (/dev/ttyACM0), not the UART pins
pico_enable_stdio_usb(test 1)
pico_enable_stdio_uart(test 0)

# generates .uf2, .bin, .hex and a .dis disassembly
pico_add_extra_outputs(test)
