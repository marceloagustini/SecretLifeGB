#ifndef TEXT_H
#define TEXT_H

#include <gb/gb.h>

void text_init(void);
void text_print(uint8_t x, uint8_t y, const char *str);
void text_dialogue(const char *str);
void text_clear(void);

#endif
