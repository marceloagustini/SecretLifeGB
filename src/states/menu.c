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

#include "../utils/text.h"

void menu_draw(void) {
  // Clear BKG with space (tile 128+0)
  fill_bkg_rect(0, 0, 20, 18, 128 + 0);

  // Title
  text_print(4, 4, "SECRET LIFE");

  // Options
  text_print(7, 8, "START");
  text_print(7, 10, "ABOUT");

  // Cursor
  set_bkg_tile_xy(5, 8 + (selection * 2), get_tile_for_char('>'));
}

void menu_init(void) {
  DISPLAY_OFF;
  BGP_REG = 0xE4;

  // Reset scroll and hide sprites
  move_bkg(0, 0);
  HIDE_SPRITES;

  // Load font data using common text system
  text_init();

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
