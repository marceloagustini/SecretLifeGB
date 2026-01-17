#include "text.h"
#include "../../res/assets.h"
#include "music.h"
#include <gb/gb.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

#define FONT_BASE_TILE 128
#define WIN_WIDTH 20
#define WIN_HEIGHT 6
#define TEXT_WIDTH 18 // Internal width (minus borders)
#define TEXT_LINES 4  // Internal lines

void text_init(void) {
  set_win_data(FONT_BASE_TILE, 128,
               font_data); // Load enough tiles for the expanded font
  move_win(7, 144);
}

uint8_t get_tile_for_char(char c) {
  if (c == ' ' || c == '\n')
    return (uint8_t)(FONT_BASE_TILE + 0);
  if (c >= 'A' && c <= 'Z')
    return (uint8_t)(FONT_BASE_TILE + 1 + (c - 'A'));
  if (c >= 'a' && c <= 'z')
    return (uint8_t)(FONT_BASE_TILE + 27 + (c - 'a'));
  if (c == ',')
    return (uint8_t)(FONT_BASE_TILE + 53);
  if (c == '?')
    return (uint8_t)(FONT_BASE_TILE + 54);
  if (c == '!')
    return (uint8_t)(FONT_BASE_TILE + 55);
  if (c == '*')
    return (uint8_t)(FONT_BASE_TILE + 56);
  if (c == '>')
    return (uint8_t)(FONT_BASE_TILE + 57);
  if (c == '.')
    return (uint8_t)(FONT_BASE_TILE + 58);
  if (c == '#')
    return (uint8_t)(FONT_BASE_TILE + 59);

  // Box drawing
  if (c == 1)
    return (uint8_t)(FONT_BASE_TILE + 60); // ┌
  if (c == 2)
    return (uint8_t)(FONT_BASE_TILE + 61); // ─
  if (c == 3)
    return (uint8_t)(FONT_BASE_TILE + 62); // ┐
  if (c == 4)
    return (uint8_t)(FONT_BASE_TILE + 63); // │
  if (c == 5)
    return (uint8_t)(FONT_BASE_TILE + 64); // └
  if (c == 6)
    return (uint8_t)(FONT_BASE_TILE + 65); // ┘

  // Numbers
  if (c >= '0' && c <= '9')
    return (uint8_t)(FONT_BASE_TILE + 66 + (c - '0'));

  if (c == ':')
    return (uint8_t)(FONT_BASE_TILE + 76);

  return (uint8_t)(FONT_BASE_TILE + 0);
}

unsigned char dialog_buf[120];

void clear_dialog_buf(void) {
  for (int i = 0; i < 120; i++)
    dialog_buf[i] = (uint8_t)FONT_BASE_TILE;
  dialog_buf[0] = get_tile_for_char(1);
  for (int i = 1; i < 19; i++)
    dialog_buf[i] = get_tile_for_char(2);
  dialog_buf[19] = get_tile_for_char(3);
  for (int y = 1; y < 5; y++) {
    dialog_buf[y * 20] = get_tile_for_char(4);
    dialog_buf[y * 20 + 19] = get_tile_for_char(4);
  }
  dialog_buf[100] = get_tile_for_char(5);
  for (int i = 101; i < 119; i++)
    dialog_buf[i] = get_tile_for_char(2);
  dialog_buf[119] = get_tile_for_char(6);
}

void text_wait(uint8_t delay_vbl) {
  for (uint8_t i = 0; i < delay_vbl; i++) {
    wait_vbl_done();
    music_update();
  }
}

void wait_input(uint8_t btn) {
  while (!(joypad() & btn)) {
    wait_vbl_done();
    music_update();
  }
}

void wait_input_up(void) {
  while (joypad() != 0) {
    wait_vbl_done();
    music_update();
  }
}

void text_dialogue(const char *str) {
  wait_input_up();
  // Hide ALL sprites during dialogue (including player)
  for (int i = 0; i < 40; i++)
    move_sprite(i, 0, 0);
  const char *ptr = str;
  while (*ptr != '\0') {
    clear_dialog_buf();
    int cur_line = 0, cur_col = 0;
    while (*ptr != '\0' && cur_line < TEXT_LINES) {
      const char *word_end = ptr;
      int word_len = 0;
      while (*word_end != '\0' && *word_end != ' ' && *word_end != '\n') {
        word_len++;
        word_end++;
      }
      if (cur_col + word_len > TEXT_WIDTH) {
        cur_line++;
        cur_col = 0;
        if (cur_line >= TEXT_LINES)
          break;
      }
      for (int i = 0; i < word_len; i++) {
        int pos = (cur_line + 1) * 20 + (cur_col + 1);
        dialog_buf[pos] = get_tile_for_char(*ptr);
        ptr++;
        cur_col++;
      }
      if (*ptr == ' ' || *ptr == '\n') {
        if (*ptr == '\n') {
          cur_line++;
          cur_col = 0;
        } else {
          cur_col++;
        }
        ptr++;
      }
    }
    set_win_tiles(0, 0, 20, 6, dialog_buf);
    move_win(7, 144 - 48);
    SHOW_WIN;
    wait_input(J_A);
    text_wait(6);
    wait_input_up();
  }
  HIDE_WIN;
  move_win(7, 144);
}

void text_print(uint8_t x, uint8_t y, const char *str) {
  for (int i = 0; str[i] != '\0'; i++) {
    set_bkg_tile_xy(x + i, y, get_tile_for_char(str[i]));
  }
}

void text_clear(void) { fill_bkg_rect(0, 0, 20, 18, get_tile_for_char(' ')); }
