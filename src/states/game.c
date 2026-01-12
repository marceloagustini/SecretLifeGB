#include "../../res/assets.h"
#include "../utils/input.h"
#include "../utils/text.h"
#include "states.h"
#include <gb/gb.h>

// Player state
uint16_t player_x = 80;
uint16_t player_y = 72;

// Animation state
uint8_t player_dir = 0; // 0: Down, 1: Up, 2: Left, 3: Right
uint8_t anim_frame = 0;
uint8_t anim_timer = 0;

// Camera state
uint16_t camera_x = 0;
uint16_t camera_y = 0;

// Screen dimensions
#define SCREEN_WIDTH 160
#define SCREEN_HEIGHT 144
// Map dimensions in pixels
#define WORLD_WIDTH (MAP_WIDTH * 8)
#define WORLD_HEIGHT (MAP_HEIGHT * 8)

void update_camera() {
  // Center camera on player
  if (player_x > SCREEN_WIDTH / 2) {
    camera_x = player_x - SCREEN_WIDTH / 2;
  } else {
    camera_x = 0;
  }

  if (player_y > SCREEN_HEIGHT / 2) {
    camera_y = player_y - SCREEN_HEIGHT / 2;
  } else {
    camera_y = 0;
  }

  // Clamp to map bounds
  if (camera_x > WORLD_WIDTH - SCREEN_WIDTH) {
    camera_x = WORLD_WIDTH - SCREEN_WIDTH;
  }
  if (camera_y > WORLD_HEIGHT - SCREEN_HEIGHT) {
    camera_y = WORLD_HEIGHT - SCREEN_HEIGHT;
  }

  move_bkg(camera_x, camera_y);
}

void update_player_sprite() {
  uint8_t base_tile = 0;
  uint8_t prop = 0; // 0 or S_FLIPX

  switch (player_dir) {
  case 0: // Down
    base_tile = 0 + (anim_frame * 4);
    break;
  case 1: // Up
    base_tile = 8 + (anim_frame * 4);
    break;
  case 2: // Left
    base_tile = 16 + (anim_frame * 4);
    break;
  case 3: // Right
    base_tile = 16 + (anim_frame * 4);
    prop = S_FLIPX;
    break;
  }

  if (prop == 0) {
    set_sprite_tile(0, base_tile);     // TL
    set_sprite_tile(1, base_tile + 1); // TR
    set_sprite_tile(2, base_tile + 2); // BL
    set_sprite_tile(3, base_tile + 3); // BR

    set_sprite_prop(0, 0);
    set_sprite_prop(1, 0);
    set_sprite_prop(2, 0);
    set_sprite_prop(3, 0);
  } else {
    // Flipped (Right)
    set_sprite_tile(0, base_tile + 1); // TR of Left -> TL of Right
    set_sprite_tile(1, base_tile);     // TL of Left -> TR of Right
    set_sprite_tile(2, base_tile + 3); // BR of Left -> BL of Right
    set_sprite_tile(3, base_tile + 2); // BL of Left -> BR of Right

    set_sprite_prop(0, S_FLIPX);
    set_sprite_prop(1, S_FLIPX);
    set_sprite_prop(2, S_FLIPX);
    set_sprite_prop(3, S_FLIPX);
  }
}

// Check if a pixel coordinate is valid to walk on
// The map is 8x8 tiles.
// We check the tile index at the given coordinate.
// Solid tiles are: 1 (Wall), 4/5 (Tree), 6 (Rock), 7-11 (House)
uint8_t is_solid(uint16_t x, uint16_t y) {
  uint16_t tile_x = x / 8;
  uint16_t tile_y = y / 8;

  if (tile_x >= MAP_WIDTH || tile_y >= MAP_HEIGHT)
    return 1;

  uint16_t tile_index = tile_y * MAP_WIDTH + tile_x;
  uint8_t tile_id = map_data[tile_index];

  // Passable: 0(Empty), 2(Grass), 3(Flower)
  // Also make Tree Top (4) passable for depth effect (walk behind)
  if (tile_id == 0 || tile_id == 2 || tile_id == 3 || tile_id == 4) {
    return 0;
  }
  return 1;
}

// Check collision for the player box (16x16)
uint8_t can_move(uint16_t new_x, uint16_t new_y) {
  // Check map boundaries
  if (new_x < 8)
    return 0;
  if (new_x > WORLD_WIDTH - 24)
    return 0;
  if (new_y < 16)
    return 0;
  if (new_y > WORLD_HEIGHT - 24)
    return 0;

  // Hitbox: Smaller than sprite to be forgiving
  // Top Left
  if (is_solid(new_x + 4, new_y + 8))
    return 0;
  // Top Right
  if (is_solid(new_x + 11, new_y + 8))
    return 0;
  // Bottom Left
  if (is_solid(new_x + 4, new_y + 15))
    return 0;
  // Bottom Right
  if (is_solid(new_x + 11, new_y + 15))
    return 0;

  return 1;
}

void game_init(void) {
  DISPLAY_OFF;

  // Load tiles
  set_bkg_data(0, 12, tiles_data);
  set_bkg_tiles(0, 0, MAP_WIDTH, MAP_HEIGHT, map_data);

  // Set Palettes
  BGP_REG = 0xE4;
  OBP0_REG = 0xE4;
  OBP1_REG = 0xE4;

  // Load sprites (24 tiles for player + 4 for NPC)
  SPRITES_8x8;
  set_sprite_data(0, 24, player_sprites);
  set_sprite_data(24, 4, npc_dog_sprite); // NPC dog at tiles 24-27

  // Initial sprite position
  // Initial sprite position (relative to screen)
  // We'll update this in the loop properly
  update_camera();
  move_sprite(0, player_x - camera_x + 8, player_y - camera_y + 16);
  move_sprite(1, player_x - camera_x + 16, player_y - camera_y + 16);
  move_sprite(2, player_x - camera_x + 8, player_y - camera_y + 24);
  move_sprite(3, player_x - camera_x + 16, player_y - camera_y + 24);

  // Initialize sprite graphics
  update_player_sprite();

  // Initialize text system (loads font tiles)
  text_init();

  SHOW_BKG;
  SHOW_SPRITES;
  DISPLAY_ON;
}

void game_update(void) {
  uint8_t moved = 0;
  uint16_t new_x = player_x;
  uint16_t new_y = player_y;

  if (input_held(J_UP)) {
    new_y--;
    player_dir = 1;
    moved = 1;
  } else if (input_held(J_DOWN)) {
    new_y++;
    player_dir = 0;
    moved = 1;
  } else if (input_held(J_LEFT)) {
    new_x--;
    player_dir = 2;
    moved = 1;
  } else if (input_held(J_RIGHT)) {
    new_x++;
    player_dir = 3;
    moved = 1;
  }

  if (moved) {
    // Collision check
    uint8_t can_walk = can_move(new_x, new_y);
    if (can_walk) {
      player_x = new_x;
      player_y = new_y;

      update_camera();

      // Calculate screen position relative to camera
      // +8, +16 offset for hardware sprite OAM coordinates
      uint16_t screen_x = player_x - camera_x + 8;
      uint16_t screen_y = player_y - camera_y + 16;

      move_sprite(0, screen_x, screen_y);
      move_sprite(1, screen_x + 8, screen_y);
      move_sprite(2, screen_x, screen_y + 8);
      move_sprite(3, screen_x + 8, screen_y + 8);
    }

    // Animation - only if we actually moved
    if (can_walk) {
      anim_timer++;
      if (anim_timer > 6) {
        anim_frame = !anim_frame;
        anim_timer = 0;
        update_player_sprite();
      }
    } else {
      // Blocked.
      if (anim_frame != 0) {
        anim_frame = 0;
        update_player_sprite();
      }
    }
  } else {
    // Reset to standing frame if stopped
    if (anim_frame != 0) {
      anim_frame = 0;
      update_player_sprite();
    }
    anim_timer = 0;
  }

  // Update direction even if not moving (so we face the right way)
  static uint8_t last_dir = 0;
  if (last_dir != player_dir) {
    update_player_sprite();
    last_dir = player_dir;
  }

  // NPC Logic (Static for now)
  // NPC Location: 120, 72 (World Coordinates)
  uint16_t npc_x = 120;
  uint16_t npc_y = 72;

  // Draw NPC relative to camera
  uint16_t npc_screen_x = npc_x - camera_x + 8;
  uint16_t npc_screen_y = npc_y - camera_y + 16;

  // Use sprites 4-7 for NPC
  if (npc_screen_x < 168 && npc_screen_y < 160) {
    move_sprite(4, npc_screen_x, npc_screen_y);
    move_sprite(5, npc_screen_x + 8, npc_screen_y);
    move_sprite(6, npc_screen_x, npc_screen_y + 8);
    move_sprite(7, npc_screen_x + 8, npc_screen_y + 8);

    // Set to use dog tiles
    set_sprite_tile(4, 24);
    set_sprite_tile(5, 25);
    set_sprite_tile(6, 26);
    set_sprite_tile(7, 27);
  } else {
    move_sprite(4, 0, 0); // Hide if offscreen
    move_sprite(5, 0, 0);
    move_sprite(6, 0, 0);
    move_sprite(7, 0, 0);
  }

  // Interaction
  if (input_pressed(J_A)) {
    // Simple distance check
    int16_t dx = (int16_t)player_x - npc_x;
    int16_t dy = (int16_t)player_y - npc_y;
    if (dx < 0)
      dx = -dx;
    if (dy < 0)
      dy = -dy;

    // If close (within 24 pixels)
    if (dx < 24 && dy < 24) {
      text_dialogue("HOLA AMIGO, QUE NECESITAS?");
    }
  }
}
