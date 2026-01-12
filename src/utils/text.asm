;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module text
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _get_tile_for_char
	.globl _set_win_tiles
	.globl _set_win_data
	.globl _waitpadup
	.globl _waitpad
	.globl _delay
	.globl _dialog_buf
	.globl _text_init
	.globl _text_dialogue
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_dialog_buf::
	.ds 80
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
;src/utils/text.c:9: void text_init(void) {
;	---------------------------------
; Function text_init
; ---------------------------------
_text_init::
;src/utils/text.c:11: set_win_data(FONT_BASE_TILE, 35, font_data);
	ld	de, #_font_data
	push	de
	ld	hl, #0x2380
	push	hl
	call	_set_win_data
	add	sp, #4
;./gbdk/include/gb/gb.h:1739: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x90
	ldh	(_WY_REG + 0), a
;src/utils/text.c:14: move_win(7, 144);
;src/utils/text.c:15: }
	ret
;src/utils/text.c:18: uint8_t get_tile_for_char(char c) {
;	---------------------------------
; Function get_tile_for_char
; ---------------------------------
_get_tile_for_char::
;src/utils/text.c:20: if (c == ' ')
	ld	c, a
	sub	a, #0x20
	jr	NZ, 00102$
;src/utils/text.c:21: return (uint8_t)(FONT_BASE_TILE + 0);
	ld	a, #0x80
	ret
00102$:
;src/utils/text.c:22: if (c >= 'A' && c <= 'Z')
	ld	a, c
	xor	a, #0x80
	sub	a, #0xc1
	jr	C, 00104$
	ld	e, c
	ld	a,#0x5a
	ld	d,a
	sub	a, c
	bit	7, e
	jr	Z, 00203$
	bit	7, d
	jr	NZ, 00204$
	cp	a, a
	jr	00204$
00203$:
	bit	7, d
	jr	Z, 00204$
	scf
00204$:
	jr	C, 00104$
;src/utils/text.c:23: return (uint8_t)(FONT_BASE_TILE + 1 + (c - 'A'));
	ld	a, c
	add	a, #0x40
	ret
00104$:
;src/utils/text.c:24: if (c == ',')
	ld	a, c
	sub	a, #0x2c
	jr	NZ, 00107$
;src/utils/text.c:25: return (uint8_t)(FONT_BASE_TILE + 27);
	ld	a, #0x9b
	ret
00107$:
;src/utils/text.c:26: if (c == '?')
	ld	a, c
	sub	a, #0x3f
	jr	NZ, 00109$
;src/utils/text.c:27: return (uint8_t)(FONT_BASE_TILE + 28);
	ld	a, #0x9c
	ret
00109$:
;src/utils/text.c:30: if (c == 1)
	ld	a, c
	dec	a
	jr	NZ, 00111$
;src/utils/text.c:31: return (uint8_t)(FONT_BASE_TILE + 29); // ┌
	ld	a, #0x9d
	ret
00111$:
;src/utils/text.c:32: if (c == 2)
	ld	a, c
	sub	a, #0x02
	jr	NZ, 00113$
;src/utils/text.c:33: return (uint8_t)(FONT_BASE_TILE + 30); // ─
	ld	a, #0x9e
	ret
00113$:
;src/utils/text.c:34: if (c == 3)
	ld	a, c
	sub	a, #0x03
	jr	NZ, 00115$
;src/utils/text.c:35: return (uint8_t)(FONT_BASE_TILE + 31); // ┐
	ld	a, #0x9f
	ret
00115$:
;src/utils/text.c:36: if (c == 4)
	ld	a, c
	sub	a, #0x04
	jr	NZ, 00117$
;src/utils/text.c:37: return (uint8_t)(FONT_BASE_TILE + 32); // │
	ld	a, #0xa0
	ret
00117$:
;src/utils/text.c:38: if (c == 5)
	ld	a, c
	sub	a, #0x05
	jr	NZ, 00119$
;src/utils/text.c:39: return (uint8_t)(FONT_BASE_TILE + 33); // └
	ld	a, #0xa1
	ret
00119$:
;src/utils/text.c:40: if (c == 6)
	ld	a, c
	sub	a, #0x06
;src/utils/text.c:41: return (uint8_t)(FONT_BASE_TILE + 34); // ┘
;src/utils/text.c:43: return (uint8_t)(FONT_BASE_TILE + 0);
	ld	a, #0xa2
	ret	Z
	ld	a, #0x80
;src/utils/text.c:44: }
	ret
;src/utils/text.c:48: void text_dialogue(const char *str) {
;	---------------------------------
; Function text_dialogue
; ---------------------------------
_text_dialogue::
	add	sp, #-7
;src/utils/text.c:51: waitpadup();
	call	_waitpadup
;src/utils/text.c:53: const char *ptr = str;
	ldhl	sp,	#1
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/utils/text.c:55: while (*ptr != '\0') {
00116$:
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	Z, 00118$
;src/utils/text.c:57: for (int i = 0; i < 80; i++)
	ld	c, #0x00
00122$:
	ld	a, c
	sub	a, #0x50
	jr	NC, 00101$
;src/utils/text.c:58: dialog_buf[i] = (uint8_t)FONT_BASE_TILE;
	ld	hl, #_dialog_buf
	ld	b, #0x00
	add	hl, bc
	ld	(hl), #0x80
;src/utils/text.c:57: for (int i = 0; i < 80; i++)
	inc	c
	jr	00122$
00101$:
;src/utils/text.c:61: dialog_buf[0] = get_tile_for_char(1);
	ld	a, #0x01
	call	_get_tile_for_char
	ld	(#_dialog_buf),a
;src/utils/text.c:62: for (int i = 1; i < 19; i++)
	ldhl	sp,	#6
	ld	(hl), #0x01
00125$:
	ldhl	sp,	#6
	ld	a, (hl)
	sub	a, #0x13
	jr	NC, 00102$
;src/utils/text.c:63: dialog_buf[i] = get_tile_for_char(2);
	ld	de, #_dialog_buf
	ld	l, (hl)
	ld	h, #0x00
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, #0x02
	call	_get_tile_for_char
	ldhl	sp,	#4
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/utils/text.c:62: for (int i = 1; i < 19; i++)
	ldhl	sp,	#6
	inc	(hl)
	jr	00125$
00102$:
;src/utils/text.c:64: dialog_buf[19] = get_tile_for_char(3);
	ld	a, #0x03
	call	_get_tile_for_char
	ld	(#(_dialog_buf + 19)),a
;src/utils/text.c:66: dialog_buf[20] = get_tile_for_char(4);
	ld	a, #0x04
	call	_get_tile_for_char
	ld	(#(_dialog_buf + 20)),a
;src/utils/text.c:67: dialog_buf[39] = get_tile_for_char(4);
	ld	a, #0x04
	call	_get_tile_for_char
	ld	(#(_dialog_buf + 39)),a
;src/utils/text.c:68: dialog_buf[40] = get_tile_for_char(4);
	ld	a, #0x04
	call	_get_tile_for_char
	ld	(#(_dialog_buf + 40)),a
;src/utils/text.c:69: dialog_buf[59] = get_tile_for_char(4);
	ld	a, #0x04
	call	_get_tile_for_char
	ld	(#(_dialog_buf + 59)),a
;src/utils/text.c:71: dialog_buf[60] = get_tile_for_char(5);
	ld	a, #0x05
	call	_get_tile_for_char
	ld	(#(_dialog_buf + 60)),a
;src/utils/text.c:72: for (int i = 61; i < 79; i++)
	ld	c, #0x3d
00128$:
	ld	a, c
	sub	a, #0x4f
	jr	NC, 00103$
;src/utils/text.c:73: dialog_buf[i] = get_tile_for_char(2);
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
;src/utils/text.c:72: for (int i = 61; i < 79; i++)
	inc	c
	jr	00128$
00103$:
;src/utils/text.c:74: dialog_buf[79] = get_tile_for_char(6);
	ld	a, #0x06
	call	_get_tile_for_char
	ld	(#(_dialog_buf + 79)),a
;src/utils/text.c:78: int col = 0;
	ldhl	sp,	#3
;src/utils/text.c:80: while (*ptr != '\0' && count < 32) {
	xor	a, a
	ld	(hl+), a
	ld	bc, #0x0000
	ld	(hl), c
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
00113$:
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00115$
	ld	a, c
	sub	a, #0x20
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00115$
;src/utils/text.c:81: if (*ptr == ',') {
	ld	a, (hl)
	sub	a, #0x2c
	jr	NZ, 00107$
;src/utils/text.c:82: ptr++;
	ldhl	sp,	#1
	inc	(hl)
	jr	NZ, 00244$
	inc	hl
	inc	(hl)
00244$:
;src/utils/text.c:83: if (*ptr == ' ')
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x20
	jr	NZ, 00115$
;src/utils/text.c:84: ptr++;
	dec	hl
	inc	(hl)
	jr	NZ, 00115$
	inc	hl
	inc	(hl)
;src/utils/text.c:85: break;
	jr	00115$
00107$:
;src/utils/text.c:88: int pos = (line == 0) ? (22 + col) : (42 + col);
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	NZ, 00132$
	dec	hl
	ld	a, (hl)
	add	a, #0x16
	jr	00133$
00132$:
	ldhl	sp,	#3
	ld	a, (hl)
	add	a, #0x2a
00133$:
;src/utils/text.c:89: dialog_buf[pos] = get_tile_for_char(*ptr);
	add	a, #<(_dialog_buf)
	ld	e, a
	ld	a, #0x00
	adc	a, #>(_dialog_buf)
	ld	d, a
	push	bc
	push	de
	ldhl	sp,	#4
	ld	a, (hl)
	call	_get_tile_for_char
	pop	de
	pop	bc
	ld	(de), a
;src/utils/text.c:91: col++;
	ldhl	sp,	#3
	inc	(hl)
;src/utils/text.c:92: count++;
	inc	bc
;src/utils/text.c:93: if (col >= 16) {
	ld	a, (hl)
	sub	a, #0x10
	jr	C, 00111$
;src/utils/text.c:94: col = 0;
;src/utils/text.c:95: line++;
	xor	a, a
	ld	(hl+), a
	inc	(hl)
;src/utils/text.c:96: if (line >= 2)
	ld	a, (hl)
	sub	a, #0x02
	jr	NC, 00115$
;src/utils/text.c:97: break;
00111$:
;src/utils/text.c:99: ptr++;
	ldhl	sp,	#5
	inc	(hl)
	jr	NZ, 00248$
	inc	hl
	inc	(hl)
00248$:
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	jp	00113$
00115$:
;src/utils/text.c:104: set_win_tiles(0, 0, 20, 4, dialog_buf);
	ld	de, #_dialog_buf
	push	de
	ld	hl, #0x414
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_win_tiles
	add	sp, #6
;./gbdk/include/gb/gb.h:1739: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x70
	ldh	(_WY_REG + 0), a
;src/utils/text.c:106: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;src/utils/text.c:109: waitpad(J_A);
	ld	a, #0x10
	call	_waitpad
;src/utils/text.c:110: delay(100); // Debounce
	ld	de, #0x0064
	call	_delay
;src/utils/text.c:111: waitpadup();
	call	_waitpadup
	jp	00116$
00118$:
;src/utils/text.c:114: HIDE_WIN;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xdf
	ldh	(_LCDC_REG + 0), a
;./gbdk/include/gb/gb.h:1739: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x90
	ldh	(_WY_REG + 0), a
;src/utils/text.c:115: move_win(7, 144);
;src/utils/text.c:116: }
	add	sp, #7
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
