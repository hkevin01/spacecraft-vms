#pragma once
#include <stddef.h>
#include <stdbool.h>
#include <stdint.h>

typedef struct {
  uint8_t *buffer;
  size_t elem_size;
  size_t capacity;
  volatile size_t head;
  volatile size_t tail;
} topic_t;

bool Topic_Init(topic_t *t, void *buf, size_t elem_size, size_t capacity);
bool Topic_Publish(topic_t *t, const void *elem);
bool Topic_TryRead(topic_t *t, void *out);
