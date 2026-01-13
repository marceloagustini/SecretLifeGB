#include "entity.h"
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
  } else {
    e->update = ai_npc_static;
  }
}

void ai_npc_static(entity_t *self) {
  // NPCs generally don't move automatically in this simple implementation
  // But we could add idle animations here
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

void entity_update_all(entity_t *entities, uint8_t count) {
  for (uint8_t i = 0; i < count; i++) {
    if (entities[i].active && entities[i].update) {
      entities[i].update(&entities[i]);
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
    if (esx < 168 && esy < 160) {
      uint8_t frame_offset = (e->anim_frame * 4);
      for (int j = 0; j < 4; j++) {
        uint8_t sprite_id = sprite_offset + (i * 4) + j;
        move_sprite(sprite_id, esx + (j % 2 ? 8 : 0), esy + (j >= 2 ? 8 : 0));
        set_sprite_tile(sprite_id, e->sprite_base + frame_offset + j);
      }
    } else {
      for (int j = 0; j < 4; j++)
        move_sprite(sprite_offset + (i * 4) + j, 0, 0);
    }
  }
}
