;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module projectile
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _projectiles
	.globl _projectile_init
	.globl _projectile_spawn
	.globl _projectile_update_all
	.globl _projectile_render_all
	.globl _projectile_check_collision
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_projectiles::
	.ds 32
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
;src/utils/projectile.c:6: void projectile_init(void) {
;	---------------------------------
; Function projectile_init
; ---------------------------------
_projectile_init::
;src/utils/projectile.c:7: for (int i = 0; i < MAX_PROJECTILES; i++) {
	ld	bc, #0x0000
00103$:
	ld	a, c
	sub	a, #0x04
	ret	NC
;src/utils/projectile.c:8: projectiles[i].active = 0;
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	add	a, #<(_projectiles)
	ld	e, a
	ld	a, h
	adc	a, #>(_projectiles)
	ld	d, a
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x00
;src/utils/projectile.c:9: projectiles[i].sprite_id = 37 + i; // Sprites 37-40 for projectiles
	ld	hl, #0x0007
	add	hl, de
	ld	a, c
	add	a, #0x25
	ld	(hl), a
;src/utils/projectile.c:7: for (int i = 0; i < MAX_PROJECTILES; i++) {
	inc	bc
;src/utils/projectile.c:11: }
	jr	00103$
;src/utils/projectile.c:13: void projectile_spawn(uint16_t x, uint16_t y, int8_t vx, int8_t vy) {
;	---------------------------------
; Function projectile_spawn
; ---------------------------------
_projectile_spawn::
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	inc	sp
	inc	sp
	push	bc
;src/utils/projectile.c:15: for (int i = 0; i < MAX_PROJECTILES; i++) {
	ld	bc, #0x0000
00105$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00107$
;src/utils/projectile.c:16: if (!projectiles[i].active) {
	ld	de, #_projectiles+0
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	e, l
	ld	d, h
	ld	hl, #0x0006
	add	hl, de
	ld	a, (hl)
	or	a, a
	jr	NZ, 00106$
;src/utils/projectile.c:17: projectiles[i].x = x;
	push	hl
	ldhl	sp,	#4
	ld	a, (hl)
	pop	hl
	ld	(de), a
	inc	de
	push	hl
	ldhl	sp,	#5
	ld	a, (hl)
	pop	hl
	ld	(de), a
	dec	de
;src/utils/projectile.c:18: projectiles[i].y = y;
	ld	c, e
	ld	b, d
	inc	bc
	inc	bc
	push	hl
	ldhl	sp,	#2
	ld	a, (hl)
	pop	hl
	ld	(bc), a
	inc	bc
	push	hl
	ldhl	sp,	#3
	ld	a, (hl)
	pop	hl
	ld	(bc), a
;src/utils/projectile.c:19: projectiles[i].vx = vx;
	ld	a, e
	add	a, #0x04
	ld	c, a
	ld	a, d
	adc	a, #0x00
	ld	b, a
	push	hl
	ldhl	sp,	#8
	ld	a, (hl)
	pop	hl
	ld	(bc), a
;src/utils/projectile.c:20: projectiles[i].vy = vy;
	inc	de
	inc	de
	inc	de
	inc	de
	inc	de
	push	hl
	ldhl	sp,	#9
	ld	a, (hl)
	pop	hl
	ld	(de), a
;src/utils/projectile.c:21: projectiles[i].active = 1;
	ld	(hl), #0x01
;src/utils/projectile.c:22: return;
	jr	00107$
00106$:
;src/utils/projectile.c:15: for (int i = 0; i < MAX_PROJECTILES; i++) {
	inc	bc
	jr	00105$
00107$:
;src/utils/projectile.c:25: }
	add	sp, #4
	pop	hl
	pop	af
	jp	(hl)
;src/utils/projectile.c:27: void projectile_update_all(void) {
;	---------------------------------
; Function projectile_update_all
; ---------------------------------
_projectile_update_all::
	add	sp, #-10
;src/utils/projectile.c:28: for (int i = 0; i < MAX_PROJECTILES; i++) {
	ld	bc, #0x0000
00110$:
;src/utils/projectile.c:29: if (projectiles[i].active) {
	ld	a,c
	cp	a,#0x04
	jp	NC,00112$
	ld	d, b
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	ld	e, a
	ld	hl, #_projectiles
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	Z, 00111$
;src/utils/projectile.c:30: projectiles[i].x += projectiles[i].vx;
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#8
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/utils/projectile.c:31: projectiles[i].y += projectiles[i].vy;
	pop	de
	push	de
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	pop	de
	push	de
	ld	hl, #0x0005
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
	rlca
	sbc	a, a
	ld	d, a
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/utils/projectile.c:34: if (projectiles[i].x < 8 || projectiles[i].x > 248 ||
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	a, l
	sub	a, #0x08
	ld	a, h
	sbc	a, #0x00
	jr	C, 00101$
	ld	a, #0xf8
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	jr	C, 00101$
;src/utils/projectile.c:35: projectiles[i].y < 8 || projectiles[i].y > 248) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	a, l
	sub	a, #0x08
	ld	a, h
	sbc	a, #0x00
	jr	C, 00101$
	ld	a, #0xf8
	cp	a, l
	ld	a, #0x00
	sbc	a, h
	jr	NC, 00111$
00101$:
;src/utils/projectile.c:36: projectiles[i].active = 0;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00111$:
;src/utils/projectile.c:28: for (int i = 0; i < MAX_PROJECTILES; i++) {
	inc	bc
	jp	00110$
00112$:
;src/utils/projectile.c:40: }
	add	sp, #10
	ret
;src/utils/projectile.c:42: void projectile_render_all(uint16_t camera_x, uint16_t camera_y) {
;	---------------------------------
; Function projectile_render_all
; ---------------------------------
_projectile_render_all::
	add	sp, #-12
	ldhl	sp,	#8
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/utils/projectile.c:43: for (int i = 0; i < MAX_PROJECTILES; i++) {
	xor	a, a
	ldhl	sp,	#10
	ld	(hl+), a
	ld	(hl), a
00109$:
	ldhl	sp,	#10
	ld	a, (hl+)
	sub	a, #0x04
	ld	a, (hl)
	sbc	a, #0x00
	jp	NC, 00111$
;src/utils/projectile.c:44: if (projectiles[i].active) {
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x03
00135$:
	ldhl	sp,	#4
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00135$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_projectiles
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#2
	ld	(hl), a
;src/utils/projectile.c:47: move_sprite(projectiles[i].sprite_id, sx, sy);
	pop	de
	push	de
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl), a
;src/utils/projectile.c:44: if (projectiles[i].active) {
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;src/utils/projectile.c:45: uint16_t sx = projectiles[i].x - camera_x + 8;
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#8
	ld	c, (hl)
;src/utils/projectile.c:46: uint16_t sy = projectiles[i].y - camera_y + 16;
	dec	hl
	dec	hl
	sub	a, c
	add	a, #0x08
	ld	c, a
	pop	de
	push	de
	inc	de
	inc	de
	ld	a, (de)
	ld	b, (hl)
;src/utils/projectile.c:47: move_sprite(projectiles[i].sprite_id, sx, sy);
	dec	hl
	sub	a, b
	add	a, #0x10
	ld	e, a
	ld	b, (hl)
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, #_shadow_OAM
	add	hl, de
	pop	de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	(hl), c
;src/utils/projectile.c:48: set_sprite_tile(projectiles[i].sprite_id, 40);
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00136$:
	ldhl	sp,	#4
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00136$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x28
;src/utils/projectile.c:48: set_sprite_tile(projectiles[i].sprite_id, 40);
	jr	00110$
00102$:
;src/utils/projectile.c:50: move_sprite(projectiles[i].sprite_id, 0, 0); // Hide
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ldhl	sp,	#5
	ld	a, (hl-)
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00137$:
	ldhl	sp,	#4
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00137$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	ld	(hl), #0x00
;src/utils/projectile.c:50: move_sprite(projectiles[i].sprite_id, 0, 0); // Hide
00110$:
;src/utils/projectile.c:43: for (int i = 0; i < MAX_PROJECTILES; i++) {
	ldhl	sp,	#10
	inc	(hl)
	jp	00109$
00111$:
;src/utils/projectile.c:53: }
	add	sp, #12
	ret
;src/utils/projectile.c:55: uint8_t projectile_check_collision(uint16_t px, uint16_t py) {
;	---------------------------------
; Function projectile_check_collision
; ---------------------------------
_projectile_check_collision::
	add	sp, #-14
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/utils/projectile.c:56: for (int i = 0; i < MAX_PROJECTILES; i++) {
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
	xor	a, a
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), a
00112$:
	ldhl	sp,	#8
	ld	a, (hl+)
	sub	a, #0x04
	ld	a, (hl)
	sbc	a, #0x00
	jp	NC, 00110$
;src/utils/projectile.c:57: if (projectiles[i].active) {
	dec	hl
	ld	a, (hl)
	ld	b, #0x00
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, #<(_projectiles)
	ld	c, a
	ld	a, b
	adc	a, #>(_projectiles)
	ld	b, a
	ld	hl, #0x0006
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jp	Z, 00113$
;src/utils/projectile.c:58: int16_t dx = (int16_t)px - (int16_t)projectiles[i].x;
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#12
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#12
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
;src/utils/projectile.c:59: int16_t dy = (int16_t)py - (int16_t)projectiles[i].y;
	ldhl	sp,	#4
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ldhl	sp,	#13
	ld	(hl-), a
;src/utils/projectile.c:60: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00102$
;src/utils/projectile.c:61: dx = -dx;
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
00102$:
;src/utils/projectile.c:62: if (dy < 0)
	ldhl	sp,	#12
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00104$
;src/utils/projectile.c:63: dy = -dy;
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#13
	ld	(hl-), a
	ld	(hl), e
00104$:
;src/utils/projectile.c:65: if (dx < 8 && dy < 8) {
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x08
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00113$
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x08
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00113$
;src/utils/projectile.c:66: projectiles[i].active = 0; // Deactivate on hit
	ldhl	sp,	#0
	ld	a, (hl)
	ld	c, #0x00
	add	a, a
	rl	c
	add	a, a
	rl	c
	add	a, a
	rl	c
	ld	l, a
	ld	h, c
	ld	de, #_projectiles
	add	hl, de
	ld	bc, #0x0006
	add	hl, bc
	ld	(hl), #0x00
;src/utils/projectile.c:67: return 1;
	ld	a, #0x01
	jr	00114$
00113$:
;src/utils/projectile.c:56: for (int i = 0; i < MAX_PROJECTILES; i++) {
	ldhl	sp,	#8
	inc	(hl)
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	jp	00112$
00110$:
;src/utils/projectile.c:71: return 0;
	xor	a, a
00114$:
;src/utils/projectile.c:72: }
	add	sp, #14
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
