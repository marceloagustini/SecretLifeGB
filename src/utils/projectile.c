#include "projectile.h"
#include "entity.h"
#include "map_manager.h"
#include <string.h>

projectile_t projectiles[MAX_PROJECTILES];

void projectile_init(void) {
  for (int i = 0; i < MAX_PROJECTILES; i++) {
    projectiles[i].active = 0;
    projectiles[i].sprite_id = 30 + i; // Sprites 30-33 for projectiles
  }
}

void projectile_spawn(uint16_t x, uint16_t y, int8_t vx, int8_t vy,
                      uint8_t source) {
  // Find inactive projectile slot
  for (int i = 0; i < MAX_PROJECTILES; i++) {
    if (!projectiles[i].active) {
      projectiles[i].x = x;
      projectiles[i].y = y;
      projectiles[i].vx = vx;
      projectiles[i].vy = vy;
      projectiles[i].source = source;
      projectiles[i].active = 1;
      return;
    }
  }
}

void projectile_update_all(void) {
  for (int i = 0; i < MAX_PROJECTILES; i++) {
    if (projectiles[i].active) {
      projectiles[i].x += projectiles[i].vx;
      projectiles[i].y += projectiles[i].vy;

      // Deactivate if out of bounds
      if (projectiles[i].x < 8 || projectiles[i].x > 248 ||
          projectiles[i].y < 8 || projectiles[i].y > 248) {
        projectiles[i].active = 0;
      }
    }
  }
}

void projectile_render_all(uint16_t camera_x, uint16_t camera_y) {
  uint8_t use_clipping = (current_map == &maps[2] || current_map == &maps[4]);
  for (int i = 0; i < MAX_PROJECTILES; i++) {
    if (projectiles[i].active) {
      uint16_t sx = projectiles[i].x - camera_x + 8;
      uint16_t sy = projectiles[i].y - camera_y + 16;
      if (!use_clipping || sy < 140) {
        if ((sys_time & 1) == 0) { // Flicker every other frame
          move_sprite(projectiles[i].sprite_id, sx, sy);
          set_sprite_tile(projectiles[i].sprite_id, 40);
        } else {
          move_sprite(projectiles[i].sprite_id, 0, 0);
        }
      } else {
        move_sprite(projectiles[i].sprite_id, 0, 0);
      }
    } else {
      move_sprite(projectiles[i].sprite_id, 0, 0); // Hide
    }
  }
}

uint8_t projectile_check_collision(uint16_t px, uint16_t py) {
  for (int i = 0; i < MAX_PROJECTILES; i++) {
    if (projectiles[i].active && projectiles[i].source == 0) {
      int16_t dx = (int16_t)px - (int16_t)projectiles[i].x;
      int16_t dy = (int16_t)py - (int16_t)projectiles[i].y;
      if (dx < 0)
        dx = -dx;
      if (dy < 0)
        dy = -dy;

      if (dx < 8 && dy < 8) {
        projectiles[i].active = 0; // Deactivate on hit
        return 1;
      }
    }
  }
  return 0;
}
uint8_t projectile_check_enemy_collision(entity_t *entities, uint8_t count) {
  for (int i = 0; i < MAX_PROJECTILES; i++) {
    if (projectiles[i].active && projectiles[i].source == 1) { // Player shot
      for (uint8_t j = 0; j < count; j++) {
        entity_t *e = &entities[j];
        if (e->active && e->type == ENT_ENEMY && e->death_timer == 0) {
          int16_t dx = (int16_t)(projectiles[i].x + 4) - (int16_t)(e->x + 8);
          int16_t dy = (int16_t)(projectiles[i].y + 4) - (int16_t)(e->y + 8);
          if (dx < 0)
            dx = -dx;
          if (dy < 0)
            dy = -dy;

          if (dx < 12 && dy < 12) {
            projectiles[i].active = 0; // Destroy projectile
            if (e->health > 0) {
              e->health--;
              e->hit_timer = 20;
              if (e->health == 0) {
                e->death_timer = 35; // Duration of explosion
              }
            }
            return 1;
          }
        }
      }
    }
  }
  return 0;
}
