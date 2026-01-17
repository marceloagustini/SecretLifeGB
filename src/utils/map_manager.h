#ifndef MAP_MANAGER_H
#define MAP_MANAGER_H

#include "entity.h"
#include <gb/gb.h>
#include <stdint.h>

typedef struct {
  uint8_t tx, ty; // Tile coordinates of portal
  uint8_t target_map_id;
  uint16_t target_x, target_y;
} portal_t;

typedef struct {
  const unsigned char *tiles;
  uint8_t w, h;
  entity_t *entities;
  uint8_t num_entities;
  uint8_t solid_tiles[16];
  portal_t *portals;
  uint8_t num_portals;
} map_t;

extern map_t maps[];
extern map_t *current_map;

void map_init(void);
void map_load(uint8_t map_id, uint16_t x, uint16_t y);
uint8_t map_get_tile(uint16_t x, uint16_t y);
uint8_t map_is_solid(uint16_t x, uint16_t y);
portal_t *map_check_portal(uint16_t x, uint16_t y);

#endif
