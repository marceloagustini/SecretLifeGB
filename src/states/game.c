#include "../../res/assets.h"
#include "../data/dialogues.h"
#include "../utils/entity.h"
#include "../utils/fade.h"
#include "../utils/input.h"
#include "../utils/inventory.h"
#include "../utils/map_manager.h"
#include "../utils/music.h"
#include "../utils/projectile.h"
#include "../utils/text.h"
#include "states.h"
#include <gb/gb.h>
#include <string.h>

// Externs from map_config.c
extern map_t maps[];
extern void map_init_data();

// --- GLOBALS ---
extern uint8_t game_state;

extern uint8_t game_state;

// Player state
uint16_t player_x = 128, player_y = 128;
uint16_t enter_x = 128, enter_y = 128; // Spawn point for current map
uint16_t saved_world_x, saved_world_y;
uint8_t player_dir = 0; // 0:D, 1:U, 2:L, 3:R
uint8_t anim_frame = 0, anim_timer = 0;
uint16_t camera_x = 0, camera_y = 0;

// Env animation
uint8_t env_anim_timer = 0, env_anim_frame = 0;

#define SCREEN_WIDTH 160
#define SCREEN_HEIGHT 144

// --- HELPERS ---

uint8_t get_tile_at(uint16_t x, uint16_t y) {
  uint16_t tx = x / 8, ty = y / 8;
  if (tx >= current_map->w || ty >= current_map->h)
    return 0;
  return current_map->tiles[ty * current_map->w + tx];
}

void update_camera() {
  uint16_t w = current_map->w * 8, h = current_map->h * 8;
  if (player_x > SCREEN_WIDTH / 2)
    camera_x = player_x - SCREEN_WIDTH / 2;
  else
    camera_x = 0;
  if (player_y > SCREEN_HEIGHT / 2)
    camera_y = player_y - SCREEN_HEIGHT / 2;
  else
    camera_y = 0;
  if (camera_x > w - SCREEN_WIDTH)
    camera_x = (w > SCREEN_WIDTH) ? (w - SCREEN_WIDTH) : 0;
  if (camera_y > h - SCREEN_HEIGHT)
    camera_y = (h > SCREEN_HEIGHT) ? (h - SCREEN_HEIGHT) : 0;
  move_bkg(camera_x, camera_y);
}

void update_player_sprite() {
  uint8_t base =
      (player_dir == 3 ? 16
                       : (player_dir == 2 ? 16 : (player_dir == 1 ? 8 : 0))) +
      (anim_frame * 4);
  uint8_t prop = (player_dir == 3) ? S_FLIPX : 0;
  if (prop == 0) {
    set_sprite_tile(0, base);
    set_sprite_tile(1, base + 1);
    set_sprite_tile(2, base + 2);
    set_sprite_tile(3, base + 3);
    for (int i = 0; i < 4; i++)
      set_sprite_prop(i, 0);
  } else {
    set_sprite_tile(0, base + 1);
    set_sprite_tile(1, base);
    set_sprite_tile(2, base + 3);
    set_sprite_tile(3, base + 2);
    for (int i = 0; i < 4; i++)
      set_sprite_prop(i, S_FLIPX);
  }
}

void load_map(map_t *m) {
  HIDE_BKG;
  current_map = m;
  for (int i = 4; i < 40; i++)
    move_sprite(i, 0, 0); // Hide map sprites

  if (m == &maps[1]) // HOUSE_MAP
    fill_bkg_rect(0, 0, 32, 32, 26);
  set_bkg_tiles(0, 0, m->w, m->h, m->tiles);
  update_camera();

  // Sync player sprites immediately
  uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
  for (int i = 0; i < 4; i++)
    move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));

  SHOW_BKG;
}

void switch_map(map_t *new_map, uint16_t new_x, uint16_t new_y) {
  fade_out();
  player_x = new_x;
  player_y = new_y;
  enter_x = new_x; // Remember map entrance
  enter_y = new_y;
  load_map(new_map);
  update_player_sprite();
  fade_in();
}

uint8_t is_solid(uint16_t x, uint16_t y) { return map_is_solid(x, y); }

uint8_t can_move(uint16_t nx, uint16_t ny) {
  if (nx < 4 || ny < 4 || nx > (current_map->w * 8 - 12) ||
      ny > (current_map->h * 8 - 12))
    return 0;

  if (is_solid(nx + 4, ny + 8) || is_solid(nx + 12, ny + 8) ||
      is_solid(nx + 4, ny + 15) || is_solid(nx + 12, ny + 15)) {
    return 0;
  }

  for (int i = 0; i < current_map->num_entities; i++) {
    entity_t *e = &current_map->entities[i];
    if (!e->active)
      continue;
    int16_t dx = (int16_t)nx - e->x, dy = (int16_t)ny - e->y;
    if (dx < 0)
      dx = -dx;
    if (dy < 0)
      dy = -dy;
    if (dx < 12 && dy < 12)
      return 0; // Collide if too close
  }
  return 1;
}

// --- STATE LOGIC ---

static uint8_t game_ready = 0;

void game_init(void) {
  DISPLAY_OFF;
  set_bkg_data(0, 40, tiles_data); // All tiles (now 40)

  if (game_ready) {
    player_x = 128;
    player_y = 128;
    enter_x = 128;
    enter_y = 128;
    map_init_data();
    load_map(current_map);
    update_player_sprite();
    BGP_REG = OBP0_REG = OBP1_REG = 0xE4;
    SHOW_SPRITES;
    DISPLAY_ON;
    return;
  }

  map_init_data();
  load_map(&maps[0]); // WORLD_MAP

  BGP_REG = OBP0_REG = OBP1_REG = 0xE4;
  SPRITES_8x8;
  set_sprite_data(0, 24, player_sprites);
  set_sprite_data(24, 4, npc_child_sprite);
  set_sprite_data(28, 8, guard_sprite_data);
  set_sprite_data(36, 4, npc_woman_sprite);
  set_sprite_data(40, 1, projectile_sprite);
  set_sprite_data(41, 2, flower_sprite);
  update_player_sprite();
  text_init();
  music_init();
  projectile_init();
  enter_x = player_x;
  enter_y = player_y;
  SHOW_BKG;
  SHOW_SPRITES;
  DISPLAY_ON;
  game_ready = 1;
}

void player_hit() {
  fade_out();
  delay(1000);

  // Reset world data
  map_init_data();
  projectile_init();

  // Reset player position
  player_x = enter_x;
  player_y = enter_y;

  // Reload current map
  load_map(current_map);
  update_player_sprite();

  fade_in();
}

void game_update(void) {
  music_update();
  uint8_t moved = 0;
  uint16_t nx = player_x, ny = player_y;

  if (input_held(J_UP)) {
    ny--;
    player_dir = 1;
    moved = 1;
  } else if (input_held(J_DOWN)) {
    ny++;
    player_dir = 0;
    moved = 1;
  } else if (input_held(J_LEFT)) {
    nx--;
    player_dir = 2;
    moved = 1;
  } else if (input_held(J_RIGHT)) {
    nx++;
    player_dir = 3;
    moved = 1;
  }

  if (moved) {
    if (can_move(nx, ny)) {
      player_x = nx;
      player_y = ny;
      update_camera();

      if (++anim_timer > 6) {
        anim_frame = !anim_frame;
        anim_timer = 0;
        update_player_sprite();
      }
    }
  } else {
    if (anim_frame != 0) {
      anim_frame = 0;
      update_player_sprite();
    }
    anim_timer = 0;

    // Inventory trigger
    if (input_pressed(J_SELECT)) {
      game_state = 3; // STATE_INVENTORY
      return;
    }

    // Automatic Transitions
    uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
    if (current_map == &maps[0] && // WORLD_MAP
        (tid == 21 || tid == 22)) {
      if (player_x > 160 && player_y > 160) {
        saved_world_x = player_x;
        saved_world_y = player_y + 16;
        switch_map(&maps[1], 76, 112); // HOUSE_MAP
        return;
      }
    }
    tid = get_tile_at(player_x + 8, player_y + 12);
    if (current_map == &maps[1] && tid == 35) { // HOUSE_MAP
      uint16_t wx = saved_world_x;
      uint16_t wy = saved_world_y;
      switch_map(&maps[0], wx, wy); // WORLD_MAP
      return;
    }
    if (current_map == &maps[2] && tid == 0 && player_y > 240) { // LEVEL2_MAP
      switch_map(&maps[0], 124, 48);                             // WORLD_MAP
      return;
    }
  }

  // Ensure player sprites are positioned correctly (restores visibility after
  // dialogue)
  uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
  for (int i = 0; i < 4; i++)
    move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));

  // Render entities & AI
  entity_update_all(current_map->entities, current_map->num_entities);

  // Level 2 enemy shooter AI - Now handled by entity_update_all
  // if (current_map == &maps[2]) { // LEVEL2_MAP
  //   for (int i = 0; i < current_map->num_entities; i++) {
  //     entity_t *e = &current_map->entities[i];
  //     if (e->active && e->type == ENT_ENEMY) {
  //       ai_enemy_shooter(e, player_x, player_y);
  //     }
  //   }
  // }

  // Update and render projectiles
  projectile_update_all();
  projectile_render_all(camera_x, camera_y);

  // Check projectile collision with player
  if (projectile_check_collision(player_x + 8, player_y + 8)) {
    player_hit();
    return;
  }

  // Collision with enemy check (simplified for now, could be in entity_update)
  for (int i = 0; i < current_map->num_entities; i++) {
    entity_t *e = &current_map->entities[i];
    if (e->active && e->type == ENT_ENEMY) {
      int16_t dx = (int16_t)player_x - (int16_t)e->x;
      int16_t dy = (int16_t)player_y - (int16_t)e->y;
      if (dx < 0)
        dx = -dx;
      if (dy < 0)
        dy = -dy;
      if (dx < 10 && dy < 10) {
        player_hit();
        return;
      }
    }
  }

  entity_render_all(current_map->entities, current_map->num_entities, camera_x,
                    camera_y, 4);

  if (input_pressed(J_A | J_B)) {
    for (int i = 0; i < current_map->num_entities; i++) {
      entity_t *e = &current_map->entities[i];
      int16_t dx = (int16_t)player_x - (int16_t)e->x,
              dy = (int16_t)player_y - (int16_t)e->y;
      if (dx < 0)
        dx = -dx;
      if (dy < 0)
        dy = -dy;
      if (dx < 24 && dy < 24) {
        if (input_pressed(J_A)) {
          if (e->type == ENT_NPC) {
            // Check for Woman NPC (Sprite 36) and Flower
            if (e->sprite_base == 36 && inventory_has_item("FLOR")) {
              text_dialogue(DIALOGUE_FLOWER_THANKS);
            } else {
              text_dialogue(e->dialogue);
            }
          } else if (e->type == ENT_ITEM) {
            // Basic interaction if wanted, but pickup is on B usually
          }
        }
        if (input_pressed(J_B)) {
          if (e->type == ENT_ITEM && e->active) {
            // Assuming it's the flower based on sprite 41 or just generic item
            // pickup
            if (e->sprite_base == 41) {
              inventory_add_item("FLOR", "UNA HERMOSA\nFLOR SILVESTRE", 41);
              sfx_pickup();
              e->active = 0; // Remove from map
                             // Optional: text_dialogue("Recogiste una flor!");
            }
          }
        }
      }
    }

    uint8_t tid = get_tile_at(player_x + 8, player_y);
    if (player_dir == 1)
      tid = get_tile_at(player_x + 8, player_y - 4);

    if (current_map == &maps[1] && // HOUSE_MAP
        (tid == 31 || tid == 32 || tid == 33 || tid == 34)) {
      if (input_pressed(J_B)) {
        if (!inventory_has_item("LLAVE")) {
          text_dialogue(DIALOGUE_FOUND_KEY);
          inventory_add_item("LLAVE", "ABRE EL PORTON NORTE", 41);
          sfx_pickup();
        } else
          text_dialogue(DIALOGUE_EMPTY_CHEST);
      }
    }

    if (current_map == &maps[0] && (tid == 38 || tid == 39)) { // WORLD_MAP
      if (inventory_has_item("LLAVE")) {
        text_dialogue(DIALOGUE_USE_KEY);
        sfx_success();
        switch_map(&maps[2], 128, 224); // LEVEL2_MAP
        return;
      } else {
        text_dialogue(DIALOGUE_LOCKED_GATE);
      }
    }
  }

  if ((env_anim_timer % 32) == 0) {
    env_anim_frame = !env_anim_frame;
    // Walk through Tile 2 (Grass) Animation:
    // Frame 0: Original Grass (tiles_data[32] - offset for Tile 2)
    // Frame 1: Animated Grass (tiles_anim_data[0])
    set_bkg_data(2, 1, env_anim_frame ? &tiles_anim_data[0] : &tiles_data[32]);
  }
  env_anim_timer++;
}
