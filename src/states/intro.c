#include "../../res/assets.h"
#include "../utils/fade.h"
#include "../utils/input.h"
#include "../utils/text.h"
#include "states.h"
#include <gb/gb.h>
#include <stdint.h>
#include <string.h>

extern uint8_t game_state;
#define STATE_MENU 1

static uint8_t intro_timer = 0;
static uint8_t title_y = 144; // Start at bottom

void intro_init(void) {
  DISPLAY_OFF;
  fade_out();
  HIDE_SPRITES;
  HIDE_WIN;

  // Clear BKG
  uint8_t empty_tile = 128 + 0; // Space
  fill_bkg_rect(0, 0, 32, 32, empty_tile);

  // Draw "SECRET LIFE" in the middle of a 32x32 map
  // We'll use the font tiles (loaded to BKG for this state)
  set_bkg_data(128, 35, font_data);

  const char *line1 = "SECRET";
  const char *line2 = "LIFE";

  // Position lines on a "virtual" map that is 32 columns wide
  // We'll place them around row 15-18
  for (int i = 0; i < 6; i++) {
    set_bkg_tile_xy(7 + i, 16, 128 + 1 + (line1[i] - 'A'));
  }
  for (int i = 0; i < 4; i++) {
    set_bkg_tile_xy(8 + i, 18, 128 + 1 + (line2[i] - 'A'));
  }

  move_bkg(0, 144); // Move camera down so title is hidden
  SHOW_BKG;
  DISPLAY_ON;
  fade_in();
  intro_timer = 0;
  title_y = 144;
}

void intro_update(void) {
  if (title_y > 60) {
    title_y--;
    move_bkg(0, title_y);
    delay(30);
  } else {
    intro_timer++;
    if (intro_timer > 60 || input_pressed(J_START | J_A | J_B)) {
      fade_out();
      game_state = STATE_MENU;
    }
  }

  if (input_pressed(J_START)) {
    game_state = STATE_MENU;
  }
}
