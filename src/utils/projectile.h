#ifndef PROJECTILE_H
#define PROJECTILE_H

#include <gb/gb.h>
#include <stdint.h>

#define MAX_PROJECTILES 4

typedef struct {
  uint16_t x, y;
  int8_t vx, vy;
  uint8_t active;
  uint8_t sprite_id;
} projectile_t;

extern projectile_t projectiles[MAX_PROJECTILES];

void projectile_init(void);
void projectile_spawn(uint16_t x, uint16_t y, int8_t vx, int8_t vy);
void projectile_update_all(void);
void projectile_render_all(uint16_t camera_x, uint16_t camera_y);
uint8_t projectile_check_collision(uint16_t px, uint16_t py);

#endif
