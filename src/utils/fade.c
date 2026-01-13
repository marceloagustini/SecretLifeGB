#include "fade.h"

void fade_out() {
  uint8_t palettes[] = {0xE4, 0x90, 0x40, 0xFF};
  for (int i = 0; i < 4; i++) {
    BGP_REG = OBP0_REG = OBP1_REG = palettes[i];
    delay(50);
  }
}

void fade_in() {
  uint8_t palettes[] = {0xFF, 0x40, 0x90, 0xE4};
  for (int i = 0; i < 4; i++) {
    BGP_REG = OBP0_REG = OBP1_REG = palettes[i];
    delay(50);
  }
}
