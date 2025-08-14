#include <stdio.h>
#include "middleware/logging/log.h"
#include "middleware/ccsds/ccsds.h"
#include "middleware/pubsub/pubsub.h"
#include "safety/watchdog.h"

int main(void){
  Log_Info("VMS POSIX booting...\n");
  Watchdog_Init();
  // quick CCSDS self-check
  uint8_t hdr[6];
  ccsds_primary_t ph = {.apid=42,.seq=1,.length=0,.is_telemetry=true};
  size_t n = ccsds_build_primary(&ph, hdr, sizeof(hdr));
  ccsds_primary_t back = {0};
  bool ok = n==6 && ccsds_parse_primary(hdr, sizeof(hdr), &back);
  if(!ok || back.apid!=42 || !back.is_telemetry){
    fprintf(stderr, "CCSDS self-check failed\n");
    return 1;
  }
  Log_Info("VMS POSIX init OK\n");
  return 0;
}
