#include "inventory.h"
#include <string.h>

item_t inventory[MAX_INVENTORY_SIZE];
uint8_t inventory_count = 0;

void inventory_init(void) {
  inventory_count = 0;
  for (uint8_t i = 0; i < MAX_INVENTORY_SIZE; i++) {
    inventory[i].name = "";
  }
}

int8_t inventory_add_item(const char *name, const char *desc, uint8_t icon) {
  if (inventory_count >= MAX_INVENTORY_SIZE)
    return -1;

  inventory[inventory_count].name = name;
  inventory[inventory_count].description = desc;
  inventory[inventory_count].icon_tile = icon;
  inventory_count++;
  return inventory_count - 1;
}

uint8_t inventory_has_item(const char *name) {
  for (uint8_t i = 0; i < inventory_count; i++) {
    if (strcmp(inventory[i].name, name) == 0) {
      return 1;
    }
  }
  return 0;
}
