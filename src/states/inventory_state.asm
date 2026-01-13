;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module inventory_state
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _inventory_draw
	.globl _input_pressed
	.globl _fill_bkg_rect
	.globl _set_bkg_tile_xy
	.globl _set_bkg_data
	.globl _display_off
	.globl _inventory_state_init
	.globl _inventory_state_update
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
;src/states/inventory_state.c:15: static void draw_text(uint8_t x, uint8_t y, const char *txt) {
;	---------------------------------
; Function draw_text
; ---------------------------------
_draw_text:
	add	sp, #-4
	ldhl	sp,	#3
	ld	(hl-), a
	ld	(hl), e
;src/states/inventory_state.c:16: for (int i = 0; txt[i] != '\0'; i++) {
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
;src/states/inventory_state.c:17: uint8_t tile = 128; // Space
	inc	hl
;src/states/inventory_state.c:18: if (txt[i] >= 'A' && txt[i] <= 'Z')
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
;src/states/inventory_state.c:19: tile = 128 + 1 + (txt[i] - 'A');
	ldhl	sp,	#0
	ld	a, (hl+)
	add	a, #0x40
	ld	(hl), a
00102$:
;src/states/inventory_state.c:20: set_bkg_tile_xy(x + i, y, tile);
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
;src/states/inventory_state.c:16: for (int i = 0; txt[i] != '\0'; i++) {
	inc	bc
	jr	00106$
00108$:
;src/states/inventory_state.c:22: }
	add	sp, #4
	pop	hl
	pop	af
	jp	(hl)
;src/states/inventory_state.c:24: void inventory_draw(void) {
;	---------------------------------
; Function inventory_draw
; ---------------------------------
_inventory_draw::
;src/states/inventory_state.c:26: fill_bkg_rect(0, 0, 20, 18, 128);
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
;src/states/inventory_state.c:29: draw_text(4, 1, "INVENTARIO");
	ld	de, #___str_0
	push	de
	ld	e, #0x01
	ld	a, #0x04
	call	_draw_text
;src/states/inventory_state.c:32: for (int i = 1; i < 19; i++)
	ld	c, #0x01
00107$:
;src/states/inventory_state.c:34: i, 2, 128 + 30); // Use a line char if available or just space for now
	ld	a,c
	cp	a,#0x13
	jr	NC, 00101$
	push	bc
	ld	h, #0x9e
	push	hl
	inc	sp
	ld	e, #0x02
	call	_set_bkg_tile_xy
	pop	bc
;src/states/inventory_state.c:32: for (int i = 1; i < 19; i++)
	inc	c
	jr	00107$
00101$:
;src/states/inventory_state.c:36: if (inventory_count == 0) {
	ld	a, (#_inventory_count)
	or	a, a
	jr	NZ, 00118$
;src/states/inventory_state.c:37: draw_text(4, 8, "VACIO");
	ld	de, #___str_1
	push	de
	ld	e, #0x08
	ld	a, #0x04
	call	_draw_text
	jr	00105$
;src/states/inventory_state.c:39: for (uint8_t i = 0; i < inventory_count; i++) {
00118$:
	ld	c, #0x00
00110$:
	ld	a, c
	ld	hl, #_inventory_count
	sub	a, (hl)
	jr	NC, 00102$
;src/states/inventory_state.c:40: draw_text(4, 4 + (i * 1), inventory[i].name);
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_inventory
	add	hl, de
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	add	a, #0x04
	push	bc
	push	hl
	ld	e, a
	ld	a, #0x04
	call	_draw_text
	pop	bc
;src/states/inventory_state.c:39: for (uint8_t i = 0; i < inventory_count; i++) {
	inc	c
	jr	00110$
00102$:
;src/states/inventory_state.c:44: set_bkg_tile_xy(2, 4 + selection, 128 + 32); // Arrow/Cursor
	ld	a, (_selection)
	add	a, #0x04
	ld	h, #0xa0
	push	hl
	inc	sp
	ld	e, a
	ld	a, #0x02
	call	_set_bkg_tile_xy
;src/states/inventory_state.c:47: draw_text(1, 14, "--------------------");
	ld	de, #___str_2
	push	de
	ld	e, #0x0e
	ld	a, #0x01
	call	_draw_text
;src/states/inventory_state.c:48: draw_text(1, 15, inventory[selection].description);
	ld	hl, #_selection
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	bc, #_inventory
	add	hl, bc
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	e, #0x0f
	ld	a, #0x01
	call	_draw_text
00105$:
;src/states/inventory_state.c:51: draw_text(2, 17, "(B) VOLVER");
	ld	de, #___str_3
	push	de
	ld	e, #0x11
	ld	a, #0x02
	call	_draw_text
;src/states/inventory_state.c:52: }
	ret
___str_0:
	.ascii "INVENTARIO"
	.db 0x00
___str_1:
	.ascii "VACIO"
	.db 0x00
___str_2:
	.ascii "--------------------"
	.db 0x00
___str_3:
	.ascii "(B) VOLVER"
	.db 0x00
;src/states/inventory_state.c:54: void inventory_state_init(void) {
;	---------------------------------
; Function inventory_state_init
; ---------------------------------
_inventory_state_init::
;src/states/inventory_state.c:55: DISPLAY_OFF;
	call	_display_off
;src/states/inventory_state.c:56: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;./gbdk/include/gb/gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/states/inventory_state.c:60: set_bkg_data(128, 35, font_data);
	ld	de, #_font_data
	push	de
	ld	hl, #0x2380
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/inventory_state.c:62: selection = 0;
	xor	a, a
	ld	(#_selection),a
;src/states/inventory_state.c:63: inventory_draw();
	call	_inventory_draw
;src/states/inventory_state.c:65: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/inventory_state.c:66: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/inventory_state.c:67: }
	ret
;src/states/inventory_state.c:69: void inventory_state_update(void) {
;	---------------------------------
; Function inventory_state_update
; ---------------------------------
_inventory_state_update::
;src/states/inventory_state.c:70: if (inventory_count > 0) {
	ld	a, (#_inventory_count)
	or	a, a
	jr	Z, 00110$
;src/states/inventory_state.c:71: if (input_pressed(J_DOWN)) {
	ld	a, #0x08
	call	_input_pressed
	or	a, a
	jr	Z, 00104$
;src/states/inventory_state.c:72: if (selection < inventory_count - 1) {
	ld	a, (_inventory_count)
	ld	b, #0x00
	ld	c, a
	dec	bc
	ld	a, (_selection)
	ld	l, a
	ld	h, #0x00
	ld	e, b
	ld	d, h
	ld	a, l
	sub	a, c
	ld	a, h
	sbc	a, b
	bit	7, e
	jr	Z, 00157$
	bit	7, d
	jr	NZ, 00158$
	cp	a, a
	jr	00158$
00157$:
	bit	7, d
	jr	Z, 00158$
	scf
00158$:
	jr	NC, 00104$
;src/states/inventory_state.c:73: selection++;
	ld	hl, #_selection
	inc	(hl)
;src/states/inventory_state.c:74: inventory_draw();
	call	_inventory_draw
00104$:
;src/states/inventory_state.c:77: if (input_pressed(J_UP)) {
	ld	a, #0x04
	call	_input_pressed
	or	a, a
	jr	Z, 00110$
;src/states/inventory_state.c:78: if (selection > 0) {
	ld	hl, #_selection
	ld	a, (hl)
	or	a, a
	jr	Z, 00110$
;src/states/inventory_state.c:79: selection--;
	dec	(hl)
;src/states/inventory_state.c:80: inventory_draw();
	call	_inventory_draw
00110$:
;src/states/inventory_state.c:85: if (input_pressed(J_B)) {
	ld	a, #0x20
	call	_input_pressed
	or	a, a
	ret	Z
;src/states/inventory_state.c:86: game_state = STATE_GAME;
	ld	hl, #_game_state
	ld	(hl), #0x02
;src/states/inventory_state.c:88: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__selection:
	.db #0x00	; 0
	.area _CABS (ABS)
