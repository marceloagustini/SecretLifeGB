#ifndef ENTITY_H
#define ENTITY_H

#include <gb/gb.h>
#include <stdint.h>

typedef enum { ENT_NPC, ENT_ITEM, ENT_DOOR, ENT_ENEMY } ent_type_t;

struct entity_t;

typedef void (*entity_update_fn)(struct entity_t *self);

typedef struct entity_t {
  uint16_t x, y;
  ent_type_t type;
  const char *dialogue;
  uint8_t sprite_base;
  uint8_t active;
  int8_t dir; // 0:D, 1:U, 2:L, 3:R (following player convention)
  uint8_t anim_frame;
  uint8_t anim_timer;
  uint8_t move_timer;
  entity_update_fn update;
} entity_t;

void entity_init(entity_t *e, ent_type_t type, uint16_t x, uint16_t y,
                 uint8_t sprite_base, const char *dialogue);
void entity_update_all(entity_t *entities, uint8_t count);
void entity_render_all(entity_t *entities, uint8_t count, uint16_t camera_x,
                       uint16_t camera_y, uint8_t sprite_offset);

// AI Behaviors
void ai_npc_static(entity_t *self);
void ai_enemy_random_walk(entity_t *self);

#endif
