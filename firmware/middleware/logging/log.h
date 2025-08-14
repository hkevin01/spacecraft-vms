#pragma once
#include <stdio.h>
#include <stdarg.h>

static inline void Log_Info(const char *fmt, ...) {
  va_list args; va_start(args, fmt); vfprintf(stdout, fmt, args); va_end(args);
}
static inline void Log_Warn(const char *fmt, ...) {
  va_list args; va_start(args, fmt); vfprintf(stdout, fmt, args); va_end(args);
}
static inline void Log_Error(const char *fmt, ...) {
  va_list args; va_start(args, fmt); vfprintf(stderr, fmt, args); va_end(args);
}
