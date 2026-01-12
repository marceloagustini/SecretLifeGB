#include "text.h"
#include "../../res/assets.h"
#include <gb/gb.h>
#include <stdio.h>

// Back to 128. In GBDK's default mode (8800), tiles 128-255 are at $8800-$8FFF.
#define FONT_BASE_TILE 128

void text_init(void) {
  // Load manual font to Window VRAM
  set_win_data(FONT_BASE_TILE, 35, font_data);

  // Position window at bottom (hidden initially)
  move_win(7, 144);
}

// Map char to manually loaded font index
uint8_t get_tile_for_char(char c) {
  // Font order in assets.c: " ABCDEFGHIJKLMNOPQRSTUVWXYZ,?┌─┐│└┘"
  if (c == ' ')
    return (uint8_t)(FONT_BASE_TILE + 0);
  if (c >= 'A' && c <= 'Z')
    return (uint8_t)(FONT_BASE_TILE + 1 + (c - 'A'));
  if (c == ',')
    return (uint8_t)(FONT_BASE_TILE + 27);
  if (c == '?')
    return (uint8_t)(FONT_BASE_TILE + 28);

  // Internal box drawing markers (1-6)
  if (c == 1)
    return (uint8_t)(FONT_BASE_TILE + 29); // ┌
  if (c == 2)
    return (uint8_t)(FONT_BASE_TILE + 30); // ─
  if (c == 3)
    return (uint8_t)(FONT_BASE_TILE + 31); // ┐
  if (c == 4)
    return (uint8_t)(FONT_BASE_TILE + 32); // │
  if (c == 5)
    return (uint8_t)(FONT_BASE_TILE + 33); // └
  if (c == 6)
    return (uint8_t)(FONT_BASE_TILE + 34); // ┘

  return (uint8_t)(FONT_BASE_TILE + 0);
}

unsigned char dialog_buf[80]; // 20x4

void text_dialogue(const char *str) {
  // Wait for user to release A (if they pressed it to talk)
  // This ensures the first page isn't skipped.
  waitpadup();

  const char *ptr = str;

  while (*ptr != '\0') {
    // Clear box buffer with spaces
    for (int i = 0; i < 80; i++)
      dialog_buf[i] = (uint8_t)FONT_BASE_TILE;

    // Draw borders in buffer
    dialog_buf[0] = get_tile_for_char(1);
    for (int i = 1; i < 19; i++)
      dialog_buf[i] = get_tile_for_char(2);
    dialog_buf[19] = get_tile_for_char(3);

    dialog_buf[20] = get_tile_for_char(4);
    dialog_buf[39] = get_tile_for_char(4);
    dialog_buf[40] = get_tile_for_char(4);
    dialog_buf[59] = get_tile_for_char(4);

    dialog_buf[60] = get_tile_for_char(5);
    for (int i = 61; i < 79; i++)
      dialog_buf[i] = get_tile_for_char(2);
    dialog_buf[79] = get_tile_for_char(6);

    // Fill text
    int line = 0;
    int col = 0;
    int count = 0;
    while (*ptr != '\0' && count < 32) {
      if (*ptr == ',') {
        ptr++;
        if (*ptr == ' ')
          ptr++;
        break;
      }

      int pos = (line == 0) ? (22 + col) : (42 + col);
      dialog_buf[pos] = get_tile_for_char(*ptr);

      col++;
      count++;
      if (col >= 16) {
        col = 0;
        line++;
        if (line >= 2)
          break;
      }
      ptr++;
    }

    // Display window
    // Offset window tiles slightly so they aren't off-screen internally
    set_win_tiles(0, 0, 20, 4, dialog_buf);
    move_win(7, 112);
    SHOW_WIN;

    // Wait for A press
    waitpad(J_A);
    delay(100); // Debounce
    waitpadup();
  }

  HIDE_WIN;
  move_win(7, 144);
}
