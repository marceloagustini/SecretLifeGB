#include "projectile.h"
#include <string.h>

projectile_t projectiles[MAX_PROJECTILES];

void projectile_init(void) {
  for (int i = 0; i < MAX_PROJECTILES; i++) {
    projectiles[i].active = 0;
    projectiles[i].sprite_id = 37 + i; // Sprites 37-40 for projectiles
  }
}

void projectile_spawn(uint16_t x, uint16_t y, int8_t vx, int8_t vy) {
  // Find inactive projectile slot
  for (int i = 0; i < MAX_PROJECTILES; i++) {
    if (!projectiles[i].active) {
      projectiles[i].x = x;
      projectiles[i].y = y;
      projectiles[i].vx = vx;
      projectiles[i].vy = vy;
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
  for (int i = 0; i < MAX_PROJECTILES; i++) {
    if (projectiles[i].active) {
      uint16_t sx = projectiles[i].x - camera_x + 8;
      uint16_t sy = projectiles[i].y - camera_y + 16;
      move_sprite(projectiles[i].sprite_id, sx, sy);
      set_sprite_tile(projectiles[i].sprite_id, 40);
    } else {
      move_sprite(projectiles[i].sprite_id, 0, 0); // Hide
    }
  }
}

uint8_t projectile_check_collision(uint16_t px, uint16_t py) {
  for (int i = 0; i < MAX_PROJECTILES; i++) {
    if (projectiles[i].active) {
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
