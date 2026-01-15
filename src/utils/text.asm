;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module text
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _clear_dialog_buf
	.globl _fill_bkg_rect
	.globl _set_win_tiles
	.globl _set_win_data
	.globl _set_bkg_tile_xy
	.globl _waitpadup
	.globl _waitpad
	.globl _delay
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
;src/utils/text.c:14: void text_init(void) {
;	---------------------------------
; Function text_init
; ---------------------------------
_text_init::
;src/utils/text.c:16: font_data); // Load 50 tiles
;src/utils/text.c:15: set_win_data(FONT_BASE_TILE, 50,
	ld	de, #_font_data
	push	de
	ld	hl, #0x3280
	push	hl
	call	_set_win_data
	add	sp, #4
;./gbdk/include/gb/gb.h:1739: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x90
	ldh	(_WY_REG + 0), a
;src/utils/text.c:17: move_win(7, 144);
;src/utils/text.c:18: }
	ret
;src/utils/text.c:20: uint8_t get_tile_for_char(char c) {
;	---------------------------------
; Function get_tile_for_char
; ---------------------------------
_get_tile_for_char::
;src/utils/text.c:21: if (c == ' ' || c == '\n')
	ld	c, a
	sub	a, #0x20
	jr	Z, 00101$
	ld	a, c
	sub	a, #0x0a
	jr	NZ, 00102$
00101$:
;src/utils/text.c:22: return (uint8_t)(FONT_BASE_TILE + 0);
	ld	a, #0x80
	ret
00102$:
;src/utils/text.c:23: if (c >= 'A' && c <= 'Z')
	ld	a, c
	xor	a, #0x80
	sub	a, #0xc1
	jr	C, 00105$
	ld	e, c
	ld	a,#0x5a
	ld	d,a
	sub	a, c
	bit	7, e
	jr	Z, 00284$
	bit	7, d
	jr	NZ, 00285$
	cp	a, a
	jr	00285$
00284$:
	bit	7, d
	jr	Z, 00285$
	scf
00285$:
	jr	C, 00105$
;src/utils/text.c:24: return (uint8_t)(FONT_BASE_TILE + 1 + (c - 'A'));
	ld	a, c
	add	a, #0x40
	ret
00105$:
;src/utils/text.c:25: if (c >= 'a' && c <= 'z')
	ld	a, c
	xor	a, #0x80
	sub	a, #0xe1
	jr	C, 00108$
	ld	e, c
	ld	a,#0x7a
	ld	d,a
	sub	a, c
	bit	7, e
	jr	Z, 00286$
	bit	7, d
	jr	NZ, 00287$
	cp	a, a
	jr	00287$
00286$:
	bit	7, d
	jr	Z, 00287$
	scf
00287$:
	jr	C, 00108$
;src/utils/text.c:27: (c - 'a')); // Map lowercase to uppercase
	ld	a, c
	add	a, #0x20
	ret
00108$:
;src/utils/text.c:28: if (c == ',')
	ld	a, c
	sub	a, #0x2c
	jr	NZ, 00111$
;src/utils/text.c:29: return (uint8_t)(FONT_BASE_TILE + 27);
	ld	a, #0x9b
	ret
00111$:
;src/utils/text.c:30: if (c == '?')
	ld	a, c
	sub	a, #0x3f
	jr	NZ, 00113$
;src/utils/text.c:31: return (uint8_t)(FONT_BASE_TILE + 28);
	ld	a, #0x9c
	ret
00113$:
;src/utils/text.c:32: if (c == '!')
	ld	a, c
	sub	a, #0x21
	jr	NZ, 00115$
;src/utils/text.c:33: return (uint8_t)(FONT_BASE_TILE + 29);
	ld	a, #0x9d
	ret
00115$:
;src/utils/text.c:34: if (c == '.')
	ld	a, c
	sub	a, #0x2e
	jr	NZ, 00117$
;src/utils/text.c:35: return (uint8_t)(FONT_BASE_TILE + 30);
	ld	a, #0x9e
	ret
00117$:
;src/utils/text.c:36: if (c == '>')
	ld	a, c
	sub	a, #0x3e
	jr	NZ, 00119$
;src/utils/text.c:37: return (uint8_t)(FONT_BASE_TILE + 31);
	ld	a, #0x9f
	ret
00119$:
;src/utils/text.c:38: if (c == '#')
	ld	a, c
	sub	a, #0x23
	jr	NZ, 00121$
;src/utils/text.c:39: return (uint8_t)(FONT_BASE_TILE + 32);
	ld	a, #0xa0
	ret
00121$:
;src/utils/text.c:42: if (c == 1)
	ld	a, c
	dec	a
	jr	NZ, 00123$
;src/utils/text.c:43: return (uint8_t)(FONT_BASE_TILE + 33); // ┌
	ld	a, #0xa1
	ret
00123$:
;src/utils/text.c:44: if (c == 2)
	ld	a, c
	sub	a, #0x02
	jr	NZ, 00125$
;src/utils/text.c:45: return (uint8_t)(FONT_BASE_TILE + 34); // ─
	ld	a, #0xa2
	ret
00125$:
;src/utils/text.c:46: if (c == 3)
	ld	a, c
	sub	a, #0x03
	jr	NZ, 00127$
;src/utils/text.c:47: return (uint8_t)(FONT_BASE_TILE + 35); // ┐
	ld	a, #0xa3
	ret
00127$:
;src/utils/text.c:48: if (c == 4)
	ld	a, c
	sub	a, #0x04
	jr	NZ, 00129$
;src/utils/text.c:49: return (uint8_t)(FONT_BASE_TILE + 36); // │
	ld	a, #0xa4
	ret
00129$:
;src/utils/text.c:50: if (c == 5)
	ld	a, c
	sub	a, #0x05
	jr	NZ, 00131$
;src/utils/text.c:51: return (uint8_t)(FONT_BASE_TILE + 37); // └
	ld	a, #0xa5
	ret
00131$:
;src/utils/text.c:52: if (c == 6)
	ld	a, c
	sub	a, #0x06
	jr	NZ, 00133$
;src/utils/text.c:53: return (uint8_t)(FONT_BASE_TILE + 38); // ┘
	ld	a, #0xa6
	ret
00133$:
;src/utils/text.c:56: if (c >= '0' && c <= '9')
	ld	a, c
	xor	a, #0x80
	sub	a, #0xb0
	jr	C, 00135$
	ld	e, c
	ld	a,#0x39
	ld	d,a
	sub	a, c
	bit	7, e
	jr	Z, 00312$
	bit	7, d
	jr	NZ, 00313$
	cp	a, a
	jr	00313$
00312$:
	bit	7, d
	jr	Z, 00313$
	scf
00313$:
	jr	C, 00135$
;src/utils/text.c:57: return (uint8_t)(FONT_BASE_TILE + 39 + (c - '0'));
	ld	a, c
	add	a, #0x77
	ret
00135$:
;src/utils/text.c:59: if (c == ':')
	ld	a, c
	sub	a, #0x3a
;src/utils/text.c:60: return (uint8_t)(FONT_BASE_TILE + 49);
;src/utils/text.c:62: return (uint8_t)(FONT_BASE_TILE + 0);
	ld	a, #0xb1
	ret	Z
	ld	a, #0x80
;src/utils/text.c:63: }
	ret
;src/utils/text.c:67: void clear_dialog_buf(void) {
;	---------------------------------
; Function clear_dialog_buf
; ---------------------------------
_clear_dialog_buf::
;src/utils/text.c:68: for (int i = 0; i < 120; i++)
	ld	c, #0x00
00106$:
	ld	a, c
	sub	a, #0x78
	jr	NC, 00101$
;src/utils/text.c:69: dialog_buf[i] = (uint8_t)FONT_BASE_TILE;
	ld	hl, #_dialog_buf
	ld	b, #0x00
	add	hl, bc
	ld	(hl), #0x80
;src/utils/text.c:68: for (int i = 0; i < 120; i++)
	inc	c
	jr	00106$
00101$:
;src/utils/text.c:70: dialog_buf[0] = get_tile_for_char(1);
	ld	a, #0x01
	call	_get_tile_for_char
	ld	(#_dialog_buf),a
;src/utils/text.c:71: for (int i = 1; i < 19; i++)
	ld	c, #0x01
00109$:
	ld	a, c
	sub	a, #0x13
	jr	NC, 00102$
;src/utils/text.c:72: dialog_buf[i] = get_tile_for_char(2);
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
;src/utils/text.c:71: for (int i = 1; i < 19; i++)
	inc	c
	jr	00109$
00102$:
;src/utils/text.c:73: dialog_buf[19] = get_tile_for_char(3);
	ld	a, #0x03
	call	_get_tile_for_char
	ld	(#(_dialog_buf + 19)),a
;src/utils/text.c:74: for (int y = 1; y < 5; y++) {
	ld	c, #0x01
00112$:
;src/utils/text.c:75: dialog_buf[y * 20] = get_tile_for_char(4);
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
;src/utils/text.c:76: dialog_buf[y * 20 + 19] = get_tile_for_char(4);
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
;src/utils/text.c:74: for (int y = 1; y < 5; y++) {
	inc	c
	jr	00112$
00103$:
;src/utils/text.c:78: dialog_buf[100] = get_tile_for_char(5);
	ld	a, #0x05
	call	_get_tile_for_char
	ld	(#(_dialog_buf + 100)),a
;src/utils/text.c:79: for (int i = 101; i < 119; i++)
	ld	c, #0x65
00115$:
	ld	a, c
	sub	a, #0x77
	jr	NC, 00104$
;src/utils/text.c:80: dialog_buf[i] = get_tile_for_char(2);
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
;src/utils/text.c:79: for (int i = 101; i < 119; i++)
	inc	c
	jr	00115$
00104$:
;src/utils/text.c:81: dialog_buf[119] = get_tile_for_char(6);
	ld	a, #0x06
	call	_get_tile_for_char
	ld	(#(_dialog_buf + 119)),a
;src/utils/text.c:82: }
	ret
;src/utils/text.c:84: void text_dialogue(const char *str) {
;	---------------------------------
; Function text_dialogue
; ---------------------------------
_text_dialogue::
	add	sp, #-19
	ldhl	sp,	#11
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/utils/text.c:85: waitpadup();
	call	_waitpadup
;src/utils/text.c:87: for (int i = 0; i < 40; i++)
	ld	bc, #0x0000
00129$:
	ld	a, c
	sub	a, #0x28
	jr	NC, 00101$
;src/utils/text.c:88: move_sprite(i, 0, 0);
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
;src/utils/text.c:87: for (int i = 0; i < 40; i++)
	inc	bc
	jr	00129$
00101$:
;src/utils/text.c:89: const char *ptr = str;
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#17
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#18
	ld	(hl), a
;src/utils/text.c:90: while (*ptr != '\0') {
00122$:
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	Z, 00124$
;src/utils/text.c:91: clear_dialog_buf();
	call	_clear_dialog_buf
;src/utils/text.c:92: int cur_line = 0, cur_col = 0;
	xor	a, a
	ldhl	sp,	#13
	ld	(hl+), a
	ld	(hl), a
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
;src/utils/text.c:93: while (*ptr != '\0' && cur_line < TEXT_LINES) {
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
;src/utils/text.c:96: while (*word_end != '\0' && *word_end != ' ' && *word_end != '\n') {
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
;src/utils/text.c:97: word_len++;
	inc	bc
;src/utils/text.c:98: word_end++;
	inc	de
	jr	00104$
00153$:
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/utils/text.c:100: if (cur_col + word_len > TEXT_WIDTH) {
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
;src/utils/text.c:101: cur_line++;
	ldhl	sp,	#13
	inc	(hl)
;src/utils/text.c:102: cur_col = 0;
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
;src/utils/text.c:103: if (cur_line >= TEXT_LINES)
	ldhl	sp,	#13
	ld	a, (hl+)
	sub	a, #0x04
	ld	a, (hl)
	sbc	a, #0x00
	jp	NC, 00121$
;src/utils/text.c:106: for (int i = 0; i < word_len; i++) {
00147$:
;src/utils/text.c:101: cur_line++;
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
;src/utils/text.c:106: for (int i = 0; i < word_len; i++) {
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
;src/utils/text.c:107: int pos = (cur_line + 1) * 20 + (cur_col + 1);
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
;src/utils/text.c:108: dialog_buf[pos] = get_tile_for_char(*ptr);
	ldhl	sp,#15
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl), a
;src/utils/text.c:106: for (int i = 0; i < word_len; i++) {
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
;src/utils/text.c:107: int pos = (cur_line + 1) * 20 + (cur_col + 1);
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
;src/utils/text.c:108: dialog_buf[pos] = get_tile_for_char(*ptr);
	ld	bc, #_dialog_buf
	add	hl, bc
	push	hl
	ldhl	sp,	#12
	ld	a, (hl)
	call	_get_tile_for_char
	pop	bc
	ld	(bc), a
;src/utils/text.c:109: ptr++;
	ldhl	sp,	#15
	inc	(hl)
	jr	NZ, 00258$
	inc	hl
	inc	(hl)
00258$:
;src/utils/text.c:110: cur_col++;
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;src/utils/text.c:106: for (int i = 0; i < word_len; i++) {
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
;src/utils/text.c:112: if (*ptr == ' ' || *ptr == '\n') {
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x20
	jr	Z, 00115$
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x0a
	jp	NZ, 00119$
00115$:
;src/utils/text.c:113: if (*ptr == '\n') {
	ldhl	sp,#17
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x0a
	jr	NZ, 00113$
;src/utils/text.c:114: cur_line++;
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl+), a
	ld	(hl), #0x00
;src/utils/text.c:115: cur_col = 0;
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
	jr	00114$
00113$:
;src/utils/text.c:117: cur_col++;
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
00114$:
;src/utils/text.c:119: ptr++;
	ldhl	sp,	#17
	inc	(hl)
	jp	NZ, 00119$
	inc	hl
	inc	(hl)
	jp	00119$
00121$:
;src/utils/text.c:122: set_win_tiles(0, 0, 20, 6, dialog_buf);
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
;src/utils/text.c:124: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;src/utils/text.c:125: waitpad(J_A);
	ld	a, #0x10
	call	_waitpad
;src/utils/text.c:126: delay(100);
	ld	de, #0x0064
	call	_delay
;src/utils/text.c:127: waitpadup();
	call	_waitpadup
	jp	00122$
00124$:
;src/utils/text.c:129: HIDE_WIN;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
;./gbdk/include/gb/gb.h:1739: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x90
	ldh	(_WY_REG + 0), a
;src/utils/text.c:130: move_win(7, 144);
;src/utils/text.c:131: }
	add	sp, #19
	ret
;src/utils/text.c:133: void text_print(uint8_t x, uint8_t y, const char *str) {
;	---------------------------------
; Function text_print
; ---------------------------------
_text_print::
	dec	sp
	dec	sp
	ldhl	sp,	#1
	ld	(hl-), a
	ld	(hl), e
;src/utils/text.c:134: for (int i = 0; str[i] != '\0'; i++) {
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
;src/utils/text.c:135: set_bkg_tile_xy(x + i, y, get_tile_for_char(str[i]));
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
;src/utils/text.c:134: for (int i = 0; str[i] != '\0'; i++) {
	inc	bc
	jr	00103$
00105$:
;src/utils/text.c:137: }
	inc	sp
	inc	sp
	pop	hl
	pop	af
	jp	(hl)
;src/utils/text.c:139: void text_clear(void) { fill_bkg_rect(0, 0, 20, 18, get_tile_for_char(' ')); }
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
