# Firmware

FreeRTOS-based flight software with POSIX/SIL and STM32H7 targets.

Build (POSIX/SIL):

```sh
cmake -B build -G Ninja -DBUILD_POSIX=ON
cmake --build build
ctest --test-dir build
```
