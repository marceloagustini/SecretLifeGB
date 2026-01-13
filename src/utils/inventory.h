#ifndef INVENTORY_H
#define INVENTORY_H

#include <stdint.h>

typedef struct {
  const char *name;
  const char *description;
  uint8_t icon_tile;
} item_t;

#define MAX_INVENTORY_SIZE 8

extern item_t inventory[MAX_INVENTORY_SIZE];
extern uint8_t inventory_count;

void inventory_init(void);
int8_t inventory_add_item(const char *name, const char *desc, uint8_t icon);
uint8_t inventory_has_item(const char *name);

#endif
