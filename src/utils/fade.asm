;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module fade
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _delay
	.globl _fade_out
	.globl _fade_in
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
;src/utils/fade.c:3: void fade_out() {
;	---------------------------------
; Function fade_out
; ---------------------------------
_fade_out::
	add	sp, #-4
;src/utils/fade.c:4: uint8_t palettes[] = {0xE4, 0x90, 0x40, 0xFF};
	ldhl	sp,	#0
	ld	a, #0xe4
	ld	(hl+), a
	ld	a, #0x90
	ld	(hl+), a
	ld	a, #0x40
	ld	(hl+), a
	ld	(hl), #0xff
;src/utils/fade.c:5: for (int i = 0; i < 4; i++) {
	ld	c, #0x00
00103$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00105$
;src/utils/fade.c:6: BGP_REG = OBP0_REG = OBP1_REG = palettes[i];
	ld	e, c
	ld	d, #0x00
	ld	hl, #0
	add	hl, sp
	add	hl, de
	ld	a, (hl)
	ldh	(_OBP1_REG + 0), a
	ldh	(_OBP0_REG + 0), a
	ldh	(_BGP_REG + 0), a
;src/utils/fade.c:7: delay(50);
	push	bc
	ld	de, #0x0032
	call	_delay
	pop	bc
;src/utils/fade.c:5: for (int i = 0; i < 4; i++) {
	inc	c
	jr	00103$
00105$:
;src/utils/fade.c:9: }
	add	sp, #4
	ret
;src/utils/fade.c:11: void fade_in() {
;	---------------------------------
; Function fade_in
; ---------------------------------
_fade_in::
	add	sp, #-4
;src/utils/fade.c:12: uint8_t palettes[] = {0xFF, 0x40, 0x90, 0xE4};
	ldhl	sp,	#0
	ld	a, #0xff
	ld	(hl+), a
	ld	a, #0x40
	ld	(hl+), a
	ld	a, #0x90
	ld	(hl+), a
	ld	(hl), #0xe4
;src/utils/fade.c:13: for (int i = 0; i < 4; i++) {
	ld	c, #0x00
00103$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00105$
;src/utils/fade.c:14: BGP_REG = OBP0_REG = OBP1_REG = palettes[i];
	ld	e, c
	ld	d, #0x00
	ld	hl, #0
	add	hl, sp
	add	hl, de
	ld	a, (hl)
	ldh	(_OBP1_REG + 0), a
	ldh	(_OBP0_REG + 0), a
	ldh	(_BGP_REG + 0), a
;src/utils/fade.c:15: delay(50);
	push	bc
	ld	de, #0x0032
	call	_delay
	pop	bc
;src/utils/fade.c:13: for (int i = 0; i < 4; i++) {
	inc	c
	jr	00103$
00105$:
;src/utils/fade.c:17: }
	add	sp, #4
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
