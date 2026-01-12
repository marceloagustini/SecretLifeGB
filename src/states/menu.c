#include "../utils/input.h"
#include "states.h"
#include <gb/gb.h>
#include <stdio.h>

extern uint8_t game_state; // Defined in main.c

void menu_init(void) {
  wait_vbl_done();
  // Turn off screen to write VRAM
  DISPLAY_OFF;

  // Set default palette
  BGP_REG = 0xE4;

  // Clear screen
  // get_bkg_data / set_bkg_data ...
  // For simplicity, we just use printf to the background
  printf("\n\n\n\n");
  printf("   GAMEBOY ZELDA\n");
  printf("      LIKE\n");
  printf("\n\n");
  printf("   PRESS START");

  // Turn screen on
  SHOW_BKG;
  DISPLAY_ON;
}

void menu_update(void) {
  if (input_pressed(J_START)) {
    // Switch to game state
    // game_state = 1; // Assuming 1 is GAME
    // Since we don't have direct access, we might need to return a value,
    // but for now we'll assume the main loop handles the transition if we set a
    // flag OR we just use a global. Let's rely on the main loop to see the
    // return or global change.
  }
}
