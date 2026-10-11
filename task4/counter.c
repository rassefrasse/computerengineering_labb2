#include "hardware/gpio.h"

void link_gpio_set_dir(int pin, int dir)
{
	gpio_set_dir(pin, dir);
}

void link_gpio_put(int pin, int value)
{
		gpio_put(pin, value);
}

void link_gpio_put_all(uint32_t value) {
    gpio_put_all(value);
}
