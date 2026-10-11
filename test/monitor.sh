#!/usr/bin/env bash
# Opens the Pico's USB serial output. Exit minicom with Ctrl+A then X.
exec minicom -b 115200 -D /dev/ttyACM0
