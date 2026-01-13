#include "../../res/assets.h"
#include "../utils/fade.h"
#include "../utils/input.h"
#include "states.h"
#include <gb/gb.h>
#include <stdint.h>
#include <string.h>

extern uint8_t game_state;
#define STATE_GAME 2

static uint8_t selection = 0; // 0: START, 1: ABOUT

void draw_text(uint8_t x, uint8_t y, const char *txt) {
  for (int i = 0; txt[i] != '\0'; i++) {
    uint8_t tile = 128; // Space
    if (txt[i] >= 'A' && txt[i] <= 'Z')
      tile = 128 + 1 + (txt[i] - 'A');
    set_bkg_tile_xy(x + i, y, tile);
  }
}

void menu_draw(void) {
  // Clear BKG with space (tile 128+0)
  fill_bkg_rect(0, 0, 20, 18, 128 + 0);

  // Title
  draw_text(4, 4, "SECRET LIFE");

  // Options
  draw_text(7, 8, "START");
  draw_text(7, 10, "ABOUT");

  // Cursor
  set_bkg_tile_xy(5, 8 + (selection * 2), 128 + 32); // Use '>' or similar char
}

void menu_init(void) {
  DISPLAY_OFF;
  BGP_REG = 0xE4;

  // Reset scroll position (might be offset from intro)
  move_bkg(0, 0);

  // Load font data to BKG tiles starting at 128
  set_bkg_data(128, 35, font_data);

  menu_draw();

  SHOW_BKG;
  DISPLAY_ON;
  fade_in();
}

void menu_update(void) {
  if (input_pressed(J_DOWN | J_UP)) {
    selection = 1 - selection;
    menu_draw();
  }

  if (input_pressed(J_START | J_A)) {
    if (selection == 0) {
      game_state = STATE_GAME;
    }
    // Selection 1 (ABOUT) does nothing for now
  }
}
