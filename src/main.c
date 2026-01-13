#include "states/states.h"
#include "utils/input.h"
#include "utils/inventory.h"
#include <gb/gb.h>
#include <stdio.h>

// State definitions
#define STATE_INTRO 0
#define STATE_MENU 1
#define STATE_GAME 2
#define STATE_INVENTORY 3

// Global state tracking
uint8_t game_state = STATE_INTRO;
uint8_t current_state = 255; // Force init on first loop

void main(void) {
  // Basic init
  inventory_init();

  // Infinite loop
  while (1) {
    // Update input
    input_update();

    // State Machine
    if (game_state != current_state) {
      // State change detected, run init
      current_state = game_state;
      if (game_state == STATE_INTRO) {
        intro_init();
      } else if (game_state == STATE_MENU) {
        menu_init();
      } else if (game_state == STATE_GAME) {
        game_init();
      } else if (game_state == STATE_INVENTORY) {
        inventory_state_init();
      }
    }

    // Run update
    if (game_state == STATE_INTRO) {
      intro_update();
    } else if (game_state == STATE_MENU) {
      menu_update();
      if (input_pressed(J_START)) {
        game_state = STATE_GAME;
      }
    } else if (game_state == STATE_GAME) {
      game_update();
    } else if (game_state == STATE_INVENTORY) {
      inventory_state_update();
    }

    // Wait for VBlank (60FPS cap)
    wait_vbl_done();
  }
}
