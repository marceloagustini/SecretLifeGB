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
  uint8_t source; // 0 = Enemy, 1 = Player
} projectile_t;

extern projectile_t projectiles[MAX_PROJECTILES];

void projectile_init(void);
void projectile_spawn(uint16_t x, uint16_t y, int8_t vx, int8_t vy,
                      uint8_t source);
void projectile_update_all(void);
void projectile_render_all(uint16_t camera_x, uint16_t camera_y);
struct entity_t;
uint8_t projectile_check_collision(uint16_t px, uint16_t py);
uint8_t projectile_check_enemy_collision(struct entity_t *entities,
                                         uint8_t count);

#endif
