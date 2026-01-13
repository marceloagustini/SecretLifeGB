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
00124$:
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
	jp	Z, 00126$
;src/states/inventory_state.c:17: uint8_t tile = (uint8_t)128; // Space
	inc	hl
;src/states/inventory_state.c:18: if (txt[i] >= 'A' && txt[i] <= 'Z')
	ld	a, #0x80
	ld	(hl-), a
	ld	a, (hl)
	xor	a, #0x80
	sub	a, #0xc1
	jr	C, 00119$
	ld	e, (hl)
	ld	a,#0x5a
	ld	d,a
	sub	a, (hl)
	bit	7, e
	jr	Z, 00199$
	bit	7, d
	jr	NZ, 00200$
	cp	a, a
	jr	00200$
00199$:
	bit	7, d
	jr	Z, 00200$
	scf
00200$:
	jr	C, 00119$
;src/states/inventory_state.c:19: tile = (uint8_t)(128 + 1 + (txt[i] - 'A'));
	ldhl	sp,	#0
	ld	a, (hl+)
	add	a, #0x40
	ld	(hl), a
	jr	00120$
00119$:
;src/states/inventory_state.c:20: else if (txt[i] == '>')
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x3e
	jr	NZ, 00116$
;src/states/inventory_state.c:21: tile = (uint8_t)(128 + 31);
	ldhl	sp,	#1
	ld	(hl), #0x9f
	jr	00120$
00116$:
;src/states/inventory_state.c:22: else if (txt[i] == '#')
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x23
	jr	NZ, 00113$
;src/states/inventory_state.c:23: tile = (uint8_t)(128 + 32);
	ldhl	sp,	#1
	ld	(hl), #0xa0
	jr	00120$
00113$:
;src/states/inventory_state.c:24: else if (txt[i] == ',')
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x2c
	jr	NZ, 00110$
;src/states/inventory_state.c:25: tile = (uint8_t)(128 + 27);
	ldhl	sp,	#1
	ld	(hl), #0x9b
	jr	00120$
00110$:
;src/states/inventory_state.c:26: else if (txt[i] == '?')
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x3f
	jr	NZ, 00107$
;src/states/inventory_state.c:27: tile = (uint8_t)(128 + 28);
	ldhl	sp,	#1
	ld	(hl), #0x9c
	jr	00120$
00107$:
;src/states/inventory_state.c:28: else if (txt[i] == '!')
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x21
	jr	NZ, 00104$
;src/states/inventory_state.c:29: tile = (uint8_t)(128 + 29);
	ldhl	sp,	#1
	ld	(hl), #0x9d
	jr	00120$
00104$:
;src/states/inventory_state.c:30: else if (txt[i] == '.')
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x2e
	jr	NZ, 00120$
;src/states/inventory_state.c:31: tile = (uint8_t)(128 + 30);
	ldhl	sp,	#1
	ld	(hl), #0x9e
00120$:
;src/states/inventory_state.c:32: set_bkg_tile_xy(x + i, y, tile);
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
	jp	00124$
00126$:
;src/states/inventory_state.c:34: }
	add	sp, #4
	pop	hl
	pop	af
	jp	(hl)
;src/states/inventory_state.c:36: static void draw_box(uint8_t x, uint8_t y, uint8_t w, uint8_t h) {
;	---------------------------------
; Function draw_box
; ---------------------------------
_draw_box:
	add	sp, #-6
	ldhl	sp,	#3
	ld	(hl-), a
	ld	(hl), e
;src/states/inventory_state.c:37: set_bkg_tile_xy(x, y, (uint8_t)(128 + 33));                 // ┌
	ld	a, #0xa1
	push	af
	inc	sp
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	call	_set_bkg_tile_xy
;src/states/inventory_state.c:38: set_bkg_tile_xy(x + w - 1, y, (uint8_t)(128 + 35));         // ┐
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#8
	add	a, (hl)
	dec	a
	ldhl	sp,	#0
	ld	(hl+), a
	inc	hl
	ld	a, #0xa3
	push	af
	inc	sp
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
	call	_set_bkg_tile_xy
;src/states/inventory_state.c:39: set_bkg_tile_xy(x, y + h - 1, (uint8_t)(128 + 37));         // └
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#9
	add	a, (hl)
	dec	a
	ldhl	sp,	#1
	ld	(hl), a
	ld	a, #0xa5
	push	af
	inc	sp
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
	call	_set_bkg_tile_xy
;src/states/inventory_state.c:40: set_bkg_tile_xy(x + w - 1, y + h - 1, (uint8_t)(128 + 38)); // ┘
	ld	a, #0xa6
	push	af
	inc	sp
	ldhl	sp,	#2
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	call	_set_bkg_tile_xy
;src/states/inventory_state.c:41: for (int i = 1; i < w - 1; i++) {
	ldhl	sp,	#4
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00104$:
	ldhl	sp,	#8
	ld	c, (hl)
	xor	a, a
	ld	b, a
	dec	bc
	ldhl	sp,	#4
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00141$
	bit	7, d
	jr	NZ, 00142$
	cp	a, a
	jr	00142$
00141$:
	bit	7, d
	jr	Z, 00142$
	scf
00142$:
	jr	NC, 00101$
;src/states/inventory_state.c:42: set_bkg_tile_xy(x + i, y, (uint8_t)(128 + 34));         // ─
	ldhl	sp,	#4
	ld	a, (hl-)
	ld	c, (hl)
	dec	hl
	add	a, c
	ld	c, a
	push	bc
	ld	a, #0xa2
	push	af
	inc	sp
	ld	e, (hl)
	ld	a, c
	call	_set_bkg_tile_xy
	pop	bc
;src/states/inventory_state.c:43: set_bkg_tile_xy(x + i, y + h - 1, (uint8_t)(128 + 34)); // ─
	ld	a, #0xa2
	push	af
	inc	sp
	ldhl	sp,	#2
	ld	e, (hl)
	ld	a, c
	call	_set_bkg_tile_xy
;src/states/inventory_state.c:41: for (int i = 1; i < w - 1; i++) {
	ldhl	sp,	#4
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00101$:
;src/states/inventory_state.c:45: for (int i = 1; i < h - 1; i++) {
	ld	bc, #0x0001
00107$:
	ldhl	sp,	#9
	ld	e, (hl)
	xor	a, a
	ld	l, e
	ld	h, a
	dec	hl
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
	jr	NC, 00109$
;src/states/inventory_state.c:46: set_bkg_tile_xy(x, y + i, (uint8_t)(128 + 36));         // │
	ldhl	sp,	#5
	ld	(hl), c
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#5
	add	a, (hl)
	dec	hl
	dec	hl
	ld	e, a
	push	bc
	push	de
	ld	a, #0xa4
	push	af
	inc	sp
	ld	a, (hl)
	call	_set_bkg_tile_xy
	pop	de
;src/states/inventory_state.c:47: set_bkg_tile_xy(x + w - 1, y + i, (uint8_t)(128 + 36)); // │
	ld	a, #0xa4
	push	af
	inc	sp
	ldhl	sp,	#3
	ld	a, (hl)
	call	_set_bkg_tile_xy
	pop	bc
;src/states/inventory_state.c:45: for (int i = 1; i < h - 1; i++) {
	inc	bc
	jr	00107$
00109$:
;src/states/inventory_state.c:49: }
	add	sp, #6
	pop	hl
	pop	af
	jp	(hl)
;src/states/inventory_state.c:51: void inventory_draw(void) {
;	---------------------------------
; Function inventory_draw
; ---------------------------------
_inventory_draw::
;src/states/inventory_state.c:53: fill_bkg_rect(0, 0, 20, 18, (uint8_t)128);
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
;src/states/inventory_state.c:56: draw_text(5, 1, "INVENTARIO");
	ld	de, #___str_0
	push	de
	ld	e, #0x01
	ld	a, #0x05
	call	_draw_text
;src/states/inventory_state.c:57: for (int i = 1; i < 19; i++)
	ld	c, #0x01
00107$:
;src/states/inventory_state.c:58: set_bkg_tile_xy(i, 2, (uint8_t)(128 + 34));
	ld	a,c
	cp	a,#0x13
	jr	NC, 00101$
	push	bc
	ld	h, #0xa2
	push	hl
	inc	sp
	ld	e, #0x02
	call	_set_bkg_tile_xy
	pop	bc
;src/states/inventory_state.c:57: for (int i = 1; i < 19; i++)
	inc	c
	jr	00107$
00101$:
;src/states/inventory_state.c:60: if (inventory_count == 0) {
	ld	a, (#_inventory_count)
	or	a, a
	jr	NZ, 00118$
;src/states/inventory_state.c:61: draw_text(7, 8, "VACIO");
	ld	de, #___str_1
	push	de
	ld	e, #0x08
	ld	a, #0x07
	call	_draw_text
	jp	00105$
;src/states/inventory_state.c:64: for (uint8_t i = 0; i < inventory_count; i++) {
00118$:
	ld	c, #0x00
00110$:
	ld	a, c
	ld	hl, #_inventory_count
	sub	a, (hl)
	jr	NC, 00102$
;src/states/inventory_state.c:65: draw_text(5, 4 + i, inventory[i].name);
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
	ld	a, #0x05
	call	_draw_text
	pop	bc
;src/states/inventory_state.c:64: for (uint8_t i = 0; i < inventory_count; i++) {
	inc	c
	jr	00110$
00102$:
;src/states/inventory_state.c:69: draw_text(3, 4 + selection, ">");
	ld	a, (_selection)
	add	a, #0x04
	ld	de, #___str_2
	push	de
	ld	e, a
	ld	a, #0x03
	call	_draw_text
;src/states/inventory_state.c:72: draw_box(1, 12, 18, 5);
	ld	hl, #0x512
	push	hl
	ld	e, #0x0c
	ld	a, #0x01
	call	_draw_box
;src/states/inventory_state.c:74: draw_text(3, 13, "#"); // Key Icon (always key for now)
	ld	de, #___str_3
	push	de
	ld	e, #0x0d
	ld	a, #0x03
	call	_draw_text
;src/states/inventory_state.c:75: draw_text(5, 13, inventory[selection].name);
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
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	e, #0x0d
	ld	a, #0x05
	call	_draw_text
;src/states/inventory_state.c:77: draw_text(3, 14, inventory[selection].description);
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
	ld	e, #0x0e
	ld	a, #0x03
	call	_draw_text
00105$:
;src/states/inventory_state.c:80: draw_text(1, 17, "(B) VOLVER");
	ld	de, #___str_4
	push	de
	ld	e, #0x11
	ld	a, #0x01
	call	_draw_text
;src/states/inventory_state.c:81: }
	ret
___str_0:
	.ascii "INVENTARIO"
	.db 0x00
___str_1:
	.ascii "VACIO"
	.db 0x00
___str_2:
	.ascii ">"
	.db 0x00
___str_3:
	.ascii "#"
	.db 0x00
___str_4:
	.ascii "(B) VOLVER"
	.db 0x00
;src/states/inventory_state.c:83: void inventory_state_init(void) {
;	---------------------------------
; Function inventory_state_init
; ---------------------------------
_inventory_state_init::
;src/states/inventory_state.c:84: DISPLAY_OFF;
	call	_display_off
;src/states/inventory_state.c:85: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;./gbdk/include/gb/gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/states/inventory_state.c:89: set_bkg_data(128, 39, font_data);
	ld	de, #_font_data
	push	de
	ld	hl, #0x2780
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/inventory_state.c:91: selection = 0;
	xor	a, a
	ld	(#_selection),a
;src/states/inventory_state.c:92: inventory_draw();
	call	_inventory_draw
;src/states/inventory_state.c:94: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/states/inventory_state.c:95: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/inventory_state.c:96: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/inventory_state.c:97: }
	ret
;src/states/inventory_state.c:99: void inventory_state_update(void) {
;	---------------------------------
; Function inventory_state_update
; ---------------------------------
_inventory_state_update::
;src/states/inventory_state.c:100: if (inventory_count > 0) {
	ld	a, (#_inventory_count)
	or	a, a
	jr	Z, 00110$
;src/states/inventory_state.c:101: if (input_pressed(J_DOWN)) {
	ld	a, #0x08
	call	_input_pressed
	or	a, a
	jr	Z, 00104$
;src/states/inventory_state.c:102: if (selection < inventory_count - 1) {
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
;src/states/inventory_state.c:103: selection++;
	ld	hl, #_selection
	inc	(hl)
;src/states/inventory_state.c:104: inventory_draw();
	call	_inventory_draw
00104$:
;src/states/inventory_state.c:107: if (input_pressed(J_UP)) {
	ld	a, #0x04
	call	_input_pressed
	or	a, a
	jr	Z, 00110$
;src/states/inventory_state.c:108: if (selection > 0) {
	ld	hl, #_selection
	ld	a, (hl)
	or	a, a
	jr	Z, 00110$
;src/states/inventory_state.c:109: selection--;
	dec	(hl)
;src/states/inventory_state.c:110: inventory_draw();
	call	_inventory_draw
00110$:
;src/states/inventory_state.c:115: if (input_pressed(J_B)) {
	ld	a, #0x20
	call	_input_pressed
	or	a, a
	ret	Z
;src/states/inventory_state.c:116: game_state = STATE_GAME;
	ld	hl, #_game_state
	ld	(hl), #0x02
;src/states/inventory_state.c:118: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__selection:
	.db #0x00	; 0
	.area _CABS (ABS)
