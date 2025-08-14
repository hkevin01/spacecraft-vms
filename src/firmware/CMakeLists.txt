cmake_minimum_required(VERSION 3.23)
project(spacecraft_firmware C)

option(BUILD_POSIX "Build POSIX/SIL target" ON)
set(CMAKE_C_STANDARD 17)

# Warnings and optimization
add_compile_options(
  -Wall -Wextra -Werror -Wshadow -Wpointer-arith -Wstrict-prototypes
  -Wno-unused-parameter -Wformat=2 -Wdouble-promotion -fno-common
  -O2 -ffunction-sections -fdata-sections
)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Build type" FORCE)
endif()

# Kernel: FreeRTOS (POSIX port) fetched via submodule or external - placeholder
# Expect FreeRTOS-Kernel source under external/FreeRTOS-Kernel
set(FREERTOS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/external/FreeRTOS-Kernel)
set(FREERTOS_PORT ${FREERTOS_DIR}/portable/ThirdParty/GCC/Posix)

# Minimal sources for scaffolding
add_library(vms_core
  middleware/ccsds/ccsds.c
  middleware/pubsub/pubsub.c
)

target_include_directories(vms_core PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}
  app
  middleware
  middleware/ccsds
  middleware/pubsub
  middleware/logging
  safety
)

if(BUILD_POSIX)
  add_executable(vms_posix app/posix_main.c bsp/posix/bsp_posix.c)
  target_link_libraries(vms_posix PRIVATE vms_core pthread m)
  enable_testing()
  add_test(NAME vms_smoke COMMAND vms_posix)

  # Unit tests (simple CTest-based)
  add_executable(test_ccsds tests/unit/test_ccsds.c)
  target_link_libraries(test_ccsds PRIVATE vms_core m)
  add_test(NAME test_ccsds COMMAND test_ccsds)

  add_executable(test_pubsub tests/unit/test_pubsub.c)
  target_link_libraries(test_pubsub PRIVATE vms_core m)
  add_test(NAME test_pubsub COMMAND test_pubsub)
endif()
