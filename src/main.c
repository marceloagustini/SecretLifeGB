#include "states/states.h"
#include "utils/input.h"
#include <gb/gb.h>
#include <stdio.h>

// State definitions
#define STATE_MENU 0
#define STATE_GAME 1

// Global state tracking
uint8_t game_state = STATE_MENU;
uint8_t current_state = 255; // Force init on first loop

void main(void) {
  // Basic init
  // font_init(); // If we had a custom font helper

  // Infinite loop
  while (1) {
    // Update input
    input_update();

    // State Machine
    if (game_state != current_state) {
      // State change detected, run init
      current_state = game_state;
      if (game_state == STATE_MENU) {
        menu_init();
      } else if (game_state == STATE_GAME) {
        game_init();
      }
    }

    // Run update
    if (game_state == STATE_MENU) {
      menu_update();
      // Check transition condition inside main for simplicity
      if (input_pressed(J_START)) {
        game_state = STATE_GAME;
      }
    } else if (game_state == STATE_GAME) {
      game_update();
    }

    // Wait for VBlank (60FPS cap)
    wait_vbl_done();
  }
}
