#!/usr/bin/env bash
# Builds, then copies the .uf2 to the Pico. Put the Pico in BOOTSEL mode first
# (hold BOOTSEL while plugging in), or install picotool to skip that step.
set -euo pipefail
cd "$(dirname "$0")"
./build.sh

UF2="build/task3_2.uf2"

if command -v picotool >/dev/null 2>&1 && picotool info >/dev/null 2>&1; then
    picotool load -f -x "$UF2"
    echo "Flashed with picotool."
    exit 0
fi

for d in "/media/$USER/RPI-RP2" "/run/media/$USER/RPI-RP2" \
         "/media/$USER/RP2350" "/run/media/$USER/RP2350"; do
    if [[ -d "$d" ]]; then
        cp "$UF2" "$d/"
        sync
        echo "Flashed to $d. The Pico will reboot into your program."
        exit 0
    fi
done

echo "No Pico found in BOOTSEL mode." >&2
echo "Unplug it, hold BOOTSEL, plug it in, release, then run ./flash.sh again." >&2
exit 1
