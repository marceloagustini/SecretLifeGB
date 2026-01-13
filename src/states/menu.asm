;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module menu
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _menu_draw
	.globl _draw_text
	.globl _input_pressed
	.globl _fade_in
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
;src/states/menu.c:14: void draw_text(uint8_t x, uint8_t y, const char *txt) {
;	---------------------------------
; Function draw_text
; ---------------------------------
_draw_text::
	add	sp, #-4
	ldhl	sp,	#3
	ld	(hl-), a
	ld	(hl), e
;src/states/menu.c:15: for (int i = 0; txt[i] != '\0'; i++) {
	ld	bc, #0x0000
00106$:
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl), a
	or	a, a
	jr	Z, 00108$
;src/states/menu.c:16: uint8_t tile = 128; // Space
	inc	hl
;src/states/menu.c:17: if (txt[i] >= 'A' && txt[i] <= 'Z')
	ld	a, #0x80
	ld	(hl-), a
	ld	a, (hl)
	xor	a, #0x80
	sub	a, #0xc1
	jr	C, 00102$
	ld	e, (hl)
	ld	a,#0x5a
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00139$
	bit	7, d
	jr	NZ, 00140$
	cp	a, a
	jr	00140$
00139$:
	bit	7, d
	jr	Z, 00140$
	scf
00140$:
	jr	C, 00102$
;src/states/menu.c:18: tile = 128 + 1 + (txt[i] - 'A');
	ldhl	sp,	#0
	ld	a, (hl+)
	add	a, #0x40
	ld	(hl), a
00102$:
;src/states/menu.c:19: set_bkg_tile_xy(x + i, y, tile);
	ld	a, c
	ldhl	sp,	#3
	ld	e, (hl)
	dec	hl
	dec	hl
	add	a, e
	push	bc
	ld	h, (hl)
	push	hl
	inc	sp
	ldhl	sp,	#5
	ld	e, (hl)
	call	_set_bkg_tile_xy
	pop	bc
;src/states/menu.c:15: for (int i = 0; txt[i] != '\0'; i++) {
	inc	bc
	jr	00106$
00108$:
;src/states/menu.c:21: }
	add	sp, #4
	pop	hl
	pop	af
	jp	(hl)
;src/states/menu.c:23: void menu_draw(void) {
;	---------------------------------
; Function menu_draw
; ---------------------------------
_menu_draw::
;src/states/menu.c:25: fill_bkg_rect(0, 0, 20, 18, 128 + 0);
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
;src/states/menu.c:28: draw_text(4, 4, "SECRET LIFE");
	ld	de, #___str_0
	push	de
	ld	a,#0x04
	ld	e,a
	call	_draw_text
;src/states/menu.c:31: draw_text(7, 8, "START");
	ld	de, #___str_1
	push	de
	ld	e, #0x08
	ld	a, #0x07
	call	_draw_text
;src/states/menu.c:32: draw_text(7, 10, "ABOUT");
	ld	de, #___str_2
	push	de
	ld	e, #0x0a
	ld	a, #0x07
	call	_draw_text
;src/states/menu.c:35: set_bkg_tile_xy(5, 8 + (selection * 2), 128 + 32); // Use '>' or similar char
	ld	a, (_selection)
	add	a, a
	add	a, #0x08
	ld	h, #0xa0
	push	hl
	inc	sp
	ld	e, a
	ld	a, #0x05
	call	_set_bkg_tile_xy
;src/states/menu.c:36: }
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
;src/states/menu.c:38: void menu_init(void) {
;	---------------------------------
; Function menu_init
; ---------------------------------
_menu_init::
;src/states/menu.c:39: DISPLAY_OFF;
	call	_display_off
;src/states/menu.c:40: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;./gbdk/include/gb/gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/states/menu.c:46: set_bkg_data(128, 35, font_data);
	ld	de, #_font_data
	push	de
	ld	hl, #0x2380
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/menu.c:48: menu_draw();
	call	_menu_draw
;src/states/menu.c:50: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/menu.c:51: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/menu.c:52: fade_in();
;src/states/menu.c:53: }
	jp	_fade_in
;src/states/menu.c:55: void menu_update(void) {
;	---------------------------------
; Function menu_update
; ---------------------------------
_menu_update::
;src/states/menu.c:56: if (input_pressed(J_DOWN | J_UP)) {
	ld	a, #0x0c
	call	_input_pressed
	or	a, a
	jr	Z, 00102$
;src/states/menu.c:57: selection = 1 - selection;
	ld	a, (_selection)
	ld	c, a
	ld	a, #0x01
	sub	a, c
	ld	(#_selection),a
;src/states/menu.c:58: menu_draw();
	call	_menu_draw
00102$:
;src/states/menu.c:61: if (input_pressed(J_START | J_A)) {
	ld	a, #0x90
	call	_input_pressed
	or	a, a
	ret	Z
;src/states/menu.c:62: if (selection == 0) {
	ld	a, (#_selection)
	or	a, a
	ret	NZ
;src/states/menu.c:63: game_state = STATE_GAME;
	ld	hl, #_game_state
	ld	(hl), #0x02
;src/states/menu.c:67: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__selection:
	.db #0x00	; 0
	.area _CABS (ABS)
