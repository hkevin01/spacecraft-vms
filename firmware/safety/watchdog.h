#pragma once
#include <stdint.h>
static inline void Watchdog_Init(void) {}
static inline void Watchdog_Kick(uint32_t channel) { (void)channel; }
