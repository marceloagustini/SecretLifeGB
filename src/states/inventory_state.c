#include "../../res/assets.h"
#include "../utils/input.h"
#include "../utils/inventory.h"
#include "states.h"
#include <gb/gb.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

extern uint8_t game_state;
#define STATE_GAME 2

static uint8_t selection = 0;

static void draw_text(uint8_t x, uint8_t y, const char *txt) {
  for (int i = 0; txt[i] != '\0'; i++) {
    uint8_t tile = 128; // Space
    if (txt[i] >= 'A' && txt[i] <= 'Z')
      tile = 128 + 1 + (txt[i] - 'A');
    set_bkg_tile_xy(x + i, y, tile);
  }
}

void inventory_draw(void) {
  // Background clear with space
  fill_bkg_rect(0, 0, 20, 18, 128);

  // Title
  draw_text(4, 1, "INVENTARIO");

  // Draw horizontal line
  for (int i = 1; i < 19; i++)
    set_bkg_tile_xy(
        i, 2, 128 + 30); // Use a line char if available or just space for now

  if (inventory_count == 0) {
    draw_text(4, 8, "VACIO");
  } else {
    for (uint8_t i = 0; i < inventory_count; i++) {
      draw_text(4, 4 + (i * 1), inventory[i].name);
    }

    // Cursor
    set_bkg_tile_xy(2, 4 + selection, 128 + 32); // Arrow/Cursor

    // Item Description at the bottom
    draw_text(1, 14, "--------------------");
    draw_text(1, 15, inventory[selection].description);
  }

  draw_text(2, 17, "(B) VOLVER");
}

void inventory_state_init(void) {
  DISPLAY_OFF;
  BGP_REG = 0xE4;
  move_bkg(0, 0);

  // Load font data
  set_bkg_data(128, 35, font_data);

  selection = 0;
  inventory_draw();

  SHOW_BKG;
  DISPLAY_ON;
}

void inventory_state_update(void) {
  if (inventory_count > 0) {
    if (input_pressed(J_DOWN)) {
      if (selection < inventory_count - 1) {
        selection++;
        inventory_draw();
      }
    }
    if (input_pressed(J_UP)) {
      if (selection > 0) {
        selection--;
        inventory_draw();
      }
    }
  }

  if (input_pressed(J_B)) {
    game_state = STATE_GAME;
  }
}
