#include "map_manager.h"
#include "../../res/assets.h"
#include "fade.h"
#include <string.h>

map_t *current_map;

// We will define the maps in a separate data file later,
// for now let's implement the logic.

uint8_t map_get_tile(uint16_t x, uint16_t y) {
  uint16_t tx = x / 8, ty = y / 8;
  if (tx >= current_map->w || ty >= current_map->h)
    return 0;
  return current_map->tiles[ty * current_map->w + tx];
}

uint8_t map_is_solid(uint16_t x, uint16_t y) {
  uint8_t tid = map_get_tile(x, y);
  uint8_t *solid = current_map->solid_tiles;
  while (*solid != 255) {
    if (tid == *solid)
      return 0; // Walkable
    solid++;
  }
  return 1; // Solid
}

portal_t *map_check_portal(uint16_t x, uint16_t y) {
  uint8_t tx = x / 8, ty = y / 8;
  for (uint8_t i = 0; i < current_map->num_portals; i++) {
    if (current_map->portals[i].tx == tx && current_map->portals[i].ty == ty) {
      return &current_map->portals[i];
    }
  }
  return NULL;
}
