#include "entity.h"
#include "map_manager.h"
#include "projectile.h"
#include "text.h"
#include <gb/gb.h>
#include <string.h>

void entity_init(entity_t *e, ent_type_t type, uint16_t x, uint16_t y,
                 uint8_t sprite_base, const char *dialogue) {
  e->type = type;
  e->x = x;
  e->y = y;
  e->sprite_base = sprite_base;
  e->dialogue = dialogue;
  e->active = 1;
  e->dir = 0;
  e->anim_frame = 0;
  e->anim_timer = 0;
  e->move_timer = 0;

  if (type == ENT_ENEMY) {
    e->update = ai_enemy_random_walk;
    e->health = 3;
  } else {
    e->update = ai_npc_static;
    e->health = 0;
  }
  e->hit_timer = 0;
  e->death_timer = 0;
}

void ai_npc_static(entity_t *self) {
  // NPCs generally don't move automatically in this simple implementation
  // But we could add idle animations here
}

void ai_anim_simple(entity_t *self) {
  if (++self->anim_timer > 16) {
    self->anim_frame = !self->anim_frame;
    self->anim_timer = 0;
  }
}

void ai_enemy_random_walk(entity_t *self) {
  if (self->move_timer > 0) {
    self->move_timer--;
    if (self->dir == 0) { // Down
      if (self->y < 240)
        self->y++;
      else
        self->move_timer = 0;
    } else if (self->dir == 1) { // Up
      if (self->y > 16)
        self->y--;
      else
        self->move_timer = 0;
    } else if (self->dir == 2) { // Left
      if (self->x > 16)
        self->x--;
      else
        self->move_timer = 0;
    } else if (self->dir == 3) { // Right
      if (self->x < 240)
        self->x++;
      else
        self->move_timer = 0;
    }

    if (++self->anim_timer > 8) {
      self->anim_frame = !self->anim_frame;
      self->anim_timer = 0;
    }
  } else {
    // Change direction randomly
    uint8_t r = DIV_REG & 0x0F;
    if (r < 4)
      self->dir = r; // 0=D, 1=U, 2=L, 3=R
    else
      self->dir = -1; // Wait/Idle
    self->move_timer = 30 + (DIV_REG & 0x1F);
  }
}

void ai_enemy_shooter(entity_t *self, uint16_t player_x, uint16_t player_y) {
  // Shoot projectiles toward player periodically

  if (++self->move_timer > 60) { // Shoot every 60 frames (~1 second)
    self->move_timer = 0;

    // Calculate direction to player
    int16_t dx = (int16_t)player_x - (int16_t)self->x;
    int16_t dy = (int16_t)player_y - (int16_t)self->y;

    // Normalize to velocity (-2, -1, 0, 1, 2)
    int8_t vx = 0, vy = 0;
    if (dx > 10)
      vx = 2;
    else if (dx < -10)
      vx = -2;
    if (dy > 10)
      vy = 2;
    else if (dy < -10)
      vy = -2;

    if (vx != 0 || vy != 0) {
      projectile_spawn(self->x + 8, self->y + 8, vx, vy, 0);
    }
  }
}

void ai_enemy_chaser_shooter(entity_t *self) {
  extern uint16_t player_x, player_y;

  // 1. Chasing Logic
  // Move every 2nd frame (slower than player)
  if (++self->move_timer > 1) {
    self->move_timer = 0;

    int16_t dx = (int16_t)player_x - (int16_t)self->x;
    int16_t dy = (int16_t)player_y - (int16_t)self->y;

    // Simple axis-aligned movement
    if (dx > 8) {
      self->x++;
      self->dir = 3; // Right
    } else if (dx < -8) {
      self->x--;
      self->dir = 2; // Left
    }

    if (dy > 8) {
      self->y++;
      self->dir = 0; // Down
    } else if (dy < -8) {
      self->y--;
      self->dir = 1; // Up
    }

    // Animate when moving
    if (++self->anim_timer > 8) {
      self->anim_frame = !self->anim_frame;
      self->anim_timer = 0;
    }
  }

  // 2. Shooting Logic
  if (self->shoot_timer > 0) {
    self->shoot_timer--;
  } else {
    // Shoot!
    // Calculate velocity towards player
    int16_t dx = (int16_t)player_x - (int16_t)self->x;
    int16_t dy = (int16_t)player_y - (int16_t)self->y;

    int8_t vx = 0, vy = 0;
    if (dx > 0)
      vx = 2;
    else if (dx < 0)
      vx = -2;
    if (dy > 0)
      vy = 2;
    else if (dy < 0)
      vy = -2;

    projectile_spawn(self->x + 8, self->y + 8, vx, vy, 0);

    // Reset timer to random interval (60-120 frames per second = 1-2 seconds)
    // basic rand: DIV_REG
    self->shoot_timer = 60 + (DIV_REG & 0x3F);
  }
}

void entity_update_all(entity_t *entities, uint8_t count) {
  for (uint8_t i = 0; i < count; i++) {
    if (entities[i].active) {
      if (entities[i].update && entities[i].death_timer == 0 &&
          entities[i].type != ENT_PORTAL)
        entities[i].update(&entities[i]);

      if (entities[i].hit_timer > 0)
        entities[i].hit_timer--;
      if (entities[i].death_timer > 0) {
        entities[i].death_timer--;
        if (entities[i].death_timer == 0) {
          if (entities[i].type == ENT_ENEMY) {
            entities[i].type = ENT_PORTAL;
            entities[i].health = 0;       // Not pickable/hittable
            entities[i].sprite_base = 41; // Use portal tiles
            text_dialogue("¡SE HA ABIERTO\nUN PORTAL!");
          } else {
            entities[i].active = 0;
          }
        }
      }
    }
  }
}

void entity_render_all(entity_t *entities, uint8_t count, uint16_t camera_x,
                       uint16_t camera_y, uint8_t sprite_offset) {
  for (uint8_t i = 0; i < count; i++) {
    entity_t *e = &entities[i];
    if (!e->active) {
      for (int j = 0; j < 4; j++)
        move_sprite(sprite_offset + (i * 4) + j, 0, 0);
      continue;
    }

    uint16_t esx = e->x - camera_x + 8, esy = e->y - camera_y + 16;
    uint8_t use_clipping = (current_map == &maps[2] ||
                            current_map == &maps[4] || current_map == &maps[6]);

    // Handle Flashing Effect (hit_timer)
    if (e->hit_timer > 0 && (e->hit_timer & 2)) {
      for (int j = 0; j < 4; j++)
        move_sprite(sprite_offset + (i * 4) + j, 0, 0);
      continue;
    }

    if (esx < 168 && esy < 160) {
      if (e->death_timer > 0) {
        // Render Explosion (using tiles 45-48)
        for (int j = 0; j < 4; j++) {
          uint8_t sprite_id = sprite_offset + (i * 4) + j;
          uint16_t ty = esy + (j >= 2 ? 8 : 0);
          if (!use_clipping || ty < 140) {
            move_sprite(sprite_id, esx + (j % 2 ? 8 : 0), ty);
            set_sprite_tile(sprite_id, 45 + j);
          } else {
            move_sprite(sprite_id, 0, 0);
          }
        }
      } else if (e->type == ENT_PORTAL) {
        // Render Portal Drop (using tiles 41-44)
        for (int j = 0; j < 4; j++) {
          uint8_t sprite_id = sprite_offset + (i * 4) + j;
          uint16_t ty = esy + (j >= 2 ? 8 : 0);
          if (!use_clipping || ty < 140) {
            move_sprite(sprite_id, esx + (j % 2 ? 8 : 0), ty);
            set_sprite_tile(sprite_id, 41 + j);
          } else {
            move_sprite(sprite_id, 0, 0);
          }
        }
      } else if (e->type == ENT_ITEM) {
        // Single tile rendering for items (8x8)
        uint8_t sprite_id = sprite_offset + (i * 4);
        uint16_t ty = esy + 4;
        if (!use_clipping || ty < 140) {
          move_sprite(sprite_id, esx + 4, ty);
          set_sprite_tile(sprite_id, e->sprite_base + e->anim_frame);
        } else {
          move_sprite(sprite_id, 0, 0);
        }

        // Hide unused sprites
        for (int j = 1; j < 4; j++)
          move_sprite(sprite_offset + (i * 4) + j, 0, 0);
      } else {
        uint8_t frame_offset = (e->anim_frame * 4);
        for (int j = 0; j < 4; j++) {
          uint8_t sprite_id = sprite_offset + (i * 4) + j;
          uint16_t ty = esy + (j >= 2 ? 8 : 0);
          if (!use_clipping || ty < 140) {
            move_sprite(sprite_id, esx + (j % 2 ? 8 : 0), ty);
            set_sprite_tile(sprite_id, e->sprite_base + frame_offset + j);
          } else {
            move_sprite(sprite_id, 0, 0);
          }
        }
      }
    }
  }
}
