#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include "middleware/ccsds/ccsds.h"

int main(void){
  uint8_t buf[6];
  ccsds_primary_t ph = {.apid=0x123, .seq=0x1, .length=7, .is_telemetry=true};
  size_t n = ccsds_build_primary(&ph, buf, sizeof(buf));
  if(n!=6){ puts("build len"); return 1; }
  ccsds_primary_t out = {0};
  if(!ccsds_parse_primary(buf, sizeof(buf), &out)){ puts("parse"); return 1; }
  if(out.apid!=0x123 || !out.is_telemetry || out.seq!=1 || out.length!=7){ puts("mismatch"); return 1; }
  puts("ok");
  return 0;
}
