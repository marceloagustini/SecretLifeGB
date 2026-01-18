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
	.globl _projectile_check_enemy_collision
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_projectiles::
	.ds 36
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
;src/utils/projectile.c:8: void projectile_init(void) {
;	---------------------------------
; Function projectile_init
; ---------------------------------
_projectile_init::
;src/utils/projectile.c:9: for (int i = 0; i < MAX_PROJECTILES; i++) {
	ld	bc, #0x0000
00103$:
	ld	a, c
	sub	a, #0x04
	ret	NC
;src/utils/projectile.c:10: projectiles[i].active = 0;
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	a, l
	add	a, #<(_projectiles)
	ld	e, a
	ld	a, h
	adc	a, #>(_projectiles)
	ld	d, a
	ld	hl, #0x0006
	add	hl, de
	ld	(hl), #0x00
;src/utils/projectile.c:11: projectiles[i].sprite_id = 30 + i; // Sprites 30-33 for projectiles
	ld	hl, #0x0007
	add	hl, de
	ld	a, c
	add	a, #0x1e
	ld	(hl), a
;src/utils/projectile.c:9: for (int i = 0; i < MAX_PROJECTILES; i++) {
	inc	bc
;src/utils/projectile.c:13: }
	jr	00103$
;src/utils/projectile.c:15: void projectile_spawn(uint16_t x, uint16_t y, int8_t vx, int8_t vy,
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
;src/utils/projectile.c:18: for (int i = 0; i < MAX_PROJECTILES; i++) {
	ld	bc, #0x0000
00105$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00107$
;src/utils/projectile.c:19: if (!projectiles[i].active) {
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_projectiles
	add	hl, de
	ld	a, l
	add	a, #0x06
	ld	e, a
	ld	a, h
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	or	a, a
	jr	NZ, 00106$
;src/utils/projectile.c:20: projectiles[i].x = x;
	push	hl
	ldhl	sp,	#4
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	push	hl
	ldhl	sp,	#5
	ld	a, (hl)
	pop	hl
	ld	(hl-), a
;src/utils/projectile.c:21: projectiles[i].y = y;
	ld	c, l
	ld	b, h
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
;src/utils/projectile.c:22: projectiles[i].vx = vx;
	ld	a, l
	add	a, #0x04
	ld	c, a
	ld	a, h
	adc	a, #0x00
	ld	b, a
	push	hl
	ldhl	sp,	#8
	ld	a, (hl)
	pop	hl
	ld	(bc), a
;src/utils/projectile.c:23: projectiles[i].vy = vy;
	ld	a, l
	add	a, #0x05
	ld	c, a
	ld	a, h
	adc	a, #0x00
	ld	b, a
	push	hl
	ldhl	sp,	#9
	ld	a, (hl)
	pop	hl
	ld	(bc), a
;src/utils/projectile.c:24: projectiles[i].source = source;
	ld	bc, #0x0008
	add	hl, bc
	push	hl
	ldhl	sp,	#10
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/utils/projectile.c:25: projectiles[i].active = 1;
	ld	a, #0x01
	ld	(de), a
;src/utils/projectile.c:26: return;
	jr	00107$
00106$:
;src/utils/projectile.c:18: for (int i = 0; i < MAX_PROJECTILES; i++) {
	inc	bc
	jr	00105$
00107$:
;src/utils/projectile.c:29: }
	add	sp, #4
	pop	hl
	add	sp, #3
	jp	(hl)
;src/utils/projectile.c:31: void projectile_update_all(void) {
;	---------------------------------
; Function projectile_update_all
; ---------------------------------
_projectile_update_all::
	add	sp, #-10
;src/utils/projectile.c:32: for (int i = 0; i < MAX_PROJECTILES; i++) {
	ld	bc, #0x0000
00110$:
	ld	a, c
	sub	a, #0x04
	jp	NC, 00112$
;src/utils/projectile.c:33: if (projectiles[i].active) {
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl-), a
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
;src/utils/projectile.c:34: projectiles[i].x += projectiles[i].vx;
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
;src/utils/projectile.c:35: projectiles[i].y += projectiles[i].vy;
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
;src/utils/projectile.c:38: if (projectiles[i].x < 8 || projectiles[i].x > 248 ||
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
;src/utils/projectile.c:39: projectiles[i].y < 8 || projectiles[i].y > 248) {
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
;src/utils/projectile.c:40: projectiles[i].active = 0;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00111$:
;src/utils/projectile.c:32: for (int i = 0; i < MAX_PROJECTILES; i++) {
	inc	bc
	jp	00110$
00112$:
;src/utils/projectile.c:44: }
	add	sp, #10
	ret
;src/utils/projectile.c:46: void projectile_render_all(uint16_t camera_x, uint16_t camera_y) {
;	---------------------------------
; Function projectile_render_all
; ---------------------------------
_projectile_render_all::
	add	sp, #-12
	ldhl	sp,	#10
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#8
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/utils/projectile.c:47: uint8_t use_clipping = (current_map == &maps[2] || current_map == &maps[4]);
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 52))
	jr	NZ, 00175$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 52))
	jr	Z, 00123$
00175$:
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 104))
	jr	NZ, 00176$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 104))
	jr	Z, 00123$
00176$:
	xor	a, a
	jr	00124$
00123$:
	ld	a, #0x01
00124$:
	ldhl	sp,	#0
	ld	(hl), a
;src/utils/projectile.c:48: for (int i = 0; i < MAX_PROJECTILES; i++) {
	ld	bc, #0x0000
00118$:
	ld	a, c
	sub	a, #0x04
	jp	NC, 00120$
;src/utils/projectile.c:49: if (projectiles[i].active) {
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	a, l
	add	a, #<(_projectiles)
	ld	e, a
	ld	a, h
	adc	a, #>(_projectiles)
	ld	d, a
	ld	hl, #0x0006
	add	hl, de
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
;src/utils/projectile.c:60: move_sprite(projectiles[i].sprite_id, 0, 0);
	push	de
	ld	hl, #0x0007
	add	hl, de
	pop	de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
;src/utils/projectile.c:49: if (projectiles[i].active) {
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	or	a, a
	jp	Z, 00109$
;src/utils/projectile.c:50: uint16_t sx = projectiles[i].x - camera_x + 8;
	ld	a, (de)
	ldhl	sp,	#10
	ld	l, (hl)
	sub	a, l
	add	a, #0x08
	ldhl	sp,	#1
	ld	(hl), a
;src/utils/projectile.c:51: uint16_t sy = projectiles[i].y - camera_y + 16;
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#8
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#5
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl+)
	ld	e, (hl)
	add	a, #0x10
	ld	d, a
	ld	a, e
	adc	a, #0x00
	ldhl	sp,	#2
	ld	(hl), d
	inc	hl
	ld	(hl), a
;src/utils/projectile.c:52: if (!use_clipping || sy < 140) {
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, #0x8c
	ld	a, d
	sbc	a, #0x00
	jr	NC, 00105$
00104$:
;src/utils/projectile.c:53: if ((sys_time & 1) == 0) { // Flicker every other frame
	ld	a, (#_sys_time)
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, (#_sys_time + 1)
	ldhl	sp,	#5
	ld	(hl), a
;src/utils/projectile.c:49: if (projectiles[i].active) {
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
;src/utils/projectile.c:54: move_sprite(projectiles[i].sprite_id, sx, sy);
	ld	a, l
	add	a, #<(_projectiles)
	ld	e, a
	ld	a, h
	adc	a, #>(_projectiles)
	ld	d, a
	ld	hl, #0x0007
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
	ld	d, (hl)
	ld	a, (de)
;src/utils/projectile.c:53: if ((sys_time & 1) == 0) { // Flicker every other frame
	push	hl
	ldhl	sp,	#6
	bit	0, (hl)
	pop	hl
	jr	NZ, 00102$
;src/utils/projectile.c:54: move_sprite(projectiles[i].sprite_id, sx, sy);
	ldhl	sp,	#2
	ld	e, (hl)
	dec	hl
	push	af
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	pop	af
	ld	d, a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, d
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
	ld	e, l
	ld	d, h
	ldhl	sp,	#5
;src/utils/projectile.c:55: set_sprite_tile(projectiles[i].sprite_id, 40);
	ld	a, (hl+)
	ld	(de), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	e, (hl)
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x28
;src/utils/projectile.c:55: set_sprite_tile(projectiles[i].sprite_id, 40);
	jr	00119$
00102$:
;src/utils/projectile.c:57: move_sprite(projectiles[i].sprite_id, 0, 0);
	ld	e, a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/utils/projectile.c:57: move_sprite(projectiles[i].sprite_id, 0, 0);
	jr	00119$
00105$:
;src/utils/projectile.c:60: move_sprite(projectiles[i].sprite_id, 0, 0);
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	e, (hl)
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/utils/projectile.c:60: move_sprite(projectiles[i].sprite_id, 0, 0);
	jr	00119$
00109$:
;src/utils/projectile.c:63: move_sprite(projectiles[i].sprite_id, 0, 0); // Hide
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	e, (hl)
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/utils/projectile.c:63: move_sprite(projectiles[i].sprite_id, 0, 0); // Hide
00119$:
;src/utils/projectile.c:48: for (int i = 0; i < MAX_PROJECTILES; i++) {
	inc	bc
	jp	00118$
00120$:
;src/utils/projectile.c:66: }
	add	sp, #12
	ret
;src/utils/projectile.c:68: uint8_t projectile_check_collision(uint16_t px, uint16_t py) {
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
;src/utils/projectile.c:69: for (int i = 0; i < MAX_PROJECTILES; i++) {
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
	xor	a, a
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), a
00113$:
	ldhl	sp,	#8
	ld	a, (hl+)
	sub	a, #0x04
	ld	a, (hl)
	sbc	a, #0x00
	jp	NC, 00111$
;src/utils/projectile.c:70: if (projectiles[i].active && projectiles[i].source == 0) {
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	a, l
	add	a, #<(_projectiles)
	ld	c, a
	ld	a, h
	adc	a, #>(_projectiles)
	ld	b, a
	ld	hl, #0x0006
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jp	Z, 00114$
	ld	hl, #0x0008
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jp	NZ, 00114$
;src/utils/projectile.c:71: int16_t dx = (int16_t)px - (int16_t)projectiles[i].x;
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
;src/utils/projectile.c:72: int16_t dy = (int16_t)py - (int16_t)projectiles[i].y;
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
;src/utils/projectile.c:73: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00102$
;src/utils/projectile.c:74: dx = -dx;
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
;src/utils/projectile.c:75: if (dy < 0)
	ldhl	sp,	#12
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00104$
;src/utils/projectile.c:76: dy = -dy;
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
;src/utils/projectile.c:78: if (dx < 8 && dy < 8) {
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
	jr	NC, 00114$
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
	jr	NC, 00114$
;src/utils/projectile.c:79: projectiles[i].active = 0; // Deactivate on hit
	pop	bc
	push	bc
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	de, #_projectiles
	add	hl, de
	ld	bc, #0x0006
	add	hl, bc
	ld	(hl), #0x00
;src/utils/projectile.c:80: return 1;
	ld	a, #0x01
	jr	00115$
00114$:
;src/utils/projectile.c:69: for (int i = 0; i < MAX_PROJECTILES; i++) {
	ldhl	sp,	#8
	inc	(hl)
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	jp	00113$
00111$:
;src/utils/projectile.c:84: return 0;
	xor	a, a
00115$:
;src/utils/projectile.c:85: }
	add	sp, #14
	ret
;src/utils/projectile.c:86: uint8_t projectile_check_enemy_collision(entity_t *entities, uint8_t count) {
;	---------------------------------
; Function projectile_check_enemy_collision
; ---------------------------------
_projectile_check_enemy_collision::
	add	sp, #-20
	ldhl	sp,	#11
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
	ld	(hl), a
;src/utils/projectile.c:87: for (int i = 0; i < MAX_PROJECTILES; i++) {
	xor	a, a
	ldhl	sp,	#13
	ld	(hl+), a
	ld	(hl), a
00125$:
	ldhl	sp,	#13
	ld	a, (hl+)
	sub	a, #0x04
	ld	a, (hl)
	sbc	a, #0x00
	jp	NC, 00120$
;src/utils/projectile.c:88: if (projectiles[i].active && projectiles[i].source == 1) { // Player shot
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	bc, #_projectiles
	add	hl, bc
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
	jp	Z, 00126$
	pop	de
	push	de
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	dec	a
	jp	NZ, 00126$
;src/utils/projectile.c:89: for (uint8_t j = 0; j < count; j++) {
	ldhl	sp,	#15
	ld	(hl), #0x00
00122$:
	ldhl	sp,	#15
	ld	a, (hl)
	ldhl	sp,	#10
	sub	a, (hl)
	jp	NC, 00126$
;src/utils/projectile.c:90: entity_t *e = &entities[j];
	ldhl	sp,	#15
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#11
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
;src/utils/projectile.c:91: if (e->active && e->type == ENT_ENEMY && e->death_timer == 0) {
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jp	Z, 00123$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	sub	a, #0x03
	jp	NZ, 00123$
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
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
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jp	NZ, 00123$
;src/utils/projectile.c:92: int16_t dx = (int16_t)(projectiles[i].x + 4) - (int16_t)(e->x + 8);
	pop	de
	push	de
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,	#18
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	hl, #0x0008
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,#18
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ld	(hl-), a
	ld	(hl), e
;src/utils/projectile.c:93: int16_t dy = (int16_t)(projectiles[i].y + 4) - (int16_t)(e->y + 8);
	pop	hl
	push	hl
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	l, (hl)
	add	a, #0x08
	ld	e, a
	ld	a, l
	adc	a, #0x00
	ldhl	sp,	#8
	ld	(hl), e
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ldhl	sp,	#19
	ld	(hl-), a
;src/utils/projectile.c:94: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00102$
;src/utils/projectile.c:95: dx = -dx;
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#17
	ld	(hl-), a
	ld	(hl), e
00102$:
;src/utils/projectile.c:96: if (dy < 0)
	ldhl	sp,	#18
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00104$
;src/utils/projectile.c:97: dy = -dy;
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#19
	ld	(hl-), a
	ld	(hl), e
00104$:
;src/utils/projectile.c:99: if (dx < 12 && dy < 12) {
	ldhl	sp,	#16
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x0c
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00123$
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x0c
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00123$
;src/utils/projectile.c:100: projectiles[i].active = 0; // Destroy projectile
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/utils/projectile.c:101: if (e->health > 0) {
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000e
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
;src/utils/projectile.c:102: e->health--;
	or	a,a
	jr	Z, 00108$
	dec	a
	ld	(de), a
;src/utils/projectile.c:103: e->hit_timer = 20;
	push	de
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	pop	de
	ld	(hl), #0x14
;src/utils/projectile.c:104: if (e->health == 0) {
	ld	a, (de)
	or	a, a
	jr	NZ, 00108$
;src/utils/projectile.c:105: e->death_timer = 35; // Duration of explosion
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x23
00108$:
;src/utils/projectile.c:108: return 1;
	ld	a, #0x01
	jr	00127$
00123$:
;src/utils/projectile.c:89: for (uint8_t j = 0; j < count; j++) {
	ldhl	sp,	#15
	inc	(hl)
	jp	00122$
00126$:
;src/utils/projectile.c:87: for (int i = 0; i < MAX_PROJECTILES; i++) {
	ldhl	sp,	#13
	inc	(hl)
	jp	00125$
00120$:
;src/utils/projectile.c:114: return 0;
	xor	a, a
00127$:
;src/utils/projectile.c:115: }
	add	sp, #20
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
