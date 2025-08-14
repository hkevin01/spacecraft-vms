#include "pubsub.h"
#include <string.h>

static inline size_t inc(size_t v, size_t cap){ return (v + 1U) % cap; }

bool Topic_Init(topic_t *t, void *buf, size_t elem_size, size_t capacity){
  if(!t || !buf || elem_size==0 || capacity<2) return false;
  t->buffer = (uint8_t*)buf;
  t->elem_size = elem_size;
  t->capacity = capacity;
  t->head = t->tail = 0;
  return true;
}

bool Topic_Publish(topic_t *t, const void *elem){
  if(!t || !elem) return false;
  size_t next = inc(t->head, t->capacity);
  if(next == t->tail){
    // full, drop
    return false;
  }
  memcpy(&t->buffer[t->head * t->elem_size], elem, t->elem_size);
  t->head = next;
  return true;
}

bool Topic_TryRead(topic_t *t, void *out){
  if(!t || !out) return false;
  if(t->tail == t->head) return false; // empty
  memcpy(out, &t->buffer[t->tail * t->elem_size], t->elem_size);
  t->tail = inc(t->tail, t->capacity);
  return true;
}
