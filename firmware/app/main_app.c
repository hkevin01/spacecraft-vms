#include "FreeRTOS.h"
#include "task.h"
#include <stdio.h>
#include "middleware/logging/log.h"
#include "safety/watchdog.h"

static void vSupervisor(void *arg) {
  (void)arg;
  Log_Info("VMS booting...\n");
  Watchdog_Init();

  const TickType_t period = pdMS_TO_TICKS(100);
  TickType_t last = xTaskGetTickCount();
  for(;;) {
    Watchdog_Kick(0);
    vTaskDelayUntil(&last, period);
  }
}

void VMS_Start(void) {
  xTaskCreate(vSupervisor, "sup", 2048, NULL, tskIDLE_PRIORITY + 3, NULL);
}
