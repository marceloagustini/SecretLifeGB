;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module inventory_state
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _inventory_draw
	.globl _get_tile_for_char
	.globl _text_print
	.globl _text_init
	.globl _strncpy
	.globl _input_pressed
	.globl _fill_bkg_rect
	.globl _set_bkg_tile_xy
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
;src/states/inventory_state.c:17: static void draw_box(uint8_t x, uint8_t y, uint8_t w, uint8_t h) {
;	---------------------------------
; Function draw_box
; ---------------------------------
_draw_box:
	add	sp, #-8
	ldhl	sp,	#5
	ld	(hl-), a
	ld	(hl), e
;src/states/inventory_state.c:19: uint8_t tl = get_tile_for_char(1);
	ld	a, #0x01
	call	_get_tile_for_char
	ldhl	sp,	#2
	ld	(hl), a
;src/states/inventory_state.c:20: uint8_t h_line = get_tile_for_char(2);
	ld	a, #0x02
	call	_get_tile_for_char
	ldhl	sp,	#0
	ld	(hl), a
;src/states/inventory_state.c:21: uint8_t tr = get_tile_for_char(3);
	ld	a, #0x03
	call	_get_tile_for_char
	ldhl	sp,	#3
	ld	(hl), a
;src/states/inventory_state.c:22: uint8_t v_line = get_tile_for_char(4);
	ld	a, #0x04
	call	_get_tile_for_char
	ldhl	sp,	#1
	ld	(hl), a
;src/states/inventory_state.c:23: uint8_t bl = get_tile_for_char(5);
	ld	a, #0x05
	call	_get_tile_for_char
	ldhl	sp,	#6
	ld	(hl), a
;src/states/inventory_state.c:24: uint8_t br = get_tile_for_char(6);
	ld	a, #0x06
	call	_get_tile_for_char
	ldhl	sp,	#7
	ld	(hl), a
;src/states/inventory_state.c:26: set_bkg_tile_xy(x, y, tl);                 // ┌
	ldhl	sp,	#2
	ld	a, (hl+)
	inc	hl
	push	af
	inc	sp
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl)
	call	_set_bkg_tile_xy
;src/states/inventory_state.c:27: set_bkg_tile_xy(x + w - 1, y, tr);         // ┐
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#10
	add	a, (hl)
	dec	a
	ldhl	sp,	#2
	ld	(hl+), a
	ld	a, (hl+)
	push	af
	inc	sp
	ld	a, (hl-)
	dec	hl
	ld	e, a
	ld	a, (hl)
	call	_set_bkg_tile_xy
;src/states/inventory_state.c:28: set_bkg_tile_xy(x, y + h - 1, bl);         // └
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#11
	add	a, (hl)
	dec	a
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl+)
	inc	hl
	ld	e, a
	ld	a, (hl)
	call	_set_bkg_tile_xy
;src/states/inventory_state.c:29: set_bkg_tile_xy(x + w - 1, y + h - 1, br); // ┘
	ldhl	sp,	#7
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	a, (hl-)
	ld	e, a
	ld	a, (hl)
	call	_set_bkg_tile_xy
;src/states/inventory_state.c:30: for (int i = 1; i < w - 1; i++) {
	ldhl	sp,	#6
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00104$:
	ldhl	sp,	#10
	ld	c, (hl)
	xor	a, a
	ld	b, a
	dec	bc
	ldhl	sp,	#6
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
;src/states/inventory_state.c:31: set_bkg_tile_xy(x + i, y, h_line);         // ─
	ldhl	sp,	#6
	ld	a, (hl-)
	ld	c, (hl)
	add	a, c
	ld	c, a
	push	bc
	ldhl	sp,	#2
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#7
	ld	e, (hl)
	ld	a, c
	call	_set_bkg_tile_xy
	pop	bc
;src/states/inventory_state.c:32: set_bkg_tile_xy(x + i, y + h - 1, h_line); // ─
	ldhl	sp,	#0
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#4
	ld	e, (hl)
	ld	a, c
	call	_set_bkg_tile_xy
;src/states/inventory_state.c:30: for (int i = 1; i < w - 1; i++) {
	ldhl	sp,	#6
	inc	(hl)
	jr	NZ, 00104$
	inc	hl
	inc	(hl)
	jr	00104$
00101$:
;src/states/inventory_state.c:34: for (int i = 1; i < h - 1; i++) {
	ldhl	sp,	#6
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00107$:
	ldhl	sp,	#11
	ld	c, (hl)
	xor	a, a
	ld	b, a
	dec	bc
	ldhl	sp,	#6
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
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
;src/states/inventory_state.c:35: set_bkg_tile_xy(x, y + i, v_line);         // │
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl+), a
	ld	a, (hl-)
	add	a, (hl)
	dec	hl
	dec	hl
	ld	e, a
	push	de
	ld	a, (hl)
	push	af
	inc	sp
	ldhl	sp,	#8
	ld	a, (hl)
	call	_set_bkg_tile_xy
	pop	de
;src/states/inventory_state.c:36: set_bkg_tile_xy(x + w - 1, y + i, v_line); // │
	ldhl	sp,	#1
	ld	a, (hl+)
	push	af
	inc	sp
	ld	a, (hl)
	call	_set_bkg_tile_xy
;src/states/inventory_state.c:34: for (int i = 1; i < h - 1; i++) {
	ldhl	sp,	#6
	inc	(hl)
	jr	NZ, 00107$
	inc	hl
	inc	(hl)
	jr	00107$
00109$:
;src/states/inventory_state.c:38: }
	add	sp, #8
	pop	hl
	pop	af
	jp	(hl)
;src/states/inventory_state.c:40: void inventory_draw(void) {
;	---------------------------------
; Function inventory_draw
; ---------------------------------
_inventory_draw::
	add	sp, #-25
;src/states/inventory_state.c:42: fill_bkg_rect(0, 0, 20, 18, (uint8_t)128);
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
;src/states/inventory_state.c:45: text_print(5, 1, "INVENTARIO");
	ld	de, #___str_0
	push	de
	ld	e, #0x01
	ld	a, #0x05
	call	_text_print
;src/states/inventory_state.c:47: if (inventory_count == 0) {
	ld	a, (#_inventory_count)
	or	a, a
	jr	NZ, 00128$
;src/states/inventory_state.c:48: text_print(7, 8, "VACIO");
	ld	de, #___str_1
	push	de
	ld	e, #0x08
	ld	a, #0x07
	call	_text_print
	jp	00120$
;src/states/inventory_state.c:51: for (uint8_t i = 0; i < inventory_count; i++) {
00128$:
	ld	c, #0x00
00122$:
	ld	a, c
	ld	hl, #_inventory_count
	sub	a, (hl)
	jr	NC, 00101$
;src/states/inventory_state.c:52: text_print(5, 4 + i, inventory[i].name);
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
	call	_text_print
	pop	bc
;src/states/inventory_state.c:51: for (uint8_t i = 0; i < inventory_count; i++) {
	inc	c
	jr	00122$
00101$:
;src/states/inventory_state.c:56: text_print(3, 4 + selection, ">");
	ld	bc, #___str_2+0
	ld	a, (_selection)
	add	a, #0x04
	ld	e, a
	push	bc
	ld	a, #0x03
	call	_text_print
;src/states/inventory_state.c:59: draw_box(1, 12, 18, 5);
	ld	hl, #0x512
	push	hl
	ld	e, #0x0c
	ld	a, #0x01
	call	_draw_box
;src/states/inventory_state.c:61: text_print(3, 13, "#");
	ld	de, #___str_3
	push	de
	ld	e, #0x0d
	ld	a, #0x03
	call	_text_print
;src/states/inventory_state.c:62: text_print(5, 13, inventory[selection].name);
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
	call	_text_print
;src/states/inventory_state.c:65: const char *desc = inventory[selection].description;
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
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#17
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/states/inventory_state.c:66: uint8_t start = 0;
	ldhl	sp,	#22
;src/states/inventory_state.c:70: while (desc[start] != '\0' && line < 3) {
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00115$:
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#22
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	or	a, a
	jp	Z, 00120$
	ldhl	sp,	#23
	ld	a, (hl)
	sub	a, #0x03
	jp	NC, 00120$
;src/states/inventory_state.c:72: uint8_t last_space = 0;
	ldhl	sp,	#19
	ld	(hl), #0x00
;src/states/inventory_state.c:75: while (desc[start + len] != '\0' && len < 15) {
	ldhl	sp,	#24
	ld	(hl), #0x00
00105$:
	ldhl	sp,	#22
	ld	a, (hl+)
	inc	hl
	ld	c, a
	ld	b, #0x00
	ld	a, (hl)
	ldhl	sp,	#20
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#17
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	or	a, a
	jr	Z, 00107$
	ldhl	sp,	#24
	ld	a, (hl)
	sub	a, #0x0f
	jr	NC, 00107$
;src/states/inventory_state.c:76: if (desc[start + len] == ' ')
	ld	a, c
	sub	a, #0x20
	jr	NZ, 00103$
;src/states/inventory_state.c:77: last_space = len;
	ld	a, (hl)
	ldhl	sp,	#19
	ld	(hl), a
00103$:
;src/states/inventory_state.c:78: len++;
	ldhl	sp,	#24
	inc	(hl)
	jr	00105$
00107$:
;src/states/inventory_state.c:82: if (desc[start + len] == '\0') {
	ld	a, c
	or	a, a
	jr	NZ, 00112$
;src/states/inventory_state.c:83: strncpy(line_buffer, &desc[start], len);
	ldhl	sp,	#20
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	c, e
	ld	b, d
	ld	hl, #2
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_strncpy
;src/states/inventory_state.c:84: line_buffer[len] = '\0';
	push	hl
	ld	hl, #2
	add	hl, sp
	ld	e, l
	ld	d, h
	pop	hl
	ldhl	sp,	#24
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/states/inventory_state.c:85: start += len;
	ldhl	sp,	#22
	ld	a, (hl+)
	inc	hl
	add	a, (hl)
	dec	hl
	dec	hl
	ld	(hl), a
	jr	00113$
00112$:
;src/states/inventory_state.c:91: start += (last_space + 1);
	ldhl	sp,	#22
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;src/states/inventory_state.c:88: if (last_space > 0) {
	ldhl	sp,	#19
	ld	a, (hl)
	or	a, a
	jr	Z, 00109$
;src/states/inventory_state.c:89: strncpy(line_buffer, &desc[start], last_space);
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	c, e
	ld	b, d
	ld	hl, #2
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_strncpy
;src/states/inventory_state.c:90: line_buffer[last_space] = '\0';
	push	hl
	ld	hl, #2
	add	hl, sp
	ld	e, l
	ld	d, h
	pop	hl
	ldhl	sp,	#19
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/states/inventory_state.c:91: start += (last_space + 1);
	ldhl	sp,	#19
	ld	a, (hl)
	inc	a
	ldhl	sp,	#24
	add	a, (hl)
	dec	hl
	dec	hl
	ld	(hl), a
	jr	00113$
00109$:
;src/states/inventory_state.c:94: strncpy(line_buffer, &desc[start], 15);
	ld	bc, #0x000f
	push	bc
	ld	c, e
	ld	b, d
	ld	hl, #2
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_strncpy
;src/states/inventory_state.c:95: line_buffer[15] = '\0';
	ldhl	sp,	#15
	ld	(hl), #0x00
;src/states/inventory_state.c:96: start += 15;
	ldhl	sp,	#24
	ld	a, (hl-)
	dec	hl
	add	a, #0x0f
	ld	(hl), a
00113$:
;src/states/inventory_state.c:99: text_print(3, 14 + line, line_buffer);
	ld	hl, #0
	add	hl, sp
	ld	c, l
	ld	b, h
	ldhl	sp,	#23
	ld	a, (hl)
	add	a, #0x0e
	push	bc
	ld	e, a
	ld	a, #0x03
	call	_text_print
;src/states/inventory_state.c:100: line++;
	ldhl	sp,	#23
	inc	(hl)
	jp	00115$
00120$:
;src/states/inventory_state.c:104: text_print(1, 17, "(B) VOLVER");
	ld	de, #___str_4
	push	de
	ld	e, #0x11
	ld	a, #0x01
	call	_text_print
;src/states/inventory_state.c:105: }
	add	sp, #25
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
;src/states/inventory_state.c:107: void inventory_state_init(void) {
;	---------------------------------
; Function inventory_state_init
; ---------------------------------
_inventory_state_init::
;src/states/inventory_state.c:108: DISPLAY_OFF;
	call	_display_off
;src/states/inventory_state.c:109: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;./gbdk/include/gb/gb.h:1461: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/states/inventory_state.c:113: text_init();
	call	_text_init
;src/states/inventory_state.c:115: selection = 0;
	xor	a, a
	ld	(#_selection),a
;src/states/inventory_state.c:116: inventory_draw();
	call	_inventory_draw
;src/states/inventory_state.c:118: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/states/inventory_state.c:119: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/inventory_state.c:120: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/inventory_state.c:121: }
	ret
;src/states/inventory_state.c:123: void inventory_state_update(void) {
;	---------------------------------
; Function inventory_state_update
; ---------------------------------
_inventory_state_update::
;src/states/inventory_state.c:124: if (inventory_count > 0) {
	ld	a, (#_inventory_count)
	or	a, a
	jr	Z, 00110$
;src/states/inventory_state.c:125: if (input_pressed(J_DOWN)) {
	ld	a, #0x08
	call	_input_pressed
	or	a, a
	jr	Z, 00104$
;src/states/inventory_state.c:126: if (selection < inventory_count - 1) {
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
;src/states/inventory_state.c:127: selection++;
	ld	hl, #_selection
	inc	(hl)
;src/states/inventory_state.c:128: inventory_draw();
	call	_inventory_draw
00104$:
;src/states/inventory_state.c:131: if (input_pressed(J_UP)) {
	ld	a, #0x04
	call	_input_pressed
	or	a, a
	jr	Z, 00110$
;src/states/inventory_state.c:132: if (selection > 0) {
	ld	hl, #_selection
	ld	a, (hl)
	or	a, a
	jr	Z, 00110$
;src/states/inventory_state.c:133: selection--;
	dec	(hl)
;src/states/inventory_state.c:134: inventory_draw();
	call	_inventory_draw
00110$:
;src/states/inventory_state.c:139: if (input_pressed(J_B)) {
	ld	a, #0x20
	call	_input_pressed
	or	a, a
	ret	Z
;src/states/inventory_state.c:140: game_state = STATE_GAME;
	ld	hl, #_game_state
	ld	(hl), #0x02
;src/states/inventory_state.c:142: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__selection:
	.db #0x00	; 0
	.area _CABS (ABS)
