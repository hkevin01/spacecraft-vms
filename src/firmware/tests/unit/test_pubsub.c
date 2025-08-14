#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include "middleware/pubsub/pubsub.h"

int main(void){
  uint8_t buf[10 * sizeof(int)];
  topic_t t;
  if(!Topic_Init(&t, buf, sizeof(int), 10)){ puts("init fail"); return 1; }
  for(int i=0;i<9;i++){ if(!Topic_Publish(&t, &i)){ puts("pub fail"); return 1; } }
  int x = -1; int count=0; while(Topic_TryRead(&t, &x)){ count++; }
  if(count!=9){ printf("count %d\n", count); return 1; }
  puts("ok");
  return 0;
}
