#include "ccsds.h"

// CCSDS Space Packet Primary Header is 6 bytes
// Bits: 0-2 ver(3), 3 type(1), 4 sec hdr flag(1), 5-15 apid(11)
//       0-1 seq flags(2), 2-15 seq count(14)
//       0-15 length

size_t ccsds_build_primary(const ccsds_primary_t *ph, uint8_t *out, size_t out_len){
  if(!ph || !out || out_len < 6) return 0;
  uint16_t word0 = 0;
  word0 |= (0u & 0x7) << 13; // version 0
  word0 |= (ph->is_telemetry ? 0u : 1u) << 12; // type: 0=TM,1=TC
  word0 |= (0u) << 11; // sec hdr flag=0 for now
  word0 |= (ph->apid & 0x7FFu);

  uint16_t word1 = 0;
  word1 |= (3u) << 14; // seq flags: 11 meaning unsegmented
  word1 |= (ph->seq & 0x3FFFu);

  uint16_t word2 = ph->length;

  out[0] = (uint8_t)(word0 >> 8); out[1] = (uint8_t)(word0 & 0xFF);
  out[2] = (uint8_t)(word1 >> 8); out[3] = (uint8_t)(word1 & 0xFF);
  out[4] = (uint8_t)(word2 >> 8); out[5] = (uint8_t)(word2 & 0xFF);
  return 6;
}

bool ccsds_parse_primary(const uint8_t *in, size_t in_len, ccsds_primary_t *ph_out){
  if(!in || in_len < 6 || !ph_out) return false;
  uint16_t word0 = ((uint16_t)in[0] << 8) | in[1];
  uint16_t word1 = ((uint16_t)in[2] << 8) | in[3];
  uint16_t word2 = ((uint16_t)in[4] << 8) | in[5];

  uint16_t ver = (word0 >> 13) & 0x7;
  if(ver != 0) return false;
  uint16_t type = (word0 >> 12) & 0x1;
  ph_out->is_telemetry = (type == 0);
  ph_out->apid = word0 & 0x7FFu;
  ph_out->seq = word1 & 0x3FFFu;
  ph_out->length = word2;
  return true;
}
