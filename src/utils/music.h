#ifndef MUSIC_H
#define MUSIC_H

#include <gb/gb.h>
#include <stdint.h>

// Note frequencies for GameBoy (approximate)
#define NOTE_C3 44
#define NOTE_D3 156
#define NOTE_E3 262
#define NOTE_F3 363
#define NOTE_G3 457
#define NOTE_A3 547
#define NOTE_B3 631
#define NOTE_C4 1046
#define NOTE_D4 1102
#define NOTE_E4 1155
#define NOTE_F4 1205
#define NOTE_G4 1253
#define NOTE_A4 1297
#define NOTE_B4 1339
#define NOTE_C5 1546
#define NOTE_OFF 0

typedef struct {
  uint16_t hz;
  uint8_t len;
} note_t;

// A simple Zelda-ish loop
extern const note_t bg_music[];

void music_init();
void music_update();

#endif
