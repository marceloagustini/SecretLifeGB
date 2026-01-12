#ifndef INPUT_H
#define INPUT_H

#include <gb/gb.h>

extern uint8_t joy_current;
extern uint8_t joy_previous;

void input_update(void);
uint8_t input_pressed(uint8_t button);
uint8_t input_held(uint8_t button);
uint8_t input_released(uint8_t button);

#endif
