#include "../../res/assets.h"
#include "../utils/input.h"
#include "../utils/music.h"
#include "../utils/text.h"
#include "states.h"
#include <gb/gb.h>

// Locations
typedef enum { LOC_WORLD, LOC_HOUSE } location_t;
location_t current_loc = LOC_WORLD;

// Player state
uint16_t player_x = 152;
uint16_t player_y = 120;
uint16_t world_saved_x = 152;
uint16_t world_saved_y = 120;

// Animation state
uint8_t player_dir = 0; // 0: Down, 1: Up, 2: Left, 3: Right
uint8_t anim_frame = 0;
uint8_t anim_timer = 0;

// Camera state
uint16_t camera_x = 0;
uint16_t camera_y = 0;

// Environment animation state
uint8_t env_anim_timer = 0;
uint8_t env_anim_frame = 0;

#define SCREEN_WIDTH 160
#define SCREEN_HEIGHT 144

uint8_t get_tile_at(uint16_t x, uint16_t y) {
  uint16_t tx = x / 8;
  uint16_t ty = y / 8;
  if (current_loc == LOC_WORLD) {
    if (tx >= MAP_WIDTH || ty >= MAP_HEIGHT)
      return 1;
    return map_data[ty * MAP_WIDTH + tx];
  } else {
    if (tx >= HOUSE_WIDTH || ty >= HOUSE_HEIGHT)
      return 1;
    return house_map[ty * HOUSE_WIDTH + tx];
  }
}

void update_camera() {
  uint16_t w = (current_loc == LOC_WORLD) ? (MAP_WIDTH * 8) : (HOUSE_WIDTH * 8);
  uint16_t h =
      (current_loc == LOC_WORLD) ? (MAP_HEIGHT * 8) : (HOUSE_HEIGHT * 8);

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

void load_location(location_t loc) {
  HIDE_BKG;
  current_loc = loc;
  if (loc == LOC_WORLD) {
    set_bkg_tiles(0, 0, MAP_WIDTH, MAP_HEIGHT, map_data);
  } else {
    fill_bkg_rect(0, 0, 32, 32, 26);
    set_bkg_tiles(0, 0, HOUSE_WIDTH, HOUSE_HEIGHT, house_map);
  }
  update_camera();
  SHOW_BKG;
}

void update_player_sprite() {
  uint8_t base_tile = 0;
  uint8_t prop = 0;
  switch (player_dir) {
  case 0:
    base_tile = 0 + (anim_frame * 4);
    break;
  case 1:
    base_tile = 8 + (anim_frame * 4);
    break;
  case 2:
    base_tile = 16 + (anim_frame * 4);
    break;
  case 3:
    base_tile = 16 + (anim_frame * 4);
    prop = S_FLIPX;
    break;
  }
  if (prop == 0) {
    set_sprite_tile(0, base_tile);
    set_sprite_tile(1, base_tile + 1);
    set_sprite_tile(2, base_tile + 2);
    set_sprite_tile(3, base_tile + 3);
    for (int i = 0; i < 4; i++)
      set_sprite_prop(i, 0);
  } else {
    set_sprite_tile(0, base_tile + 1);
    set_sprite_tile(1, base_tile);
    set_sprite_tile(2, base_tile + 3);
    set_sprite_tile(3, base_tile + 2);
    for (int i = 0; i < 4; i++)
      set_sprite_prop(i, S_FLIPX);
  }
}

uint8_t is_solid(uint16_t x, uint16_t y) {
  uint8_t tid = get_tile_at(x, y);
  if (current_loc == LOC_WORLD) {
    if (tid == 0 || tid == 2 || tid == 3 || tid == 4 || tid == 5 || tid == 21 ||
        tid == 22)
      return 0;
  } else {
    if (tid == 25 || tid == 35)
      return 0;
  }
  return 1;
}

uint8_t can_move(uint16_t nx, uint16_t ny) {
  uint16_t w = (current_loc == LOC_WORLD) ? (MAP_WIDTH * 8) : (HOUSE_WIDTH * 8);
  uint16_t h =
      (current_loc == LOC_WORLD) ? (MAP_HEIGHT * 8) : (HOUSE_HEIGHT * 8);
  if (nx < 4 || nx > w - 20 || ny < 8 || ny > h - 20)
    return 0;
  if (is_solid(nx + 4, ny + 8) || is_solid(nx + 11, ny + 8) ||
      is_solid(nx + 4, ny + 15) || is_solid(nx + 11, ny + 15))
    return 0;
  return 1;
}

void game_init(void) {
  DISPLAY_OFF;
  set_bkg_data(0, 36, tiles_data);
  load_location(LOC_WORLD);
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
}

void game_update(void) {
  music_update();
  uint8_t moved = 0;
  uint16_t nx = player_x;
  uint16_t ny = player_y;

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
      uint16_t sx = player_x - camera_x + 8;
      uint16_t sy = player_y - camera_y + 16;
      move_sprite(0, sx, sy);
      move_sprite(1, sx + 8, sy);
      move_sprite(2, sx, sy + 8);
      move_sprite(3, sx + 8, sy + 8);

      // Transitions
      if (current_loc == LOC_WORLD) {
        // Check top center of sprite for door
        uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
        if (tid == 21 || tid == 22) {
          world_saved_x = player_x;
          world_saved_y = player_y + 16; // Return position (safe distance)
          player_x = 80;
          player_y = 120;
          load_location(LOC_HOUSE);
          return;
        }
      } else {
        // Check bottom center for exit mat
        uint8_t tid = get_tile_at(player_x + 8, player_y + 16);
        if (tid == 35) {
          player_x = world_saved_x;
          player_y = world_saved_y;
          player_dir = 0; // Face Down when exiting
          load_location(LOC_WORLD);
          return;
        }
      }

      anim_timer++;
      if (anim_timer > 6) {
        anim_frame = !anim_frame;
        anim_timer = 0;
        update_player_sprite();
      }
    } else if (anim_frame != 0) {
      anim_frame = 0;
      update_player_sprite();
    }
  } else {
    if (anim_frame != 0) {
      anim_frame = 0;
      update_player_sprite();
    }
    anim_timer = 0;
  }

  // NPC Logic
  uint16_t npc_x, npc_y;
  const char *dial;
  if (current_loc == LOC_WORLD) {
    npc_x = 120;
    npc_y = 72;
    dial =
        "HOLA AMIGO,\nTIENES QUE CONSEGUIR\nLA LLAVE EN ALGUN\nLADO DEBE ESTAR";
  } else {
    npc_x = 40;
    npc_y = 48;
    dial = "BIENVENIDO A MI CASA.\nEL ROPERO ESTA TRABADO,\nPERO PUEDES "
           "DESCANSAR\nEN LA CAMA.";
  }

  uint16_t nsx = npc_x - camera_x + 8;
  uint16_t nsy = npc_y - camera_y + 16;
  if (nsx < 168 && nsy < 160) {
    move_sprite(4, nsx, nsy);
    move_sprite(5, nsx + 8, nsy);
    move_sprite(6, nsx, nsy + 8);
    move_sprite(7, nsx + 8, nsy + 8);
    for (int i = 0; i < 4; i++)
      set_sprite_tile(4 + i, 24 + i);
  } else {
    for (int i = 0; i < 4; i++)
      move_sprite(4 + i, 0, 0);
  }

  if (input_pressed(J_A)) {
    int16_t dx = (int16_t)player_x - npc_x;
    int16_t dy = (int16_t)player_y - npc_y;
    if (dx < 0)
      dx = -dx;
    if (dy < 0)
      dy = -dy;
    if (dx < 24 && dy < 24)
      text_dialogue(dial);
  }

  // --- ENVIRONMENT ANIMATION ---
  if (current_loc == LOC_WORLD) {
    env_anim_timer++;
    if (env_anim_timer >= 40) {
      env_anim_timer = 0;
      env_anim_frame = !env_anim_frame;
      if (env_anim_frame) {
        set_bkg_data(2, 1, &tiles_anim_data[0]);   // Grass
        set_bkg_data(4, 1, &tiles_anim_data[16]);  // Tree TL
        set_bkg_data(5, 1, &tiles_anim_data[32]);  // Tree TR
        set_bkg_data(6, 1, &tiles_anim_data[48]);  // Tree BL
        set_bkg_data(12, 1, &tiles_anim_data[64]); // Tree BR
      } else {
        set_bkg_data(2, 1, &tiles_data[32]);   // Grass
        set_bkg_data(4, 1, &tiles_data[64]);   // Tree TL
        set_bkg_data(5, 1, &tiles_data[80]);   // Tree TR
        set_bkg_data(6, 1, &tiles_data[96]);   // Tree BL
        set_bkg_data(12, 1, &tiles_data[192]); // Tree BR
      }
    }
  }
}
