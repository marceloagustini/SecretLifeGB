;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module menu
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _menu_draw
	.globl _get_tile_for_char
	.globl _text_print
	.globl _text_init
	.globl _input_pressed
	.globl _fade_in
	.globl _fill_bkg_rect
	.globl _set_bkg_tile_xy
	.globl _display_off
	.globl _menu_init
	.globl _menu_update
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
_selection:
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
;src/states/menu.c:16: void menu_draw(void) {
;	---------------------------------
; Function menu_draw
; ---------------------------------
_menu_draw::
;src/states/menu.c:18: fill_bkg_rect(0, 0, 20, 18, 128 + 0);
	ld	hl, #0x8012
	push	hl
	ld	a, #0x14
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
;src/states/menu.c:21: text_print(4, 4, "SECRET LIFE");
	ld	de, #___str_0
	push	de
	ld	a,#0x04
	ld	e,a
	call	_text_print
;src/states/menu.c:24: text_print(7, 8, "START");
	ld	de, #___str_1
	push	de
	ld	e, #0x08
	ld	a, #0x07
	call	_text_print
;src/states/menu.c:25: text_print(7, 10, "ABOUT");
	ld	de, #___str_2
	push	de
	ld	e, #0x0a
	ld	a, #0x07
	call	_text_print
;src/states/menu.c:28: set_bkg_tile_xy(5, 8 + (selection * 2), get_tile_for_char('*'));
	ld	a, #0x2a
	call	_get_tile_for_char
	ld	b, a
	ld	a, (_selection)
	add	a, a
	add	a, #0x08
	push	bc
	inc	sp
	ld	e, a
	ld	a, #0x05
	call	_set_bkg_tile_xy
;src/states/menu.c:29: }
	ret
___str_0:
	.ascii "SECRET LIFE"
	.db 0x00
___str_1:
	.ascii "START"
	.db 0x00
___str_2:
	.ascii "ABOUT"
	.db 0x00
;src/states/menu.c:31: void menu_init(void) {
;	---------------------------------
; Function menu_init
; ---------------------------------
_menu_init::
;src/states/menu.c:32: DISPLAY_OFF;
	call	_display_off
;src/states/menu.c:33: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;./gbdk/include/gb/gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/states/menu.c:37: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/states/menu.c:40: text_init();
	call	_text_init
;src/states/menu.c:42: menu_draw();
	call	_menu_draw
;src/states/menu.c:44: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/menu.c:45: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/menu.c:46: fade_in();
;src/states/menu.c:47: }
	jp	_fade_in
;src/states/menu.c:49: void menu_update(void) {
;	---------------------------------
; Function menu_update
; ---------------------------------
_menu_update::
;src/states/menu.c:50: if (input_pressed(J_DOWN | J_UP)) {
	ld	a, #0x0c
	call	_input_pressed
	or	a, a
	jr	Z, 00102$
;src/states/menu.c:51: selection = 1 - selection;
	ld	a, (_selection)
	ld	c, a
	ld	a, #0x01
	sub	a, c
	ld	(#_selection),a
;src/states/menu.c:52: menu_draw();
	call	_menu_draw
00102$:
;src/states/menu.c:55: if (input_pressed(J_START | J_A)) {
	ld	a, #0x90
	call	_input_pressed
	or	a, a
	ret	Z
;src/states/menu.c:56: if (selection == 0) {
	ld	a, (#_selection)
	or	a, a
	ret	NZ
;src/states/menu.c:57: game_state = STATE_GAME;
	ld	hl, #_game_state
	ld	(hl), #0x02
;src/states/menu.c:61: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__selection:
	.db #0x00	; 0
	.area _CABS (ABS)
