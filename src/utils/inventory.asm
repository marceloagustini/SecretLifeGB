;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module inventory
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcmp
	.globl _inventory_count
	.globl _inventory
	.globl _inventory_init
	.globl _inventory_add_item
	.globl _inventory_has_item
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_inventory::
	.ds 40
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_inventory_count::
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
;src/utils/inventory.c:7: void inventory_init(void) {
;	---------------------------------
; Function inventory_init
; ---------------------------------
_inventory_init::
;src/utils/inventory.c:8: inventory_count = 0;
	xor	a, a
	ld	(#_inventory_count),a
;src/utils/inventory.c:9: for (uint8_t i = 0; i < MAX_INVENTORY_SIZE; i++) {
	ld	c, #0x00
00103$:
	ld	a, c
	sub	a, #0x08
	ret	NC
;src/utils/inventory.c:10: inventory[i].name = "";
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_inventory
	add	hl, de
	ld	a, #<(___str_0)
	ld	(hl+), a
	ld	(hl), #>(___str_0)
;src/utils/inventory.c:9: for (uint8_t i = 0; i < MAX_INVENTORY_SIZE; i++) {
	inc	c
;src/utils/inventory.c:12: }
	jr	00103$
___str_0:
	.db 0x00
;src/utils/inventory.c:14: int8_t inventory_add_item(const char *name, const char *desc, uint8_t icon) {
;	---------------------------------
; Function inventory_add_item
; ---------------------------------
_inventory_add_item::
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	inc	sp
	inc	sp
	push	bc
;src/utils/inventory.c:15: if (inventory_count >= MAX_INVENTORY_SIZE)
	ld	a, (#_inventory_count)
	sub	a, #0x08
	jr	C, 00102$
;src/utils/inventory.c:16: return -1;
	ld	a, #0xff
	jr	00103$
00102$:
;src/utils/inventory.c:18: inventory[inventory_count].name = name;
	ld	hl, #_inventory_count
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	bc, #_inventory
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/utils/inventory.c:19: inventory[inventory_count].description = desc;
	ld	hl, #_inventory_count
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
	ld	c, l
	ld	b, h
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	ld	a, (hl)
	ld	(bc), a
;src/utils/inventory.c:20: inventory[inventory_count].icon_tile = icon;
	ld	hl, #_inventory_count
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
	inc	hl
	inc	hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(bc), a
;src/utils/inventory.c:21: inventory_count++;
	ld	hl, #_inventory_count
	inc	(hl)
;src/utils/inventory.c:22: return inventory_count - 1;
	ld	a, (hl)
	dec	a
00103$:
;src/utils/inventory.c:23: }
	add	sp, #4
	pop	hl
	inc	sp
	jp	(hl)
;src/utils/inventory.c:25: uint8_t inventory_has_item(const char *name) {
;	---------------------------------
; Function inventory_has_item
; ---------------------------------
_inventory_has_item::
	push	de
;src/utils/inventory.c:26: for (uint8_t i = 0; i < inventory_count; i++) {
	ld	c, #0x00
00105$:
	ld	a, c
	ld	hl, #_inventory_count
	sub	a, (hl)
	jr	NC, 00103$
;src/utils/inventory.c:27: if (strcmp(inventory[i].name, name) == 0) {
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_inventory
	add	hl, de
	ld	a, (hl+)
	ld	b, (hl)
	pop	de
	push	de
	push	de
	ld	e, a
	ld	d, b
	push	de
	call	_strcmp
	add	sp, #4
	ld	a, d
	or	a, e
	jr	NZ, 00106$
;src/utils/inventory.c:28: return 1;
	ld	a, #0x01
	jr	00107$
00106$:
;src/utils/inventory.c:26: for (uint8_t i = 0; i < inventory_count; i++) {
	inc	c
	jr	00105$
00103$:
;src/utils/inventory.c:31: return 0;
	xor	a, a
00107$:
;src/utils/inventory.c:32: }
	inc	sp
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__inventory_count:
	.db #0x00	; 0
	.area _CABS (ABS)
