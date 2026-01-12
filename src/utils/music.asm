;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module music
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _play_note
	.globl _music_timer
	.globl _music_note_idx
	.globl _bg_music
	.globl _music_init
	.globl _music_update
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_music_note_idx::
	.ds 1
_music_timer::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/utils/music.c:14: void music_init() {
;	---------------------------------
; Function music_init
; ---------------------------------
_music_init::
;src/utils/music.c:15: NR52_REG = 0x80; // Turn on sound
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/utils/music.c:16: NR50_REG = 0x77; // Max volume
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/utils/music.c:17: NR51_REG = 0xFF; // All channels
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/utils/music.c:19: music_note_idx = 0;
;src/utils/music.c:20: music_timer = 0;
	xor	a, a
	ld	(#_music_note_idx), a
	ld	(#_music_timer),a
;src/utils/music.c:21: }
	ret
_bg_music:
	.dw #0x0277
	.db #0x10	; 16
	.dw #0x01c9
	.db #0x10	; 16
	.dw #0x0277
	.db #0x10	; 16
	.dw #0x01c9
	.db #0x10	; 16
	.dw #0x0277
	.db #0x10	; 16
	.dw #0x01c9
	.db #0x10	; 16
	.dw #0x0277
	.db #0x10	; 16
	.dw #0x01c9
	.db #0x08	; 8
	.dw #0x0277
	.db #0x08	; 8
	.dw #0x0416
	.db #0x10	; 16
	.dw #0x0223
	.db #0x10	; 16
	.dw #0x0416
	.db #0x10	; 16
	.dw #0x0223
	.db #0x10	; 16
	.dw #0x0416
	.db #0x10	; 16
	.dw #0x0223
	.db #0x10	; 16
	.dw #0x0416
	.db #0x10	; 16
	.dw #0x0223
	.db #0x08	; 8
	.dw #0x0416
	.db #0x08	; 8
	.dw #0x0000
	.db #0x00	; 0
;src/utils/music.c:23: void play_note(uint16_t hz) {
;	---------------------------------
; Function play_note
; ---------------------------------
_play_note::
;src/utils/music.c:24: if (hz == NOTE_OFF) {
	ld	a, d
;src/utils/music.c:25: NR12_REG = 0x00; // Mute
	or	a, e
	jr	NZ, 00102$
	ldh	(_NR12_REG + 0), a
	ret
00102$:
;src/utils/music.c:27: NR10_REG = 0x00; // No sweep
	xor	a, a
	ldh	(_NR10_REG + 0), a
;src/utils/music.c:28: NR11_REG = 0x80; // 50% duty
	ld	a, #0x80
	ldh	(_NR11_REG + 0), a
;src/utils/music.c:29: NR12_REG = 0xA2; // Volume 10, fade 2
	ld	a, #0xa2
	ldh	(_NR12_REG + 0), a
;src/utils/music.c:30: NR13_REG = (uint8_t)hz;
	ld	a, e
	ldh	(_NR13_REG + 0), a
;src/utils/music.c:31: NR14_REG = (uint8_t)(hz >> 8) | 0x80; // Trigger note
	ld	a, d
	or	a, #0x80
	ldh	(_NR14_REG + 0), a
;src/utils/music.c:33: }
	ret
;src/utils/music.c:35: void music_update() {
;	---------------------------------
; Function music_update
; ---------------------------------
_music_update::
	add	sp, #-4
;src/utils/music.c:36: if (music_timer == 0) {
	ld	a, (#_music_timer)
	or	a, a
	jr	NZ, 00104$
;src/utils/music.c:37: if (bg_music[music_note_idx].len == 0) {
	ld	hl, #_music_note_idx
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	bc, #_bg_music
	add	hl, bc
	inc	hl
	inc	hl
	ld	a, (hl)
;src/utils/music.c:38: music_note_idx = 0; // Loop
	or	a,a
	jr	NZ, 00102$
	ld	(#_music_note_idx),a
00102$:
;src/utils/music.c:40: play_note(bg_music[music_note_idx].hz);
	ld	hl, #_music_note_idx
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	ld	bc, #_bg_music
	add	hl, bc
	ld	a, (hl+)
	ld	c, (hl)
	ld	e, a
	ld	d, c
	call	_play_note
;src/utils/music.c:41: music_timer = bg_music[music_note_idx].len;
	ld	hl, #_music_note_idx
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
	ld	de, #_bg_music
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(#_music_timer),a
;src/utils/music.c:42: music_note_idx++;
	ld	hl, #_music_note_idx
	inc	(hl)
00104$:
;src/utils/music.c:44: music_timer--;
	ld	hl, #_music_timer
	dec	(hl)
;src/utils/music.c:45: }
	add	sp, #4
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__music_note_idx:
	.db #0x00	; 0
__xinit__music_timer:
	.db #0x00	; 0
	.area _CABS (ABS)
