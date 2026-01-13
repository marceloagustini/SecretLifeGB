;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module menu
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _menu_draw
	.globl _input_pressed
	.globl _fill_bkg_rect
	.globl _set_bkg_tile_xy
	.globl _set_bkg_data
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
;src/states/menu.c:13: void menu_draw(void) {
;	---------------------------------
; Function menu_draw
; ---------------------------------
_menu_draw::
;src/states/menu.c:15: fill_bkg_rect(0, 0, 20, 18, 128 + 0);
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
;src/states/menu.c:18: const char *title1 = "SECRET LIFE";
;src/states/menu.c:19: for (int i = 0; i < 11; i++)
	ld	c, #0x00
00105$:
	ld	a, c
	sub	a, #0x0b
	jr	NC, 00101$
;src/states/menu.c:20: set_bkg_tile_xy(4 + i, 4, 128 + 1 + (title1[i] - 'A'));
	ld	hl, #___str_0
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
	add	a, #0x40
	ld	b, a
	ld	a, c
	add	a, #0x04
	push	bc
	push	bc
	inc	sp
	ld	e, #0x04
	call	_set_bkg_tile_xy
	pop	bc
;src/states/menu.c:19: for (int i = 0; i < 11; i++)
	inc	c
	jr	00105$
00101$:
;src/states/menu.c:23: const char *opt1 = "START";
;src/states/menu.c:24: const char *opt2 = "ABOUT";
;src/states/menu.c:26: for (int i = 0; i < 5; i++)
	ld	c, #0x00
00108$:
	ld	a, c
	sub	a, #0x05
	jr	NC, 00102$
;src/states/menu.c:27: set_bkg_tile_xy(7 + i, 8, 128 + 1 + (opt1[i] - 'A'));
	ld	hl, #___str_1
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
	add	a, #0x40
	ld	b, a
	ld	a, c
	add	a, #0x07
	push	bc
	push	bc
	inc	sp
	ld	e, #0x08
	call	_set_bkg_tile_xy
	pop	bc
;src/states/menu.c:26: for (int i = 0; i < 5; i++)
	inc	c
	jr	00108$
00102$:
;src/states/menu.c:28: for (int i = 0; i < 5; i++)
	ld	c, #0x00
00111$:
	ld	a, c
	sub	a, #0x05
	jr	NC, 00103$
;src/states/menu.c:29: set_bkg_tile_xy(7 + i, 10, 128 + 1 + (opt2[i] - 'A'));
	ld	hl, #___str_2
	ld	b, #0x00
	add	hl, bc
	ld	a, (hl)
	add	a, #0x40
	ld	b, a
	ld	a, c
	add	a, #0x07
	push	bc
	push	bc
	inc	sp
	ld	e, #0x0a
	call	_set_bkg_tile_xy
	pop	bc
;src/states/menu.c:28: for (int i = 0; i < 5; i++)
	inc	c
	jr	00111$
00103$:
;src/states/menu.c:32: set_bkg_tile_xy(5, 8 + (selection * 2), 128 + 32); // Use '>' or similar char
	ld	a, (_selection)
	add	a, a
	add	a, #0x08
	ld	e, a
	ld	a, #0xa0
	push	af
	inc	sp
	ld	a, #0x05
	call	_set_bkg_tile_xy
;src/states/menu.c:33: }
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
;src/states/menu.c:35: void menu_init(void) {
;	---------------------------------
; Function menu_init
; ---------------------------------
_menu_init::
;src/states/menu.c:36: DISPLAY_OFF;
	call	_display_off
;src/states/menu.c:37: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/states/menu.c:40: set_bkg_data(128, 35, font_data);
	ld	de, #_font_data
	push	de
	ld	hl, #0x2380
	push	hl
	call	_set_bkg_data
	add	sp, #4
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
;src/states/menu.c:46: }
	ret
;src/states/menu.c:48: void menu_update(void) {
;	---------------------------------
; Function menu_update
; ---------------------------------
_menu_update::
;src/states/menu.c:49: if (input_pressed(J_DOWN | J_UP)) {
	ld	a, #0x0c
	call	_input_pressed
	or	a, a
	jr	Z, 00102$
;src/states/menu.c:50: selection = 1 - selection;
	ld	a, (_selection)
	ld	c, a
	ld	a, #0x01
	sub	a, c
	ld	(#_selection),a
;src/states/menu.c:51: menu_draw();
	call	_menu_draw
00102$:
;src/states/menu.c:54: if (input_pressed(J_START | J_A)) {
	ld	a, #0x90
	call	_input_pressed
	or	a, a
	ret	Z
;src/states/menu.c:55: if (selection == 0) {
	ld	a, (#_selection)
	or	a, a
	ret	NZ
;src/states/menu.c:56: game_state = STATE_GAME;
	ld	hl, #_game_state
	ld	(hl), #0x02
;src/states/menu.c:60: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__selection:
	.db #0x00	; 0
	.area _CABS (ABS)
