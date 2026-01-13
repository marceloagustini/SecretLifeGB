#include "../../res/assets.h"
#include "../utils/fade.h"
#include "../utils/input.h"
#include "../utils/inventory.h"
#include "../utils/music.h"
#include "../utils/text.h"
#include "states.h"
#include <gb/gb.h>
#include <string.h>

// --- STRUCTURES & TYPES ---

typedef enum { ENT_NPC, ENT_ITEM, ENT_DOOR } ent_type_t;

typedef struct {
  uint16_t x, y;
  ent_type_t type;
  const char *dialogue;
  uint8_t sprite_base;
  uint8_t active;
} entity_t;

typedef struct {
  const unsigned char *tiles;
  uint8_t w, h;
  entity_t *entities;
  uint8_t num_entities;
  uint8_t solid_tiles[16];
} map_info_t;

// --- GLOBALS ---

#define MAX_ENTITIES 4
entity_t world_ents[1];
entity_t house_ents[1];
entity_t level2_ents[1];

map_info_t world_map_info, house_map_info, level2_map_info;
map_info_t *current_map;

extern uint8_t game_state;

// Player state
uint16_t player_x = 128, player_y = 128;
uint16_t saved_world_x, saved_world_y;
uint8_t player_dir = 0; // 0:D, 1:U, 2:L, 3:R
uint8_t anim_frame = 0, anim_timer = 0;
uint16_t camera_x = 0, camera_y = 0;

// Quest state
// Quest state (removed has_key global, now in inventory)

// Env animation
uint8_t env_anim_timer = 0, env_anim_frame = 0;

#define SCREEN_WIDTH 160
#define SCREEN_HEIGHT 144

// --- HELPERS ---

uint8_t get_tile_at(uint16_t x, uint16_t y) {
  uint16_t tx = x / 8, ty = y / 8;
  if (tx >= current_map->w || ty >= current_map->h)
    return 1;
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

void load_map(map_info_t *m) {
  fade_out();
  HIDE_BKG;
  current_map = m;
  for (int i = 4; i < 40; i++)
    move_sprite(i, 0, 0); // Hide map sprites

  if (m == &house_map_info)
    fill_bkg_rect(0, 0, 32, 32, 26);
  set_bkg_tiles(0, 0, m->w, m->h, m->tiles);
  update_camera();

  // Sync player sprites immediately
  uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
  for (int i = 0; i < 4; i++)
    move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));

  SHOW_BKG;
  fade_in();
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

uint8_t is_solid(uint16_t x, uint16_t y) {
  uint8_t tid = get_tile_at(x, y);
  for (int i = 0; i < 16; i++) {
    if (current_map->solid_tiles[i] == 255)
      break;
    if (tid == current_map->solid_tiles[i])
      return 0;
  }
  return 1;
}

uint8_t can_move(uint16_t nx, uint16_t ny) {
  uint16_t w = current_map->w * 8, h = current_map->h * 8;
  if (nx < 4 || nx > w - 20 || ny < 8 || ny > h - 20)
    return 0;
  if (is_solid(nx + 4, ny + 8) || is_solid(nx + 11, ny + 8) ||
      is_solid(nx + 4, ny + 15) || is_solid(nx + 11, ny + 15))
    return 0;

  // NPC Collisions
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
  set_bkg_data(0, 77, tiles_data); // All tiles (now 77)

  if (game_ready) {
    // Coming back from Inventory - Don't reset state
    load_map(current_map);
    update_camera();
    uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
    for (int i = 0; i < 4; i++)
      move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));
    update_player_sprite();

    BGP_REG = OBP0_REG = OBP1_REG = 0xE4;
    SHOW_SPRITES;
    DISPLAY_ON;
    return;
  }

  // Define Maps
  world_map_info.tiles = map_data;
  world_map_info.w = MAP_WIDTH;
  world_map_info.h = MAP_HEIGHT;
  world_map_info.entities = world_ents;
  world_map_info.num_entities = 1;
  uint8_t w_pass[] = {0, 2, 3, 4, 5, 21, 22, 58, 59, 70, 71, 255};
  memcpy(world_map_info.solid_tiles, w_pass, 12);
  world_ents[0].x = 210;
  world_ents[0].y = 230;
  world_ents[0].type = ENT_NPC;
  world_ents[0].dialogue =
      "MI CASA ES LA DE\nAQUI ARRIBA.\nBUSCA LA LLAVE EN\nMI ROPERO.";
  world_ents[0].sprite_base = 24;
  world_ents[0].active = 1;

  house_map_info.tiles = house_map;
  house_map_info.w = HOUSE_WIDTH;
  house_map_info.h = HOUSE_HEIGHT;
  house_map_info.entities = house_ents;
  house_map_info.num_entities = 1;
  uint8_t h_pass[] = {25, 35, 255};
  memcpy(house_map_info.solid_tiles, h_pass, 3);
  house_ents[0].x = 40;
  house_ents[0].y = 48;
  house_ents[0].type = ENT_NPC;
  house_ents[0].dialogue = "PUEDES DESCANSAR,\nPERO NO TOQUES\nMIS COSAS!";
  house_ents[0].sprite_base = 24;
  house_ents[0].active = 1;

  level2_map_info.tiles = level2_map;
  level2_map_info.w = L2_WIDTH;
  level2_map_info.h = L2_HEIGHT;
  level2_map_info.entities = level2_ents;
  level2_map_info.num_entities = 0;
  uint8_t l2_pass[] = {0, 2, 3, 4, 255};
  memcpy(level2_map_info.solid_tiles, l2_pass, 5);

  current_map = &world_map_info;
  update_camera();
  uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
  for (int i = 0; i < 4; i++)
    move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));

  load_map(&world_map_info);

  BGP_REG = OBP0_REG = OBP1_REG = 0xE4;
  SPRITES_8x8;
  set_sprite_data(0, 24, player_sprites);
  set_sprite_data(24, 4, npc_child_sprite);
  update_player_sprite();
  text_init();
  music_init();
  SHOW_BKG;
  SHOW_SPRITES;
  DISPLAY_ON;
  game_ready = 1;
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
      uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
      for (int i = 0; i < 4; i++)
        move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));

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
    if (current_map == &world_map_info &&
        (tid == 21 || tid == 22 || tid == 58 || tid == 59 || tid == 70 ||
         tid == 71)) {
      if (player_x > 160 && player_y > 160) {
        saved_world_x = player_x;
        saved_world_y = player_y + 16;
        player_x = 76;
        player_y = 112; // Farther from mat (avoid loop)
        load_map(&house_map_info);
        fade_in();
        return;
      }
    }
    tid = get_tile_at(player_x + 8, player_y + 16);
    if (current_map == &house_map_info && tid == 35) {
      player_x = saved_world_x;
      player_y = saved_world_y;
      player_dir = 0;
      load_map(&world_map_info);
      return;
    }
    if (current_map == &level2_map_info && tid == 0 && player_y > 230) {
      player_x = 124;
      player_y = 32;
      player_dir = 0;
      load_map(&world_map_info);
      return;
    }
  }

  // Render entities
  for (int i = 0; i < current_map->num_entities; i++) {
    entity_t *e = &current_map->entities[i];
    uint16_t esx = e->x - camera_x + 8, esy = e->y - camera_y + 16;
    if (esx < 168 && esy < 160) {
      for (int j = 0; j < 4; j++) {
        move_sprite(4 + j, esx + (j % 2 ? 8 : 0), esy + (j >= 2 ? 8 : 0));
        set_sprite_tile(4 + j, e->sprite_base + j);
      }
    } else {
      for (int j = 0; j < 4; j++)
        move_sprite(4 + j, 0, 0);
    }
  }

  if (input_pressed(J_A | J_B)) {
    for (int i = 0; i < current_map->num_entities; i++) {
      entity_t *e = &current_map->entities[i];
      int16_t dx = (int16_t)player_x - e->x, dy = (int16_t)player_y - e->y;
      if (dx < 0)
        dx = -dx;
      if (dy < 0)
        dy = -dy;
      if (dx < 24 && dy < 24 && input_pressed(J_A))
        text_dialogue(e->dialogue);
    }

    uint8_t tid = get_tile_at(player_x + 8, player_y);
    if (player_dir == 1)
      tid = get_tile_at(player_x + 8, player_y - 4);

    if (current_map == &house_map_info &&
        (tid == 31 || tid == 32 || tid == 33 || tid == 34)) {
      if (input_pressed(J_B)) {
        if (!inventory_has_item("LLAVE")) {
          text_dialogue("¡HAS ENCONTRADO LA\nLLAVE DEL PORTON!");
          inventory_add_item("LLAVE", "ABRE EL PORTON NORTE", 41);
        } else
          text_dialogue("EL ROPERO ESTA\nVACIO.");
      }
    }

    if (current_map == &world_map_info && (tid == 43 || tid == 44)) {
      if (inventory_has_item("LLAVE")) {
        text_dialogue("USAS LA LLAVE...\n¡EL PORTON SE ABRE!");
        player_x = 124;
        player_y = 230;
        player_dir = 1;
        load_map(&level2_map_info);
        return;
      } else {
        text_dialogue("ESTA CERRADO.\nNECESITAS UNA LLAVE.");
      }
    }
  }

  if (current_map == &world_map_info) {
    if (++env_anim_timer >= 40) {
      env_anim_timer = 0;
      env_anim_frame = !env_anim_frame;
      if (env_anim_frame) {
        set_bkg_data(2, 1, &tiles_anim_data[0]);
        set_bkg_data(4, 1, &tiles_anim_data[16]);
        set_bkg_data(5, 1, &tiles_anim_data[32]);
        set_bkg_data(6, 1, &tiles_anim_data[48]);
        set_bkg_data(12, 1, &tiles_anim_data[64]);
      } else {
        set_bkg_data(2, 1, &tiles_data[32]);
        set_bkg_data(4, 1, &tiles_data[64]);
        set_bkg_data(5, 1, &tiles_data[80]);
        set_bkg_data(6, 1, &tiles_data[96]);
        set_bkg_data(12, 1, &tiles_data[192]);
      }
    }
  }
}
