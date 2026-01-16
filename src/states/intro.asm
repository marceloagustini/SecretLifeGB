;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module intro
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strlen
	.globl _get_tile_for_char
	.globl _input_pressed
	.globl _fade_in
	.globl _fade_out
	.globl _fill_bkg_rect
	.globl _set_bkg_tile_xy
	.globl _set_bkg_data
	.globl _display_off
	.globl _delay
	.globl _intro_init
	.globl _intro_update
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
_intro_timer:
	.ds 1
_title_y:
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
;src/states/intro.c:16: void intro_init(void) {
;	---------------------------------
; Function intro_init
; ---------------------------------
_intro_init::
;src/states/intro.c:17: DISPLAY_OFF;
	call	_display_off
;src/states/intro.c:18: fade_out();
	call	_fade_out
;src/states/intro.c:19: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/states/intro.c:20: HIDE_WIN;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
;src/states/intro.c:24: fill_bkg_rect(0, 0, 32, 32, empty_tile);
	ld	hl, #0x8020
	push	hl
	ld	a, #0x20
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
;src/states/intro.c:28: set_bkg_data(128, 35, font_data);
	ld	de, #_font_data
	push	de
	ld	hl, #0x2380
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/intro.c:30: const char *line1 = "SECRET";
;src/states/intro.c:31: const char *line2 = "LIFE";
;src/states/intro.c:35: for (int i = 0; i < strlen(line1); i++) {
	ld	bc, #0x0000
00105$:
	ld	de, #___str_0
	push	de
	call	_strlen
	pop	hl
	ld	l, e
	ld	h, d
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	bit	7, e
	jr	Z, 00142$
	bit	7, d
	jr	NZ, 00143$
	cp	a, a
	jr	00143$
00142$:
	bit	7, d
	jr	Z, 00143$
	scf
00143$:
	jr	NC, 00101$
;src/states/intro.c:36: set_bkg_tile_xy(7 + i, 16, get_tile_for_char(line1[i]));
	ld	hl, #___str_0
	add	hl, bc
	ld	a, (hl)
	push	bc
	call	_get_tile_for_char
	ld	d, a
	pop	bc
	ld	a, c
	add	a, #0x07
	push	bc
	push	de
	inc	sp
	ld	e, #0x10
	call	_set_bkg_tile_xy
	pop	bc
;src/states/intro.c:35: for (int i = 0; i < strlen(line1); i++) {
	inc	bc
	jr	00105$
00101$:
;src/states/intro.c:38: for (int i = 0; i < strlen(line2); i++) {
	ld	bc, #0x0000
00108$:
	ld	de, #___str_1
	push	de
	call	_strlen
	pop	hl
	ld	l, e
	ld	h, d
	ld	e, h
	ld	d, b
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	bit	7, e
	jr	Z, 00144$
	bit	7, d
	jr	NZ, 00145$
	cp	a, a
	jr	00145$
00144$:
	bit	7, d
	jr	Z, 00145$
	scf
00145$:
	jr	NC, 00102$
;src/states/intro.c:39: set_bkg_tile_xy(8 + i, 18, get_tile_for_char(line2[i]));
	ld	hl, #___str_1
	add	hl, bc
	ld	a, (hl)
	push	bc
	call	_get_tile_for_char
	ld	d, a
	pop	bc
	ld	a, c
	add	a, #0x08
	push	bc
	push	de
	inc	sp
	ld	e, #0x12
	call	_set_bkg_tile_xy
	pop	bc
;src/states/intro.c:38: for (int i = 0; i < strlen(line2); i++) {
	inc	bc
	jr	00108$
00102$:
;./gbdk/include/gb/gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, #0x90
	ldh	(_SCY_REG + 0), a
;src/states/intro.c:43: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/intro.c:44: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/intro.c:45: fade_in();
	call	_fade_in
;src/states/intro.c:46: intro_timer = 0;
	xor	a, a
	ld	(#_intro_timer),a
;src/states/intro.c:47: title_y = 144;
	ld	hl, #_title_y
	ld	(hl), #0x90
;src/states/intro.c:48: }
	ret
___str_0:
	.ascii "SECRET"
	.db 0x00
___str_1:
	.ascii "LIFE"
	.db 0x00
;src/states/intro.c:50: void intro_update(void) {
;	---------------------------------
; Function intro_update
; ---------------------------------
_intro_update::
;src/states/intro.c:51: if (title_y > 60) {
	ld	a, #0x3c
	ld	hl, #_title_y
	sub	a, (hl)
	jr	NC, 00105$
;src/states/intro.c:52: title_y--;
	dec	(hl)
;src/states/intro.c:53: move_bkg(0, title_y);
	ld	c, (hl)
;./gbdk/include/gb/gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/states/intro.c:54: delay(30);
	ld	de, #0x001e
	call	_delay
	jr	00106$
00105$:
;src/states/intro.c:56: intro_timer++;
	ld	hl, #_intro_timer
	inc	(hl)
;src/states/intro.c:57: if (intro_timer > 60 || input_pressed(J_START | J_A | J_B)) {
	ld	a, #0x3c
	sub	a, (hl)
	jr	C, 00101$
	ld	a, #0xb0
	call	_input_pressed
	or	a, a
	jr	Z, 00106$
00101$:
;src/states/intro.c:58: fade_out();
	call	_fade_out
;src/states/intro.c:59: game_state = STATE_MENU;
	ld	hl, #_game_state
	ld	(hl), #0x01
00106$:
;src/states/intro.c:63: if (input_pressed(J_START)) {
	ld	a, #0x80
	call	_input_pressed
	or	a, a
	ret	Z
;src/states/intro.c:64: game_state = STATE_MENU;
	ld	hl, #_game_state
	ld	(hl), #0x01
;src/states/intro.c:66: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__intro_timer:
	.db #0x00	; 0
__xinit__title_y:
	.db #0x90	; 144
	.area _CABS (ABS)
