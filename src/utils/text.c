#include "text.h"
#include "../../res/assets.h"
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
  set_win_data(FONT_BASE_TILE, 38, font_data);
  move_win(7, 144);
}

uint8_t get_tile_for_char(char c) {
  if (c == ' ' || c == '\n')
    return (uint8_t)(FONT_BASE_TILE + 0);
  if (c >= 'A' && c <= 'Z')
    return (uint8_t)(FONT_BASE_TILE + 1 + (c - 'A'));
  if (c >= 'a' && c <= 'z')
    return (uint8_t)(FONT_BASE_TILE + 1 + (c - 'a'));
  if (c == ',')
    return (uint8_t)(FONT_BASE_TILE + 27);
  if (c == '?')
    return (uint8_t)(FONT_BASE_TILE + 28);
  if (c == '!')
    return (uint8_t)(FONT_BASE_TILE + 29);
  if (c == (char)0xA1 || c == (char)-95) // '¡' in many encodings
    return (uint8_t)(FONT_BASE_TILE + 30);
  if (c == '.')
    return (uint8_t)(FONT_BASE_TILE + 31);

  // Box drawing - shifted by 3 due to new chars
  if (c == 1)
    return (uint8_t)(FONT_BASE_TILE + 32);
  if (c == 2)
    return (uint8_t)(FONT_BASE_TILE + 33);
  if (c == 3)
    return (uint8_t)(FONT_BASE_TILE + 34);
  if (c == 4)
    return (uint8_t)(FONT_BASE_TILE + 35);
  if (c == 5)
    return (uint8_t)(FONT_BASE_TILE + 36);
  if (c == 6)
    return (uint8_t)(FONT_BASE_TILE + 37);

  return (uint8_t)(FONT_BASE_TILE + 0);
}

unsigned char dialog_buf[120];

void clear_dialog_buf() {
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

void text_dialogue(const char *str) {
  waitpadup();
  HIDE_SPRITES; // Ensure box is on top
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
    waitpad(J_A);
    delay(100);
    waitpadup();
  }
  HIDE_WIN;
  move_win(7, 144);
  SHOW_SPRITES;
}
