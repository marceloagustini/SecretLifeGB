;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module gameover
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _game_reset
	.globl _text_clear
	.globl _text_print
	.globl _text_init
	.globl _input_pressed
	.globl _fade_in
	.globl _fade_out
	.globl _display_off
	.globl _gameover_init
	.globl _gameover_update
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
;src/states/gameover.c:11: void gameover_init(void) {
;	---------------------------------
; Function gameover_init
; ---------------------------------
_gameover_init::
;src/states/gameover.c:12: fade_out();
	call	_fade_out
;src/states/gameover.c:13: DISPLAY_OFF;
	call	_display_off
;src/states/gameover.c:16: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;./gbdk/include/gb/gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/states/gameover.c:20: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/states/gameover.c:23: text_init();
	call	_text_init
;src/states/gameover.c:24: text_clear();
	call	_text_clear
;src/states/gameover.c:27: text_print(5, 7, "Game Over");
	ld	de, #___str_0
	push	de
	ld	e, #0x07
	ld	a, #0x05
	call	_text_print
;src/states/gameover.c:28: text_print(4, 10, "Press A or B");
	ld	de, #___str_1
	push	de
	ld	e, #0x0a
	ld	a, #0x04
	call	_text_print
;./gbdk/include/gb/gb.h:1739: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x90
	ldh	(_WY_REG + 0), a
;src/states/gameover.c:32: HIDE_WIN;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
;src/states/gameover.c:34: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/gameover.c:35: fade_in();
;src/states/gameover.c:36: }
	jp	_fade_in
___str_0:
	.ascii "Game Over"
	.db 0x00
___str_1:
	.ascii "Press A or B"
	.db 0x00
;src/states/gameover.c:38: void gameover_update(void) {
;	---------------------------------
; Function gameover_update
; ---------------------------------
_gameover_update::
;src/states/gameover.c:39: if (input_pressed(J_A | J_B)) {
	ld	a, #0x30
	call	_input_pressed
	or	a, a
	ret	Z
;src/states/gameover.c:40: fade_out();
	call	_fade_out
;src/states/gameover.c:41: game_reset();
	call	_game_reset
;src/states/gameover.c:42: game_state = STATE_MENU;
	ld	hl, #_game_state
	ld	(hl), #0x01
;src/states/gameover.c:44: }
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
