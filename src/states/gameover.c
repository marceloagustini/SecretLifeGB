#include "../../res/assets.h"
#include "../utils/fade.h"
#include "../utils/input.h"
#include "../utils/text.h"
#include "states.h"
#include <gb/gb.h>
#include <stdint.h>

extern uint8_t game_state;

void gameover_init(void) {
  fade_out();
  DISPLAY_OFF;

  // Set standard palette
  BGP_REG = 0xE4;

  // Reset scroll and hide world
  move_bkg(0, 0);
  HIDE_SPRITES;

  // Ensure font is loaded for this state
  text_init();
  text_clear();

  // Print centered messages
  text_print(5, 7, "GAME OVER");
  text_print(4, 10, "PRESS A OR B");

  // Reset window
  move_win(7, 144);
  HIDE_WIN;

  DISPLAY_ON;
  fade_in();
}

void gameover_update(void) {
  if (input_pressed(J_A | J_B)) {
    fade_out();
    game_reset();
    game_state = STATE_MENU;
  }
}
