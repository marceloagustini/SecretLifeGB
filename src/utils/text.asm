;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module text
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _wait_input_up
	.globl _wait_input
	.globl _text_wait
	.globl _clear_dialog_buf
	.globl _music_update
	.globl _fill_bkg_rect
	.globl _set_win_tiles
	.globl _set_win_data
	.globl _set_bkg_tile_xy
	.globl _wait_vbl_done
	.globl _joypad
	.globl _dialog_buf
	.globl _text_init
	.globl _get_tile_for_char
	.globl _text_dialogue
	.globl _text_print
	.globl _text_clear
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_dialog_buf::
	.ds 120
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
;src/utils/text.c:15: void text_init(void) {
;	---------------------------------
; Function text_init
; ---------------------------------
_text_init::
;src/utils/text.c:17: font_data); // Load enough tiles for the expanded font
;src/utils/text.c:16: set_win_data(FONT_BASE_TILE, 128,
	ld	de, #_font_data
	push	de
	ld	hl, #0x8080
	push	hl
	call	_set_win_data
	add	sp, #4
;./gbdk/include/gb/gb.h:1739: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x90
	ldh	(_WY_REG + 0), a
;src/utils/text.c:18: move_win(7, 144);
;src/utils/text.c:19: }
	ret
;src/utils/text.c:21: uint8_t get_tile_for_char(char c) {
;	---------------------------------
; Function get_tile_for_char
; ---------------------------------
_get_tile_for_char::
;src/utils/text.c:22: if (c == ' ' || c == '\n')
	ld	c, a
	sub	a, #0x20
	jr	Z, 00101$
	ld	a, c
	sub	a, #0x0a
	jr	NZ, 00102$
00101$:
;src/utils/text.c:23: return (uint8_t)(FONT_BASE_TILE + 0);
	ld	a, #0x80
	ret
00102$:
;src/utils/text.c:24: if (c >= 'A' && c <= 'Z')
	ld	a, c
	xor	a, #0x80
	sub	a, #0xc1
	jr	C, 00105$
	ld	e, c
	ld	a,#0x5a
	ld	d,a
	sub	a, c
	bit	7, e
	jr	Z, 00293$
	bit	7, d
	jr	NZ, 00294$
	cp	a, a
	jr	00294$
00293$:
	bit	7, d
	jr	Z, 00294$
	scf
00294$:
	jr	C, 00105$
;src/utils/text.c:25: return (uint8_t)(FONT_BASE_TILE + 1 + (c - 'A'));
	ld	a, c
	add	a, #0x40
	ret
00105$:
;src/utils/text.c:26: if (c >= 'a' && c <= 'z')
	ld	a, c
	xor	a, #0x80
	sub	a, #0xe1
	jr	C, 00108$
	ld	e, c
	ld	a,#0x7a
	ld	d,a
	sub	a, c
	bit	7, e
	jr	Z, 00295$
	bit	7, d
	jr	NZ, 00296$
	cp	a, a
	jr	00296$
00295$:
	bit	7, d
	jr	Z, 00296$
	scf
00296$:
	jr	C, 00108$
;src/utils/text.c:27: return (uint8_t)(FONT_BASE_TILE + 27 + (c - 'a'));
	ld	a, c
	add	a, #0x3a
	ret
00108$:
;src/utils/text.c:28: if (c == ',')
	ld	a, c
	sub	a, #0x2c
	jr	NZ, 00111$
;src/utils/text.c:29: return (uint8_t)(FONT_BASE_TILE + 53);
	ld	a, #0xb5
	ret
00111$:
;src/utils/text.c:30: if (c == '?')
	ld	a, c
	sub	a, #0x3f
	jr	NZ, 00113$
;src/utils/text.c:31: return (uint8_t)(FONT_BASE_TILE + 54);
	ld	a, #0xb6
	ret
00113$:
;src/utils/text.c:32: if (c == '!')
	ld	a, c
	sub	a, #0x21
	jr	NZ, 00115$
;src/utils/text.c:33: return (uint8_t)(FONT_BASE_TILE + 55);
	ld	a, #0xb7
	ret
00115$:
;src/utils/text.c:34: if (c == '*')
	ld	a, c
	sub	a, #0x2a
	jr	NZ, 00117$
;src/utils/text.c:35: return (uint8_t)(FONT_BASE_TILE + 56);
	ld	a, #0xb8
	ret
00117$:
;src/utils/text.c:36: if (c == '>')
	ld	a, c
	sub	a, #0x3e
	jr	NZ, 00119$
;src/utils/text.c:37: return (uint8_t)(FONT_BASE_TILE + 57);
	ld	a, #0xb9
	ret
00119$:
;src/utils/text.c:38: if (c == '.')
	ld	a, c
	sub	a, #0x2e
	jr	NZ, 00121$
;src/utils/text.c:39: return (uint8_t)(FONT_BASE_TILE + 58);
	ld	a, #0xba
	ret
00121$:
;src/utils/text.c:40: if (c == '#')
	ld	a, c
	sub	a, #0x23
	jr	NZ, 00123$
;src/utils/text.c:41: return (uint8_t)(FONT_BASE_TILE + 59);
	ld	a, #0xbb
	ret
00123$:
;src/utils/text.c:44: if (c == 1)
	ld	a, c
	dec	a
	jr	NZ, 00125$
;src/utils/text.c:45: return (uint8_t)(FONT_BASE_TILE + 60); // ┌
	ld	a, #0xbc
	ret
00125$:
;src/utils/text.c:46: if (c == 2)
	ld	a, c
	sub	a, #0x02
	jr	NZ, 00127$
;src/utils/text.c:47: return (uint8_t)(FONT_BASE_TILE + 61); // ─
	ld	a, #0xbd
	ret
00127$:
;src/utils/text.c:48: if (c == 3)
	ld	a, c
	sub	a, #0x03
	jr	NZ, 00129$
;src/utils/text.c:49: return (uint8_t)(FONT_BASE_TILE + 62); // ┐
	ld	a, #0xbe
	ret
00129$:
;src/utils/text.c:50: if (c == 4)
	ld	a, c
	sub	a, #0x04
	jr	NZ, 00131$
;src/utils/text.c:51: return (uint8_t)(FONT_BASE_TILE + 63); // │
	ld	a, #0xbf
	ret
00131$:
;src/utils/text.c:52: if (c == 5)
	ld	a, c
	sub	a, #0x05
	jr	NZ, 00133$
;src/utils/text.c:53: return (uint8_t)(FONT_BASE_TILE + 64); // └
	ld	a, #0xc0
	ret
00133$:
;src/utils/text.c:54: if (c == 6)
	ld	a, c
	sub	a, #0x06
	jr	NZ, 00135$
;src/utils/text.c:55: return (uint8_t)(FONT_BASE_TILE + 65); // ┘
	ld	a, #0xc1
	ret
00135$:
;src/utils/text.c:58: if (c >= '0' && c <= '9')
	ld	a, c
	xor	a, #0x80
	sub	a, #0xb0
	jr	C, 00137$
	ld	e, c
	ld	a,#0x39
	ld	d,a
	sub	a, c
	bit	7, e
	jr	Z, 00323$
	bit	7, d
	jr	NZ, 00324$
	cp	a, a
	jr	00324$
00323$:
	bit	7, d
	jr	Z, 00324$
	scf
00324$:
	jr	C, 00137$
;src/utils/text.c:59: return (uint8_t)(FONT_BASE_TILE + 66 + (c - '0'));
	ld	a, c
	add	a, #0x92
	ret
00137$:
;src/utils/text.c:61: if (c == ':')
	ld	a, c
	sub	a, #0x3a
;src/utils/text.c:62: return (uint8_t)(FONT_BASE_TILE + 76);
;src/utils/text.c:64: return (uint8_t)(FONT_BASE_TILE + 0);
	ld	a, #0xcc
	ret	Z
	ld	a, #0x80
;src/utils/text.c:65: }
	ret
;src/utils/text.c:69: void clear_dialog_buf(void) {
;	---------------------------------
; Function clear_dialog_buf
; ---------------------------------
_clear_dialog_buf::
;src/utils/text.c:70: for (int i = 0; i < 120; i++)
	ld	c, #0x00
00106$:
	ld	a, c
	sub	a, #0x78
	jr	NC, 00101$
;src/utils/text.c:71: dialog_buf[i] = (uint8_t)FONT_BASE_TILE;
	ld	hl, #_dialog_buf
	ld	b, #0x00
	add	hl, bc
	ld	(hl), #0x80
;src/utils/text.c:70: for (int i = 0; i < 120; i++)
	inc	c
	jr	00106$
00101$:
;src/utils/text.c:72: dialog_buf[0] = get_tile_for_char(1);
	ld	a, #0x01
	call	_get_tile_for_char
	ld	(#_dialog_buf),a
;src/utils/text.c:73: for (int i = 1; i < 19; i++)
	ld	c, #0x01
00109$:
	ld	a, c
	sub	a, #0x13
	jr	NC, 00102$
;src/utils/text.c:74: dialog_buf[i] = get_tile_for_char(2);
	ld	hl, #_dialog_buf
	ld	b, #0x00
	add	hl, bc
	push	hl
	push	bc
	ld	a, #0x02
	call	_get_tile_for_char
	pop	bc
	pop	hl
	ld	(hl), a
;src/utils/text.c:73: for (int i = 1; i < 19; i++)
	inc	c
	jr	00109$
00102$:
;src/utils/text.c:75: dialog_buf[19] = get_tile_for_char(3);
	ld	a, #0x03
	call	_get_tile_for_char
	ld	(#(_dialog_buf + 19)),a
;src/utils/text.c:76: for (int y = 1; y < 5; y++) {
	ld	c, #0x01
00112$:
;src/utils/text.c:77: dialog_buf[y * 20] = get_tile_for_char(4);
	ld	a,c
	cp	a,#0x05
	jr	NC, 00103$
	ld	e, a
	add	a, a
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	ld	b, a
	ld	l, b
	ld	h, #0x00
	ld	de, #_dialog_buf
	add	hl, de
	push	hl
	push	bc
	ld	a, #0x04
	call	_get_tile_for_char
	pop	bc
	pop	hl
	ld	(hl), a
;src/utils/text.c:78: dialog_buf[y * 20 + 19] = get_tile_for_char(4);
	ld	a, b
	add	a, #0x13
	ld	l, a
	ld	h, #0x00
	ld	de, #_dialog_buf
	add	hl, de
	push	hl
	push	bc
	ld	a, #0x04
	call	_get_tile_for_char
	pop	bc
	pop	hl
	ld	(hl), a
;src/utils/text.c:76: for (int y = 1; y < 5; y++) {
	inc	c
	jr	00112$
00103$:
;src/utils/text.c:80: dialog_buf[100] = get_tile_for_char(5);
	ld	a, #0x05
	call	_get_tile_for_char
	ld	(#(_dialog_buf + 100)),a
;src/utils/text.c:81: for (int i = 101; i < 119; i++)
	ld	c, #0x65
00115$:
	ld	a, c
	sub	a, #0x77
	jr	NC, 00104$
;src/utils/text.c:82: dialog_buf[i] = get_tile_for_char(2);
	ld	hl, #_dialog_buf
	ld	b, #0x00
	add	hl, bc
	push	hl
	push	bc
	ld	a, #0x02
	call	_get_tile_for_char
	pop	bc
	pop	hl
	ld	(hl), a
;src/utils/text.c:81: for (int i = 101; i < 119; i++)
	inc	c
	jr	00115$
00104$:
;src/utils/text.c:83: dialog_buf[119] = get_tile_for_char(6);
	ld	a, #0x06
	call	_get_tile_for_char
	ld	(#(_dialog_buf + 119)),a
;src/utils/text.c:84: }
	ret
;src/utils/text.c:86: void text_wait(uint8_t delay_vbl) {
;	---------------------------------
; Function text_wait
; ---------------------------------
_text_wait::
	ld	c, a
;src/utils/text.c:87: for (uint8_t i = 0; i < delay_vbl; i++) {
	ld	b, #0x00
00103$:
	ld	a, b
	sub	a, c
	ret	NC
;src/utils/text.c:88: wait_vbl_done();
	call	_wait_vbl_done
;src/utils/text.c:89: music_update();
	push	bc
	call	_music_update
	pop	bc
;src/utils/text.c:87: for (uint8_t i = 0; i < delay_vbl; i++) {
	inc	b
;src/utils/text.c:91: }
	jr	00103$
;src/utils/text.c:93: void wait_input(uint8_t btn) {
;	---------------------------------
; Function wait_input
; ---------------------------------
_wait_input::
	ld	c, a
;src/utils/text.c:94: while (!(joypad() & btn)) {
00101$:
	call	_joypad
	and	a, c
	ret	NZ
;src/utils/text.c:95: wait_vbl_done();
	call	_wait_vbl_done
;src/utils/text.c:96: music_update();
	push	bc
	call	_music_update
	pop	bc
;src/utils/text.c:98: }
	jr	00101$
;src/utils/text.c:100: void wait_input_up(void) {
;	---------------------------------
; Function wait_input_up
; ---------------------------------
_wait_input_up::
;src/utils/text.c:101: while (joypad() != 0) {
00101$:
	call	_joypad
	or	a, a
	ret	Z
;src/utils/text.c:102: wait_vbl_done();
	call	_wait_vbl_done
;src/utils/text.c:103: music_update();
	call	_music_update
;src/utils/text.c:105: }
	jr	00101$
;src/utils/text.c:107: void text_dialogue(const char *str) {
;	---------------------------------
; Function text_dialogue
; ---------------------------------
_text_dialogue::
	add	sp, #-19
	ldhl	sp,	#11
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/utils/text.c:108: wait_input_up();
	call	_wait_input_up
;src/utils/text.c:110: for (int i = 0; i < 40; i++)
	ld	bc, #0x0000
00129$:
	ld	a, c
	sub	a, #0x28
	jr	NC, 00101$
;src/utils/text.c:111: move_sprite(i, 0, 0);
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, c
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/utils/text.c:110: for (int i = 0; i < 40; i++)
	inc	bc
	jr	00129$
00101$:
;src/utils/text.c:112: const char *ptr = str;
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#18
	ld	(hl), a
;src/utils/text.c:113: while (*ptr != '\0') {
00122$:
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	Z, 00124$
;src/utils/text.c:114: clear_dialog_buf();
	call	_clear_dialog_buf
;src/utils/text.c:115: int cur_line = 0, cur_col = 0;
	xor	a, a
	ldhl	sp,	#13
	ld	(hl+), a
	ld	(hl), a
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
;src/utils/text.c:116: while (*ptr != '\0' && cur_line < TEXT_LINES) {
00119$:
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	Z, 00121$
	ldhl	sp,	#13
	ld	a, (hl+)
	sub	a, #0x04
	ld	a, (hl)
	sbc	a, #0x00
	jp	NC, 00121$
;src/utils/text.c:119: while (*word_end != '\0' && *word_end != ' ' && *word_end != '\n') {
	ld	bc, #0x0000
	ldhl	sp,	#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00104$:
	ld	a, (de)
	or	a, a
	jr	Z, 00153$
	cp	a, #0x20
	jr	Z, 00153$
	sub	a, #0x0a
	jr	Z, 00153$
;src/utils/text.c:120: word_len++;
	inc	bc
;src/utils/text.c:121: word_end++;
	inc	de
	jr	00104$
00153$:
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/utils/text.c:123: if (cur_col + word_len > TEXT_WIDTH) {
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	e, b
	ld	d, #0x00
	ld	a, #0x12
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00253$
	bit	7, d
	jr	NZ, 00254$
	cp	a, a
	jr	00254$
00253$:
	bit	7, d
	jr	Z, 00254$
	scf
00254$:
	jr	NC, 00147$
;src/utils/text.c:124: cur_line++;
	ldhl	sp,	#13
	inc	(hl)
;src/utils/text.c:125: cur_col = 0;
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
;src/utils/text.c:126: if (cur_line >= TEXT_LINES)
	ldhl	sp,	#13
	ld	a, (hl+)
	sub	a, #0x04
	ld	a, (hl)
	sbc	a, #0x00
	jp	NC, 00121$
;src/utils/text.c:129: for (int i = 0; i < word_len; i++) {
00147$:
;src/utils/text.c:124: cur_line++;
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
;src/utils/text.c:129: for (int i = 0; i < word_len; i++) {
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#18
	ld	a, (hl-)
	dec	hl
	ld	(hl+), a
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00132$:
;src/utils/text.c:130: int pos = (cur_line + 1) * 20 + (cur_col + 1);
	pop	de
	push	de
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
;src/utils/text.c:131: dialog_buf[pos] = get_tile_for_char(*ptr);
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl), a
;src/utils/text.c:129: for (int i = 0; i < word_len; i++) {
	ldhl	sp,	#17
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00256$
	bit	7, d
	jr	NZ, 00257$
	cp	a, a
	jr	00257$
00256$:
	bit	7, d
	jr	Z, 00257$
	scf
00257$:
	jr	NC, 00154$
;src/utils/text.c:130: int pos = (cur_line + 1) * 20 + (cur_col + 1);
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
;src/utils/text.c:131: dialog_buf[pos] = get_tile_for_char(*ptr);
	ld	bc, #_dialog_buf
	add	hl, bc
	push	hl
	ldhl	sp,	#12
	ld	a, (hl)
	call	_get_tile_for_char
	pop	bc
	ld	(bc), a
;src/utils/text.c:132: ptr++;
	ldhl	sp,	#15
	inc	(hl)
	jr	NZ, 00258$
	inc	hl
	inc	(hl)
00258$:
;src/utils/text.c:133: cur_col++;
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;src/utils/text.c:129: for (int i = 0; i < word_len; i++) {
	ldhl	sp,	#17
	inc	(hl)
	jr	NZ, 00132$
	inc	hl
	inc	(hl)
	jr	00132$
00154$:
	ldhl	sp,	#15
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
;src/utils/text.c:135: if (*ptr == ' ' || *ptr == '\n') {
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x20
	jr	Z, 00115$
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x0a
	jp	NZ, 00119$
00115$:
;src/utils/text.c:136: if (*ptr == '\n') {
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x0a
	jr	NZ, 00113$
;src/utils/text.c:137: cur_line++;
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl+), a
	ld	(hl), #0x00
;src/utils/text.c:138: cur_col = 0;
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
	jr	00114$
00113$:
;src/utils/text.c:140: cur_col++;
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
00114$:
;src/utils/text.c:142: ptr++;
	ldhl	sp,	#17
	inc	(hl)
	jp	NZ, 00119$
	inc	hl
	inc	(hl)
	jp	00119$
00121$:
;src/utils/text.c:145: set_win_tiles(0, 0, 20, 6, dialog_buf);
	ld	de, #_dialog_buf
	push	de
	ld	hl, #0x614
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_win_tiles
	add	sp, #6
;./gbdk/include/gb/gb.h:1739: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x60
	ldh	(_WY_REG + 0), a
;src/utils/text.c:147: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;src/utils/text.c:148: wait_input(J_A);
	ld	a, #0x10
	call	_wait_input
;src/utils/text.c:149: text_wait(6);
	ld	a, #0x06
	call	_text_wait
;src/utils/text.c:150: wait_input_up();
	call	_wait_input_up
	jp	00122$
00124$:
;src/utils/text.c:152: HIDE_WIN;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
;./gbdk/include/gb/gb.h:1739: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x90
	ldh	(_WY_REG + 0), a
;src/utils/text.c:153: move_win(7, 144);
;src/utils/text.c:154: }
	add	sp, #19
	ret
;src/utils/text.c:156: void text_print(uint8_t x, uint8_t y, const char *str) {
;	---------------------------------
; Function text_print
; ---------------------------------
_text_print::
	dec	sp
	dec	sp
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), e
;src/utils/text.c:157: for (int i = 0; str[i] != '\0'; i++) {
	ld	bc, #0x0000
00103$:
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	or	a, a
	jr	Z, 00105$
;src/utils/text.c:158: set_bkg_tile_xy(x + i, y, get_tile_for_char(str[i]));
	push	bc
	call	_get_tile_for_char
	ld	d, a
	pop	bc
	ld	a, c
	ldhl	sp,	#1
	ld	e, (hl)
	dec	hl
	add	a, e
	push	bc
	push	de
	inc	sp
	ld	e, (hl)
	call	_set_bkg_tile_xy
	pop	bc
;src/utils/text.c:157: for (int i = 0; str[i] != '\0'; i++) {
	inc	bc
	jr	00103$
00105$:
;src/utils/text.c:160: }
	inc	sp
	inc	sp
	pop	hl
	pop	af
	jp	(hl)
;src/utils/text.c:162: void text_clear(void) { fill_bkg_rect(0, 0, 20, 18, get_tile_for_char(' ')); }
;	---------------------------------
; Function text_clear
; ---------------------------------
_text_clear::
	ld	a, #0x20
	call	_get_tile_for_char
	ld	h, a
	ld	l, #0x12
	push	hl
	ld	a, #0x14
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
