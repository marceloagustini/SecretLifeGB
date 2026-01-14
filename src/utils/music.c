#include "music.h"

// Zelda Theme snippet (Simplified Intro)
const note_t bg_music[] = {
    {NOTE_B3, 16}, {NOTE_G3, 16}, {NOTE_B3, 16}, {NOTE_G3, 16}, {NOTE_B3, 16},
    {NOTE_G3, 16}, {NOTE_B3, 16}, {NOTE_G3, 8},  {NOTE_B3, 8},  {NOTE_C4, 16},
    {NOTE_A3, 16}, {NOTE_C4, 16}, {NOTE_A3, 16}, {NOTE_C4, 16}, {NOTE_A3, 16},
    {NOTE_C4, 16}, {NOTE_A3, 8},  {NOTE_C4, 8},  {NOTE_OFF, 0} // Sentinel
};

uint8_t music_note_idx = 0;
uint8_t music_timer = 0;

void music_init() {
  NR52_REG = 0x80; // Turn on sound
  NR50_REG = 0x77; // Max volume
  NR51_REG = 0xFF; // All channels

  music_note_idx = 0;
  music_timer = 0;
}

void play_note(uint16_t hz) {
  if (hz == NOTE_OFF) {
    NR12_REG = 0x00; // Mute
  } else {
    NR10_REG = 0x00; // No sweep
    NR11_REG = 0x80; // 50% duty
    NR12_REG = 0xA2; // Volume 10, fade 2
    NR13_REG = (uint8_t)hz;
    NR14_REG = (uint8_t)(hz >> 8) | 0x80; // Trigger note
  }
}

void music_update() {
  if (music_timer == 0) {
    if (bg_music[music_note_idx].len == 0) {
      music_note_idx = 0; // Loop
    }
    play_note(bg_music[music_note_idx].hz);
    music_timer = bg_music[music_note_idx].len;
    music_note_idx++;
  }
  music_timer--;
}

void sfx_pickup() {
  // Channel 1: Sweep up (Coin-like)
  NR10_REG = 0x16; // Sweep time 1, increase, shift 6
  NR11_REG = 0x80; // 50% duty
  NR12_REG = 0xF0; // Init vol 15, no env
  NR13_REG = 0x00; // Low bits
  NR14_REG = 0xC4; // Trigger, high bits (freq ~1024)
}

void sfx_success() {
  // Channel 1: Long rising tone
  NR10_REG = 0x00; // No sweep
  NR11_REG = 0x80; // 50% duty
  NR12_REG = 0xF2; // Init vol 15, fade 2
  NR13_REG = 0x00;
  NR14_REG = 0xC7; // Trigger, freq ~1792 (High pitch)

  // Note: This interrupts the music on Channel 1 slightly, which is expected
  // behavior for simple engines
}
