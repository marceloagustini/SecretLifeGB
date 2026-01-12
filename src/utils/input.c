#include "input.h"

uint8_t joy_current = 0;
uint8_t joy_previous = 0;

void input_update(void) {
  joy_previous = joy_current;
  joy_current = joypad();
}

uint8_t input_pressed(uint8_t button) {
  return (joy_current & button) && !(joy_previous & button);
}

uint8_t input_held(uint8_t button) { return (joy_current & button); }

uint8_t input_released(uint8_t button) {
  return !(joy_current & button) && (joy_previous & button);
}
