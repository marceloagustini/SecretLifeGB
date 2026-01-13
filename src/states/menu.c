#include "../../res/assets.h"
#include "../utils/input.h"
#include "states.h"
#include <gb/gb.h>
#include <stdint.h>
#include <string.h>

extern uint8_t game_state;
#define STATE_GAME 2

static uint8_t selection = 0; // 0: START, 1: ABOUT

void menu_draw(void) {
  // Clear BKG with space (tile 128+0)
  fill_bkg_rect(0, 0, 20, 18, 128 + 0);

  // Title
  const char *title1 = "SECRET LIFE";
  for (int i = 0; i < 11; i++)
    set_bkg_tile_xy(4 + i, 4, 128 + 1 + (title1[i] - 'A'));

  // Options
  const char *opt1 = "START";
  const char *opt2 = "ABOUT";

  for (int i = 0; i < 5; i++)
    set_bkg_tile_xy(7 + i, 8, 128 + 1 + (opt1[i] - 'A'));
  for (int i = 0; i < 5; i++)
    set_bkg_tile_xy(7 + i, 10, 128 + 1 + (opt2[i] - 'A'));

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
