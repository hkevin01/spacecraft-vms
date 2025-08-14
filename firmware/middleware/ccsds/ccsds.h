#pragma once
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

typedef struct {
  uint16_t apid;          // 11 bits used
  uint16_t seq;           // 14 bits used
  uint16_t length;        // bytes after primary header - 1
  bool     is_telemetry;  // TM=true, TC=false
} ccsds_primary_t;

size_t ccsds_build_primary(const ccsds_primary_t *ph, uint8_t *out, size_t out_len);
bool   ccsds_parse_primary(const uint8_t *in, size_t in_len, ccsds_primary_t *ph_out);
