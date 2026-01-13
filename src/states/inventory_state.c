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
    uint8_t tile = (uint8_t)128; // Space
    if (txt[i] >= 'A' && txt[i] <= 'Z')
      tile = (uint8_t)(128 + 1 + (txt[i] - 'A'));
    else if (txt[i] == '>')
      tile = (uint8_t)(128 + 31);
    else if (txt[i] == '#')
      tile = (uint8_t)(128 + 32);
    else if (txt[i] == ',')
      tile = (uint8_t)(128 + 27);
    else if (txt[i] == '?')
      tile = (uint8_t)(128 + 28);
    else if (txt[i] == '!')
      tile = (uint8_t)(128 + 29);
    else if (txt[i] == '.')
      tile = (uint8_t)(128 + 30);
    set_bkg_tile_xy(x + i, y, tile);
  }
}

static void draw_box(uint8_t x, uint8_t y, uint8_t w, uint8_t h) {
  set_bkg_tile_xy(x, y, (uint8_t)(128 + 33));                 // ┌
  set_bkg_tile_xy(x + w - 1, y, (uint8_t)(128 + 35));         // ┐
  set_bkg_tile_xy(x, y + h - 1, (uint8_t)(128 + 37));         // └
  set_bkg_tile_xy(x + w - 1, y + h - 1, (uint8_t)(128 + 38)); // ┘
  for (int i = 1; i < w - 1; i++) {
    set_bkg_tile_xy(x + i, y, (uint8_t)(128 + 34));         // ─
    set_bkg_tile_xy(x + i, y + h - 1, (uint8_t)(128 + 34)); // ─
  }
  for (int i = 1; i < h - 1; i++) {
    set_bkg_tile_xy(x, y + i, (uint8_t)(128 + 36));         // │
    set_bkg_tile_xy(x + w - 1, y + i, (uint8_t)(128 + 36)); // │
  }
}

void inventory_draw(void) {
  // Clear screen
  fill_bkg_rect(0, 0, 20, 18, (uint8_t)128);

  // Header
  draw_text(5, 1, "INVENTARIO");
  for (int i = 1; i < 19; i++)
    set_bkg_tile_xy(i, 2, (uint8_t)(128 + 34));

  if (inventory_count == 0) {
    draw_text(7, 8, "VACIO");
  } else {
    // List part
    for (uint8_t i = 0; i < inventory_count; i++) {
      draw_text(5, 4 + i, inventory[i].name);
    }

    // Cursor
    draw_text(3, 4 + selection, ">");

    // Detail Box
    draw_box(1, 12, 18, 5);
    // Icon + Name
    draw_text(3, 13, "#"); // Key Icon (always key for now)
    draw_text(5, 13, inventory[selection].name);

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
      draw_text(3, 14 + line, line_buffer);
      line++;
    }
  }

  draw_text(1, 17, "(B) VOLVER");
}

void inventory_state_init(void) {
  DISPLAY_OFF;
  BGP_REG = 0xE4;
  move_bkg(0, 0);

  // Use the text system mapping logic if possible, or just load data
  set_bkg_data(128, 39, font_data);

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
