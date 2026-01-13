;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module map_manager
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _map_get_tile
	.globl _current_map
	.globl _map_is_solid
	.globl _map_check_portal
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_current_map::
	.ds 2
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
;src/utils/map_manager.c:11: uint8_t map_get_tile(uint16_t x, uint16_t y) {
;	---------------------------------
; Function map_get_tile
; ---------------------------------
_map_get_tile::
	add	sp, #-6
;src/utils/map_manager.c:12: uint16_t tx = x / 8, ty = y / 8;
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	inc	sp
	inc	sp
	push	de
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/utils/map_manager.c:13: if (tx >= current_map->w || ty >= current_map->h)
	ld	a, (_current_map)
	ld	e, a
	ld	hl, #_current_map + 1
	ld	d, (hl)
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	c, (hl)
	ld	b, #0x00
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	jr	NC, 00101$
	inc	hl
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ld	e, a
	ld	d, #0x00
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	C, 00102$
00101$:
;src/utils/map_manager.c:14: return 0;
	xor	a, a
	jr	00104$
00102$:
;src/utils/map_manager.c:15: return current_map->tiles[ty * current_map->w + tx];
	ld	hl, #_current_map
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	__mulint
	pop	hl
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	a, (bc)
00104$:
;src/utils/map_manager.c:16: }
	add	sp, #6
	ret
;src/utils/map_manager.c:18: uint8_t map_is_solid(uint16_t x, uint16_t y) {
;	---------------------------------
; Function map_is_solid
; ---------------------------------
_map_is_solid::
;src/utils/map_manager.c:19: uint8_t tid = map_get_tile(x, y);
	call	_map_get_tile
	ld	c, a
;src/utils/map_manager.c:20: for (int i = 0; i < 16; i++) {
	ld	b, #0x00
00107$:
	ld	a, b
	sub	a, #0x10
	jr	NC, 00105$
;src/utils/map_manager.c:21: if (current_map->solid_tiles[i] == 255)
	ld	a, (_current_map)
	ld	hl, #_current_map + 1
	ld	h, (hl)
	ld	l, a
	ld	de, #0x0007
	add	hl, de
	ld	e, b
	ld	d, #0x00
	add	hl, de
	ld	a, (hl)
	cp	a, #0xff
	jr	Z, 00105$
;src/utils/map_manager.c:23: if (tid == current_map->solid_tiles[i])
	sub	a, c
	jr	NZ, 00108$
;src/utils/map_manager.c:24: return 0; // It's in the passable list
	xor	a, a
	ret
00108$:
;src/utils/map_manager.c:20: for (int i = 0; i < 16; i++) {
	inc	b
	jr	00107$
00105$:
;src/utils/map_manager.c:26: return 1; // Not in passable list -> solid
	ld	a, #0x01
;src/utils/map_manager.c:27: }
	ret
;src/utils/map_manager.c:29: portal_t *map_check_portal(uint16_t x, uint16_t y) {
;	---------------------------------
; Function map_check_portal
; ---------------------------------
_map_check_portal::
	add	sp, #-5
;src/utils/map_manager.c:30: uint8_t tx = x / 8, ty = y / 8;
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	ldhl	sp,	#0
	ld	a, e
	ld	(hl+), a
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
	ld	(hl), c
;src/utils/map_manager.c:31: for (uint8_t i = 0; i < current_map->num_portals; i++) {
	ldhl	sp,	#4
	ld	(hl), #0x00
00106$:
	ld	a, (_current_map)
	ld	c, a
	ld	hl, #_current_map + 1
	ld	b, (hl)
	ld	hl, #0x0019
	add	hl, bc
	ld	e, (hl)
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, e
	jr	NC, 00104$
;src/utils/map_manager.c:32: if (current_map->portals[i].tx == tx && current_map->portals[i].ty == ty) {
	ld	hl, #0x0017
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#4
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00107$
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c,l
	ld	b,h
	inc	hl
	ld	e, (hl)
	ldhl	sp,	#1
	ld	a, (hl)
	sub	a, e
	jr	Z, 00108$
;src/utils/map_manager.c:33: return &current_map->portals[i];
00107$:
;src/utils/map_manager.c:31: for (uint8_t i = 0; i < current_map->num_portals; i++) {
	ldhl	sp,	#4
	inc	(hl)
	jr	00106$
00104$:
;src/utils/map_manager.c:36: return NULL;
	ld	bc, #0x0000
00108$:
;src/utils/map_manager.c:37: }
	add	sp, #5
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
