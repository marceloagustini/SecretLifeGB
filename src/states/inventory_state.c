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

#include "../utils/text.h"

static void draw_box(uint8_t x, uint8_t y, uint8_t w, uint8_t h) {
  // Box Tiles (1-6 in get_tile_for_char mapping)
  uint8_t tl = get_tile_for_char(1);
  uint8_t h_line = get_tile_for_char(2);
  uint8_t tr = get_tile_for_char(3);
  uint8_t v_line = get_tile_for_char(4);
  uint8_t bl = get_tile_for_char(5);
  uint8_t br = get_tile_for_char(6);

  set_bkg_tile_xy(x, y, tl);                 // ┌
  set_bkg_tile_xy(x + w - 1, y, tr);         // ┐
  set_bkg_tile_xy(x, y + h - 1, bl);         // └
  set_bkg_tile_xy(x + w - 1, y + h - 1, br); // ┘
  for (int i = 1; i < w - 1; i++) {
    set_bkg_tile_xy(x + i, y, h_line);         // ─
    set_bkg_tile_xy(x + i, y + h - 1, h_line); // ─
  }
  for (int i = 1; i < h - 1; i++) {
    set_bkg_tile_xy(x, y + i, v_line);         // │
    set_bkg_tile_xy(x + w - 1, y + i, v_line); // │
  }
}

void inventory_draw(void) {
  // Clear screen
  fill_bkg_rect(0, 0, 20, 18, (uint8_t)128);

  // Header
  text_print(5, 1, "INVENTARIO");

  if (inventory_count == 0) {
    text_print(7, 8, "VACIO");
  } else {
    // List part
    for (uint8_t i = 0; i < inventory_count; i++) {
      text_print(5, 4 + i, inventory[i].name);
    }

    // Cursor
    text_print(3, 4 + selection, ">");

    // Detail Box
    draw_box(1, 12, 18, 5);
    // Icon + Name
    text_print(3, 13, "#"); // Key Icon (always key for now)
    text_print(5, 13, inventory[selection].name);

    // Multi-line Description
    const char *desc = inventory[selection].description;
    uint8_t start = 0;
    uint8_t line = 0;
    char line_buffer[17]; // Max 16 chars per line inside box

    while (desc[start] != '\0' && line < 3) {
      uint8_t len = 0;
      uint8_t last_space = 0;

      // Find how many chars fit and where the last space is
      while (desc[start + len] != '\0' && len < 15) {
        if (desc[start + len] == ' ')
          last_space = len;
        len++;
      }

      // If we hit the end of the string, take it all
      if (desc[start + len] == '\0') {
        strncpy(line_buffer, &desc[start], len);
        line_buffer[len] = '\0';
        start += len;
      } else {
        // If we have a space, break there
        if (last_space > 0) {
          strncpy(line_buffer, &desc[start], last_space);
          line_buffer[last_space] = '\0';
          start += (last_space + 1);
        } else {
          // No space found, hard cut
          strncpy(line_buffer, &desc[start], 15);
          line_buffer[15] = '\0';
          start += 15;
        }
      }
      text_print(3, 14 + line, line_buffer);
      line++;
    }
  }

  text_print(1, 17, "(B) VOLVER");
}

void inventory_state_init(void) {
  DISPLAY_OFF;
  BGP_REG = 0xE4;
  move_bkg(0, 0);

  // Use the standard text system mapping
  text_init();

  selection = 0;
  inventory_draw();

  HIDE_SPRITES;
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
