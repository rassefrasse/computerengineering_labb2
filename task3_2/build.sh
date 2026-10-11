#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
export PICO_SDK_PATH="${PICO_SDK_PATH:-$HOME/pico/pico-sdk}"

# CMake caches absolute paths, so a moved/copied project needs a fresh build dir
if [[ -f build/CMakeCache.txt ]] && \
   ! grep -qxF "CMAKE_HOME_DIRECTORY:INTERNAL=$PWD" build/CMakeCache.txt; then
    echo "Project was moved - clearing old build directory..."
    rm -rf build
fi

mkdir -p build
cd build
cmake ..
make -j"$(nproc)"
echo
echo "Built: $(pwd)/task3_2.uf2"
