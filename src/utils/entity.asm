;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module entity
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _text_dialogue
	.globl _projectile_spawn
	.globl _entity_init
	.globl _ai_npc_static
	.globl _ai_anim_simple
	.globl _ai_enemy_random_walk
	.globl _ai_enemy_shooter
	.globl _ai_enemy_chaser_shooter
	.globl _entity_update_all
	.globl _entity_render_all
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
;src/utils/entity.c:8: void entity_init(entity_t *e, ent_type_t type, uint16_t x, uint16_t y,
;	---------------------------------
; Function entity_init
; ---------------------------------
_entity_init::
	dec	sp
	ld	c, e
	ld	b, d
	ldhl	sp,	#0
	ld	(hl), a
;src/utils/entity.c:10: e->type = type;
	ld	hl, #0x0004
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (hl)
	ld	(de), a
;src/utils/entity.c:11: e->x = x;
	ld	e, c
	ld	d, b
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	(de), a
	inc	de
;src/utils/entity.c:12: e->y = y;
	ld	a, (hl+)
	ld	(de), a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/utils/entity.c:13: e->sprite_base = sprite_base;
	ld	hl, #0x0007
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(de), a
;src/utils/entity.c:14: e->dialogue = dialogue;
	ld	hl, #0x0005
	add	hl, bc
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/utils/entity.c:15: e->active = 1;
	ld	hl, #0x0008
	add	hl, bc
	ld	(hl), #0x01
;src/utils/entity.c:16: e->dir = 0;
	ld	hl, #0x0009
	add	hl, bc
	ld	(hl), #0x00
;src/utils/entity.c:17: e->anim_frame = 0;
	ld	hl, #0x000a
	add	hl, bc
	ld	(hl), #0x00
;src/utils/entity.c:18: e->anim_timer = 0;
	ld	hl, #0x000b
	add	hl, bc
	ld	(hl), #0x00
;src/utils/entity.c:19: e->move_timer = 0;
	ld	hl, #0x000c
	add	hl, bc
	ld	(hl), #0x00
;src/utils/entity.c:22: e->update = ai_enemy_random_walk;
	ld	hl, #0x0011
	add	hl, bc
	ld	e, l
	ld	d, h
;src/utils/entity.c:23: e->health = 3;
	ld	hl, #0x000e
	add	hl, bc
;src/utils/entity.c:21: if (type == ENT_ENEMY) {
	push	hl
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x03
	pop	hl
	jr	NZ, 00102$
;src/utils/entity.c:22: e->update = ai_enemy_random_walk;
	ld	a, #<(_ai_enemy_random_walk)
	ld	(de), a
	inc	de
	ld	a, #>(_ai_enemy_random_walk)
	ld	(de), a
;src/utils/entity.c:23: e->health = 3;
	ld	(hl), #0x03
	jr	00103$
00102$:
;src/utils/entity.c:25: e->update = ai_npc_static;
	ld	a, #<(_ai_npc_static)
	ld	(de), a
	inc	de
	ld	a, #>(_ai_npc_static)
	ld	(de), a
;src/utils/entity.c:26: e->health = 0;
	ld	(hl), #0x00
00103$:
;src/utils/entity.c:28: e->hit_timer = 0;
	ld	hl, #0x000f
	add	hl, bc
	ld	(hl), #0x00
;src/utils/entity.c:29: e->death_timer = 0;
	ld	hl, #0x0010
	add	hl, bc
	ld	(hl), #0x00
;src/utils/entity.c:30: }
	inc	sp
	pop	hl
	add	sp, #7
	jp	(hl)
;src/utils/entity.c:32: void ai_npc_static(entity_t *self) {
;	---------------------------------
; Function ai_npc_static
; ---------------------------------
_ai_npc_static::
;src/utils/entity.c:35: }
	ret
;src/utils/entity.c:37: void ai_anim_simple(entity_t *self) {
;	---------------------------------
; Function ai_anim_simple
; ---------------------------------
_ai_anim_simple::
;src/utils/entity.c:38: if (++self->anim_timer > 16) {
	ld	hl, #0x000b
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	inc	a
	ld	(bc), a
	cp	a, #0x11
	ret	C
;src/utils/entity.c:39: self->anim_frame = !self->anim_frame;
	ld	hl, #0x000a
	add	hl, de
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/utils/entity.c:40: self->anim_timer = 0;
	xor	a, a
	ld	(bc), a
;src/utils/entity.c:42: }
	ret
;src/utils/entity.c:44: void ai_enemy_random_walk(entity_t *self) {
;	---------------------------------
; Function ai_enemy_random_walk
; ---------------------------------
_ai_enemy_random_walk::
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
;src/utils/entity.c:45: if (self->move_timer > 0) {
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	a, (de)
	ld	c, a
	or	a, a
	jp	Z, 00130$
;src/utils/entity.c:46: self->move_timer--;
	dec	c
	pop	hl
	push	hl
	ld	(hl), c
;src/utils/entity.c:47: if (self->dir == 0) { // Down
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
;src/utils/entity.c:48: if (self->y < 240)
	ldhl	sp,	#2
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	inc	bc
	inc	bc
;src/utils/entity.c:47: if (self->dir == 0) { // Down
	or	a, a
	jr	NZ, 00122$
;src/utils/entity.c:48: if (self->y < 240)
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	e, l
	ld	d, h
	ld	a, e
	sub	a, #0xf0
	ld	a, d
	sbc	a, #0x00
	jr	NC, 00102$
;src/utils/entity.c:49: self->y++;
	inc	hl
	ld	a, l
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
	jr	00123$
00102$:
;src/utils/entity.c:51: self->move_timer = 0;
	pop	hl
	ld	(hl), #0x00
	push	hl
	jr	00123$
00122$:
;src/utils/entity.c:52: } else if (self->dir == 1) { // Up
	cp	a, #0x01
	jr	NZ, 00119$
;src/utils/entity.c:53: if (self->y > 16)
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	e, l
	ld	d, h
	ld	a, #0x10
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	NC, 00105$
;src/utils/entity.c:54: self->y--;
	dec	hl
	ld	a, l
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
	jr	00123$
00105$:
;src/utils/entity.c:56: self->move_timer = 0;
	pop	hl
	ld	(hl), #0x00
	push	hl
	jr	00123$
00119$:
;src/utils/entity.c:58: if (self->x > 16)
	ldhl	sp,	#2
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
;src/utils/entity.c:57: } else if (self->dir == 2) { // Left
	cp	a, #0x02
	jr	NZ, 00116$
;src/utils/entity.c:58: if (self->x > 16)
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	e, l
	ld	d, h
	ld	a, #0x10
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	NC, 00108$
;src/utils/entity.c:59: self->x--;
	dec	hl
	ld	a, l
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
	jr	00123$
00108$:
;src/utils/entity.c:61: self->move_timer = 0;
	pop	hl
	ld	(hl), #0x00
	push	hl
	jr	00123$
00116$:
;src/utils/entity.c:62: } else if (self->dir == 3) { // Right
	sub	a, #0x03
	jr	NZ, 00123$
;src/utils/entity.c:63: if (self->x < 240)
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	e, l
	ld	d, h
	ld	a, e
	sub	a, #0xf0
	ld	a, d
	sbc	a, #0x00
	jr	NC, 00111$
;src/utils/entity.c:64: self->x++;
	inc	hl
	ld	a, l
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
	jr	00123$
00111$:
;src/utils/entity.c:66: self->move_timer = 0;
	pop	hl
	ld	(hl), #0x00
	push	hl
00123$:
;src/utils/entity.c:69: if (++self->anim_timer > 8) {
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	inc	a
	ld	(bc), a
	cp	a, #0x09
	jr	C, 00132$
;src/utils/entity.c:70: self->anim_frame = !self->anim_frame;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(de), a
;src/utils/entity.c:71: self->anim_timer = 0;
	xor	a, a
	ld	(bc), a
	jr	00132$
00130$:
;src/utils/entity.c:75: uint8_t r = DIV_REG & 0x0F;
	ldh	a, (_DIV_REG + 0)
	and	a, #0x0f
	ld	c, a
;src/utils/entity.c:47: if (self->dir == 0) { // Down
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	e, l
	ld	d, h
;src/utils/entity.c:76: if (r < 4)
;src/utils/entity.c:77: self->dir = r; // 0=D, 1=U, 2=L, 3=R
	ld	a,c
	cp	a,#0x04
	jr	NC, 00127$
	ld	(de), a
	jr	00128$
00127$:
;src/utils/entity.c:79: self->dir = -1; // Wait/Idle
	ld	a, #0xff
	ld	(de), a
00128$:
;src/utils/entity.c:80: self->move_timer = 30 + (DIV_REG & 0x1F);
	ldh	a, (_DIV_REG + 0)
	and	a, #0x1f
	add	a, #0x1e
	pop	hl
	push	hl
	ld	(hl), a
00132$:
;src/utils/entity.c:82: }
	add	sp, #4
	ret
;src/utils/entity.c:84: void ai_enemy_shooter(entity_t *self, uint16_t player_x, uint16_t player_y) {
;	---------------------------------
; Function ai_enemy_shooter
; ---------------------------------
_ai_enemy_shooter::
	add	sp, #-14
	ldhl	sp,	#12
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
;src/utils/entity.c:87: if (++self->move_timer > 60) { // Shoot every 60 frames (~1 second)
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
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
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	inc	a
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
	cp	a, #0x3d
	jp	C, 00116$
;src/utils/entity.c:88: self->move_timer = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/utils/entity.c:91: int16_t dx = (int16_t)player_x - (int16_t)self->x;
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
	ld	e, b
	ld	d, c
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	(hl), e
;src/utils/entity.c:92: int16_t dy = (int16_t)player_y - (int16_t)self->y;
	ldhl	sp,	#16
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#17
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,#8
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
;src/utils/entity.c:95: int8_t vx = 0, vy = 0;
	ld	a, e
	ld	(hl+), a
	inc	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/utils/entity.c:96: if (dx > 10)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, b
	ld	d, #0x00
	ld	a, #0x0a
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00160$
	bit	7, d
	jr	NZ, 00161$
	cp	a, a
	jr	00161$
00160$:
	bit	7, d
	jr	Z, 00161$
	scf
00161$:
	jr	NC, 00104$
;src/utils/entity.c:97: vx = 2;
	ldhl	sp,	#8
	ld	(hl), #0x02
	jr	00105$
00104$:
;src/utils/entity.c:98: else if (dx < -10)
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, #0xf6
	ld	a, (hl)
	sbc	a, #0xff
	ld	d, (hl)
	ld	a, #0xff
	ld	e, a
	bit	7, e
	jr	Z, 00162$
	bit	7, d
	jr	NZ, 00163$
	cp	a, a
	jr	00163$
00162$:
	bit	7, d
	jr	Z, 00163$
	scf
00163$:
	jr	NC, 00105$
;src/utils/entity.c:99: vx = -2;
	ldhl	sp,	#8
	ld	(hl), #0xfe
00105$:
;src/utils/entity.c:100: if (dy > 10)
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, b
	ld	d, #0x00
	ld	a, #0x0a
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00164$
	bit	7, d
	jr	NZ, 00165$
	cp	a, a
	jr	00165$
00164$:
	bit	7, d
	jr	Z, 00165$
	scf
00165$:
	jr	NC, 00109$
;src/utils/entity.c:101: vy = 2;
	ldhl	sp,	#9
	ld	(hl), #0x02
	jr	00110$
00109$:
;src/utils/entity.c:102: else if (dy < -10)
	ldhl	sp,	#6
	ld	a, (hl+)
	sub	a, #0xf6
	ld	a, (hl)
	sbc	a, #0xff
	ld	d, (hl)
	ld	a, #0xff
	ld	e, a
	bit	7, e
	jr	Z, 00166$
	bit	7, d
	jr	NZ, 00167$
	cp	a, a
	jr	00167$
00166$:
	bit	7, d
	jr	Z, 00167$
	scf
00167$:
	jr	NC, 00110$
;src/utils/entity.c:103: vy = -2;
	ldhl	sp,	#9
	ld	(hl), #0xfe
00110$:
;src/utils/entity.c:105: if (vx != 0 || vy != 0) {
	ldhl	sp,	#8
	ld	a, (hl)
	or	a, a
	jr	NZ, 00111$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00116$
00111$:
;src/utils/entity.c:106: projectile_spawn(self->x + 8, self->y + 8, vx, vy, 0);
	ldhl	sp,	#4
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
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
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
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
	ld	hl, #0x0008
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
	ld	(hl), a
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl-)
	ld	d, a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	push	de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_projectile_spawn
00116$:
;src/utils/entity.c:109: }
	add	sp, #14
	pop	hl
	pop	af
	jp	(hl)
;src/utils/entity.c:111: void ai_enemy_chaser_shooter(entity_t *self) {
;	---------------------------------
; Function ai_enemy_chaser_shooter
; ---------------------------------
_ai_enemy_chaser_shooter::
	add	sp, #-14
	ldhl	sp,	#12
	ld	a, e
	ld	(hl+), a
;src/utils/entity.c:116: if (++self->move_timer > 1) {
	ld	a, d
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
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
	ld	c, a
	inc	c
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
;src/utils/entity.c:119: int16_t dx = (int16_t)player_x - (int16_t)self->x;
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
;src/utils/entity.c:120: int16_t dy = (int16_t)player_y - (int16_t)self->y;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl), a
;src/utils/entity.c:116: if (++self->move_timer > 1) {
	ld	a, #0x01
	sub	a, c
	jp	NC, 00114$
;src/utils/entity.c:117: self->move_timer = 0;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/utils/entity.c:119: int16_t dx = (int16_t)player_x - (int16_t)self->x;
	ld	a, (_player_x)
	ld	b, a
	ld	hl, #_player_x + 1
	ld	c, (hl)
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	ld	e, b
	ld	d, c
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	(hl), e
;src/utils/entity.c:120: int16_t dy = (int16_t)player_y - (int16_t)self->y;
	ld	a, (#_player_y)
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,#6
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
;src/utils/entity.c:123: if (dx > 8) {
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/utils/entity.c:125: self->dir = 3; // Right
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
;src/utils/entity.c:123: if (dx > 8) {
	ld	e, b
	ld	d, #0x00
	ld	a, #0x08
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00207$
	bit	7, d
	jr	NZ, 00208$
	cp	a, a
	jr	00208$
00207$:
	bit	7, d
	jr	Z, 00208$
	scf
00208$:
	jr	NC, 00104$
;src/utils/entity.c:124: self->x++;
	pop	bc
	push	bc
	inc	bc
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/utils/entity.c:125: self->dir = 3; // Right
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x03
	jr	00105$
00104$:
;src/utils/entity.c:126: } else if (dx < -8) {
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, #0xf8
	ld	a, (hl)
	sbc	a, #0xff
	ld	d, (hl)
	ld	a, #0xff
	bit	7,a
	jr	Z, 00209$
	bit	7, d
	jr	NZ, 00210$
	cp	a, a
	jr	00210$
00209$:
	bit	7, d
	jr	Z, 00210$
	scf
00210$:
	jr	NC, 00105$
;src/utils/entity.c:127: self->x--;
	pop	bc
	push	bc
	dec	bc
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/utils/entity.c:128: self->dir = 2; // Left
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x02
00105$:
;src/utils/entity.c:131: if (dy > 8) {
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, b
	ld	d, #0x00
	ld	a, #0x08
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	bit	7, e
	jr	Z, 00211$
	bit	7, d
	jr	NZ, 00212$
	cp	a, a
	jr	00212$
00211$:
	bit	7, d
	jr	Z, 00212$
	scf
00212$:
	jr	NC, 00109$
;src/utils/entity.c:132: self->y++;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	inc	bc
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/utils/entity.c:133: self->dir = 0; // Down
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
	jr	00110$
00109$:
;src/utils/entity.c:134: } else if (dy < -8) {
	ldhl	sp,	#4
	ld	a, (hl+)
	sub	a, #0xf8
	ld	a, (hl)
	sbc	a, #0xff
	ld	d, (hl)
	ld	a, #0xff
	bit	7,a
	jr	Z, 00213$
	bit	7, d
	jr	NZ, 00214$
	cp	a, a
	jr	00214$
00213$:
	bit	7, d
	jr	Z, 00214$
	scf
00214$:
	jr	NC, 00110$
;src/utils/entity.c:135: self->y--;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	dec	bc
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/utils/entity.c:136: self->dir = 1; // Up
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x01
00110$:
;src/utils/entity.c:140: if (++self->anim_timer > 8) {
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000b
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	inc	a
	ld	(bc), a
	cp	a, #0x09
	jr	C, 00114$
;src/utils/entity.c:141: self->anim_frame = !self->anim_frame;
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(de), a
;src/utils/entity.c:142: self->anim_timer = 0;
	xor	a, a
	ld	(bc), a
00114$:
;src/utils/entity.c:147: if (self->shoot_timer > 0) {
	ldhl	sp,#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
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
	ld	c, a
	or	a, a
	jr	Z, 00126$
;src/utils/entity.c:148: self->shoot_timer--;
	dec	c
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), c
	jp	00128$
00126$:
;src/utils/entity.c:152: int16_t dx = (int16_t)player_x - (int16_t)self->x;
	ld	a, (_player_x)
	ld	c, a
	ld	hl, #_player_x + 1
	ld	b, (hl)
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
;src/utils/entity.c:153: int16_t dy = (int16_t)player_y - (int16_t)self->y;
	ld	a, (#_player_y)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	pop	de
	push	de
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
;src/utils/entity.c:155: int8_t vx = 0, vy = 0;
	ld	a, e
	ld	(hl-), a
	dec	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/utils/entity.c:156: if (dx > 0)
	ld	e, b
	xor	a, a
	ld	d, a
	cp	a, c
	sbc	a, b
	bit	7, e
	jr	Z, 00215$
	bit	7, d
	jr	NZ, 00216$
	cp	a, a
	jr	00216$
00215$:
	bit	7, d
	jr	Z, 00216$
	scf
00216$:
	jr	NC, 00118$
;src/utils/entity.c:157: vx = 2;
	ldhl	sp,	#8
	ld	(hl), #0x02
	jr	00119$
00118$:
;src/utils/entity.c:158: else if (dx < 0)
	bit	7, b
	jr	Z, 00119$
;src/utils/entity.c:159: vx = -2;
	ldhl	sp,	#8
	ld	(hl), #0xfe
00119$:
;src/utils/entity.c:160: if (dy > 0)
	ldhl	sp,	#10
	xor	a, a
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	ld	e, (hl)
	bit	7, e
	jr	Z, 00217$
	bit	7, d
	jr	NZ, 00218$
	cp	a, a
	jr	00218$
00217$:
	bit	7, d
	jr	Z, 00218$
	scf
00218$:
	jr	NC, 00123$
;src/utils/entity.c:161: vy = 2;
	ldhl	sp,	#9
	ld	(hl), #0x02
	jr	00124$
00123$:
;src/utils/entity.c:162: else if (dy < 0)
	ldhl	sp,	#11
	bit	7, (hl)
	jr	Z, 00124$
;src/utils/entity.c:163: vy = -2;
	dec	hl
	dec	hl
	ld	(hl), #0xfe
00124$:
;src/utils/entity.c:165: projectile_spawn(self->x + 8, self->y + 8, vx, vy, 0);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0008
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	e, l
	ld	d, h
	xor	a, a
	push	af
	inc	sp
	ldhl	sp,	#10
	ld	a, (hl-)
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_projectile_spawn
;src/utils/entity.c:169: self->shoot_timer = 60 + (DIV_REG & 0x3F);
	ldh	a, (_DIV_REG + 0)
	and	a, #0x3f
	add	a, #0x3c
	ldhl	sp,	#2
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
00128$:
;src/utils/entity.c:171: }
	add	sp, #14
	ret
;src/utils/entity.c:173: void entity_update_all(entity_t *entities, uint8_t count) {
;	---------------------------------
; Function entity_update_all
; ---------------------------------
_entity_update_all::
	add	sp, #-14
	ldhl	sp,	#11
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
	ld	(hl), a
;src/utils/entity.c:174: for (uint8_t i = 0; i < count; i++) {
	ldhl	sp,	#13
	ld	(hl), #0x00
00118$:
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#10
	sub	a, (hl)
	jp	NC, 00120$
;src/utils/entity.c:175: if (entities[i].active) {
	ldhl	sp,	#13
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
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0008
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
	jp	Z, 00119$
;src/utils/entity.c:176: if (entities[i].update && entities[i].death_timer == 0 &&
	pop	de
	push	de
	ld	hl, #0x0011
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	pop	de
	push	de
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
;src/utils/entity.c:177: entities[i].type != ENT_PORTAL)
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), a
;src/utils/entity.c:176: if (entities[i].update && entities[i].death_timer == 0 &&
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00102$
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00102$
;src/utils/entity.c:177: entities[i].type != ENT_PORTAL)
	inc	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x04
	jr	Z, 00102$
;src/utils/entity.c:178: entities[i].update(&entities[i]);
	pop	de
	push	de
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	call	___sdcc_call_hl
00102$:
;src/utils/entity.c:180: if (entities[i].hit_timer > 0)
	pop	de
	push	de
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00106$
;src/utils/entity.c:181: entities[i].hit_timer--;
	dec	a
	ld	(bc), a
00106$:
;src/utils/entity.c:182: if (entities[i].death_timer > 0) {
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	Z, 00119$
;src/utils/entity.c:183: entities[i].death_timer--;
	dec	hl
	dec	a
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	ld	(hl), a
;src/utils/entity.c:184: if (entities[i].death_timer == 0) {
	or	a, a
	jr	NZ, 00119$
;src/utils/entity.c:185: if (entities[i].type == ENT_ENEMY) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x03
	jr	NZ, 00108$
;src/utils/entity.c:186: entities[i].type = ENT_PORTAL;
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	(hl), #0x04
;src/utils/entity.c:187: entities[i].health = 0;       // Not pickable/hittable
	pop	de
	push	de
	ld	hl, #0x000e
	add	hl, de
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
;src/utils/entity.c:188: entities[i].sprite_base = 41; // Use portal tiles
	pop	de
	push	de
	ld	hl, #0x0007
	add	hl, de
	ld	(hl), #0x29
;src/utils/entity.c:189: text_dialogue("¡SE HA ABIERTO\nUN PORTAL!");
	ld	de, #___str_0
	call	_text_dialogue
	jr	00119$
00108$:
;src/utils/entity.c:191: entities[i].active = 0;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00119$:
;src/utils/entity.c:174: for (uint8_t i = 0; i < count; i++) {
	ldhl	sp,	#13
	inc	(hl)
	jp	00118$
00120$:
;src/utils/entity.c:197: }
	add	sp, #14
	ret
___str_0:
	.db 0xc2
	.db 0xa1
	.ascii "SE HA ABIERTO"
	.db 0x0a
	.ascii "UN PORTAL!"
	.db 0x00
;src/utils/entity.c:199: void entity_render_all(entity_t *entities, uint8_t count, uint16_t camera_x,
;	---------------------------------
; Function entity_render_all
; ---------------------------------
_entity_render_all::
	add	sp, #-15
	ldhl	sp,	#11
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
	ld	(hl), a
;src/utils/entity.c:201: for (uint8_t i = 0; i < count; i++) {
	ldhl	sp,	#13
	ld	(hl), #0x00
00176$:
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#10
	sub	a, (hl)
	jp	NC, 00177$
;src/utils/entity.c:202: entity_t *e = &entities[i];
	ldhl	sp,	#13
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
	ldhl	sp,	#11
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
;src/utils/entity.c:203: if (!e->active) {
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ldhl	sp,	#14
	ld	(hl), a
	ld	a, (hl)
;src/utils/entity.c:204: for (int j = 0; j < 4; j++)
	or	a, a
	jr	NZ, 00103$
	ld	c, a
00158$:
	ld	a, c
	sub	a, #0x04
	jp	NC, 00140$
;src/utils/entity.c:205: move_sprite(sprite_offset + (i * 4) + j, 0, 0);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, a
	add	a, a
	ldhl	sp,	#21
	ld	b, (hl)
	add	a, b
	ld	b, c
	add	a, b
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
;src/utils/entity.c:204: for (int j = 0; j < 4; j++)
	inc	c
	jr	00158$
;src/utils/entity.c:206: continue;
00103$:
;src/utils/entity.c:209: uint16_t esx = e->x - camera_x + 8, esy = e->y - camera_y + 16;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#17
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	b, (hl)
	ld	e, a
	ld	d, b
	ldhl	sp,	#19
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	c, e
	ldhl	sp,	#4
	ld	(hl), c
	inc	hl
	ld	(hl-), a
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
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;src/utils/entity.c:210: uint8_t use_clipping = (current_map == &maps[2] ||
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 52))
	jr	NZ, 00449$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 52))
	jr	Z, 00180$
00449$:
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 104))
	jr	NZ, 00450$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 104))
	jr	Z, 00180$
00450$:
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 156))
	jr	NZ, 00451$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 156))
	jr	Z, 00180$
00451$:
	xor	a, a
	jr	00181$
00180$:
	ld	a, #0x01
00181$:
	ldhl	sp,	#4
	ld	(hl), a
;src/utils/entity.c:214: if (e->hit_timer > 0 && (e->hit_timer & 2)) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00106$
	bit	1, a
	jr	Z, 00106$
;src/utils/entity.c:215: for (int j = 0; j < 4; j++)
	ld	c, #0x00
00161$:
	ld	a, c
	sub	a, #0x04
	jp	NC, 00140$
;src/utils/entity.c:216: move_sprite(sprite_offset + (i * 4) + j, 0, 0);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, a
	add	a, a
	ldhl	sp,	#21
	ld	b, (hl)
	add	a, b
	ld	b, c
	add	a, b
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
;src/utils/entity.c:215: for (int j = 0; j < 4; j++)
	inc	c
	jr	00161$
;src/utils/entity.c:217: continue;
00106$:
;src/utils/entity.c:220: if (esx < 168 && esy < 160) {
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0xa8
	ld	a, b
	sbc	a, #0x00
	jp	NC, 00140$
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0xa0
	ld	a, (hl)
	sbc	a, #0x00
	jp	NC, 00140$
;src/utils/entity.c:221: if (e->death_timer > 0) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00135$
;src/utils/entity.c:223: for (int j = 0; j < 4; j++) {
	ldhl	sp,	#14
	ld	(hl), #0x00
00164$:
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00140$
;src/utils/entity.c:224: uint8_t sprite_id = sprite_offset + (i * 4) + j;
	dec	hl
	ld	a, (hl)
	add	a, a
	add	a, a
	ldhl	sp,	#21
	ld	c, (hl)
	add	a, c
	ldhl	sp,	#14
	ld	c, (hl)
	add	a, c
	ldhl	sp,	#9
	ld	(hl), a
;src/utils/entity.c:225: uint16_t ty = esy + (j >= 2 ? 8 : 0);
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x02
	jr	C, 00185$
	ld	a, #0x08
	jr	00186$
00185$:
	xor	a, a
00186$:
	ldhl	sp,	#5
	ld	c, (hl)
;src/utils/entity.c:226: if (!use_clipping || ty < 140) {
	dec	hl
	add	a, c
	ld	c, a
	ld	a, (hl)
	or	a, a
	jr	Z, 00108$
	ld	a, c
	sub	a, #0x8c
	jr	NC, 00109$
00108$:
;src/utils/entity.c:227: move_sprite(sprite_id, esx + (j % 2 ? 8 : 0), ty);
	ldhl	sp,	#2
	ld	b, (hl)
	ldhl	sp,	#14
	ld	a, (hl)
	and	a, #0x01
	ld	a, #0x08
	jr	NZ, 00188$
	xor	a, a
00188$:
	ld	e, b
	add	a, e
	ld	b, a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ldhl	sp,	#9
	ld	e, (hl)
	xor	a, a
	ld	d, a
	sla	e
	rl	d
	sla	e
	rl	d
	ld	hl, #_shadow_OAM
	add	hl, de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/utils/entity.c:228: set_sprite_tile(sprite_id, 45 + j);
	ldhl	sp,	#14
	ld	a, (hl)
	add	a, #0x2d
	ld	c, a
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl,#_shadow_OAM + 1
	add	hl,de
	inc	hl
	ld	(hl), c
;src/utils/entity.c:228: set_sprite_tile(sprite_id, 45 + j);
	jr	00165$
00109$:
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	ldhl	sp,	#9
	ld	e, (hl)
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, bc
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/utils/entity.c:230: move_sprite(sprite_id, 0, 0);
00165$:
;src/utils/entity.c:223: for (int j = 0; j < 4; j++) {
	ldhl	sp,	#14
	inc	(hl)
	jr	00164$
00135$:
;src/utils/entity.c:233: } else if (e->type == ENT_PORTAL) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	cp	a, #0x04
	jr	NZ, 00132$
;src/utils/entity.c:235: for (int j = 0; j < 4; j++) {
	ld	c, #0x00
00167$:
	ld	a, c
	sub	a, #0x04
	jp	NC, 00140$
;src/utils/entity.c:236: uint8_t sprite_id = sprite_offset + (i * 4) + j;
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, a
	add	a, a
	ldhl	sp,	#21
	ld	b, (hl)
	add	a, b
	ld	b, c
	add	a, b
	ld	b, a
;src/utils/entity.c:237: uint16_t ty = esy + (j >= 2 ? 8 : 0);
	ld	a, c
	sub	a, #0x02
	jr	C, 00189$
	ld	a, #0x08
	jr	00190$
00189$:
	xor	a, a
00190$:
	ldhl	sp,	#5
	ld	e, (hl)
;src/utils/entity.c:238: if (!use_clipping || ty < 140) {
	dec	hl
	add	a, e
	ld	e, a
	ld	a, (hl)
	or	a, a
	jr	Z, 00113$
	ld	a, e
	sub	a, #0x8c
	jr	NC, 00114$
00113$:
;src/utils/entity.c:239: move_sprite(sprite_id, esx + (j % 2 ? 8 : 0), ty);
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#14
	ld	(hl), a
	ld	a, c
	and	a, #0x01
	ld	a, #0x08
	jr	NZ, 00192$
	xor	a, a
00192$:
	ldhl	sp,	#14
	ld	d, (hl)
	add	a, d
	ld	(hl), a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, b
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	b, l
	ld	d, h
	ld	a, #<(_shadow_OAM)
	add	a, b
	ld	l, a
	ld	a, #>(_shadow_OAM)
	adc	a, d
	ld	h, a
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	push	hl
	ldhl	sp,	#16
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/utils/entity.c:240: set_sprite_tile(sprite_id, 41 + j);
	ld	a, c
	add	a, #0x29
	ld	e, a
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	a, #<(_shadow_OAM)
	add	a, b
	ld	l, a
	ld	a, #>(_shadow_OAM)
	adc	a, d
	ld	h, a
	inc	hl
	inc	hl
	ld	(hl), e
;src/utils/entity.c:240: set_sprite_tile(sprite_id, 41 + j);
	jr	00168$
00114$:
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/utils/entity.c:242: move_sprite(sprite_id, 0, 0);
00168$:
;src/utils/entity.c:235: for (int j = 0; j < 4; j++) {
	inc	c
	jr	00167$
00132$:
;src/utils/entity.c:245: } else if (e->type == ENT_ITEM) {
	dec	a
	jp	NZ, 00129$
;src/utils/entity.c:247: uint8_t sprite_id = sprite_offset + (i * 4);
	ldhl	sp,	#13
	ld	a, (hl)
	add	a, a
	add	a, a
	ldhl	sp,	#21
	ld	c, (hl)
	add	a, c
	ld	c, a
	ld	b, c
;src/utils/entity.c:248: uint16_t ty = esy + 4;
	ldhl	sp,	#5
;src/utils/entity.c:249: if (!use_clipping || ty < 140) {
	ld	a, (hl-)
	add	a, #0x04
	ld	e, a
	ld	a, (hl)
	or	a, a
	jr	Z, 00118$
	ld	a, e
	sub	a, #0x8c
	jr	NC, 00119$
00118$:
;src/utils/entity.c:250: move_sprite(sprite_id, esx + 4, ty);
	ldhl	sp,	#14
	ld	(hl), e
	ldhl	sp,	#2
	ld	a, (hl)
	add	a, #0x04
	ldhl	sp,	#5
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	(hl+), a
	ld	de, #_shadow_OAM+0
	xor	a, a
	sla	b
	adc	a, a
	sla	b
	adc	a, a
	ld	(hl), b
	inc	hl
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	ld	e, l
	ld	d, h
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(de), a
	inc	de
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(de), a
;src/utils/entity.c:251: set_sprite_tile(sprite_id, e->sprite_base + e->anim_frame);
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	b, a
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	add	a, b
	ld	b, a
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	de, #_shadow_OAM+0
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, b
	ld	(de), a
;src/utils/entity.c:251: set_sprite_tile(sprite_id, e->sprite_base + e->anim_frame);
	jr	00225$
00119$:
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/utils/entity.c:257: for (int j = 1; j < 4; j++)
00225$:
	ld	b, #0x01
00170$:
;src/utils/entity.c:258: move_sprite(sprite_offset + (i * 4) + j, 0, 0);
	ld	a,b
	cp	a,#0x04
	jp	NC,00140$
	add	a, c
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, a
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
;src/utils/entity.c:257: for (int j = 1; j < 4; j++)
	inc	b
	jr	00170$
00129$:
;src/utils/entity.c:260: uint8_t frame_offset = (e->anim_frame * 4);
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	add	a, a
	add	a, a
	ldhl	sp,	#7
;src/utils/entity.c:261: for (int j = 0; j < 4; j++) {
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,	#14
	ld	(hl), #0x00
00173$:
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00140$
;src/utils/entity.c:262: uint8_t sprite_id = sprite_offset + (i * 4) + j;
	dec	hl
	ld	a, (hl)
	add	a, a
	add	a, a
	ldhl	sp,	#21
	ld	e, (hl)
	add	a, e
	ldhl	sp,	#14
	ld	e, (hl)
	add	a, e
	ld	e, a
;src/utils/entity.c:263: uint16_t ty = esy + (j >= 2 ? 8 : 0);
	ld	a, (hl)
	sub	a, #0x02
	jr	C, 00193$
	ld	a, #0x08
	jr	00194$
00193$:
	xor	a, a
00194$:
	ldhl	sp,	#5
	ld	d, (hl)
;src/utils/entity.c:264: if (!use_clipping || ty < 140) {
	dec	hl
	add	a, d
	ld	d, a
	ld	a, (hl)
	or	a, a
	jr	Z, 00123$
	ld	a, d
	sub	a, #0x8c
	jr	NC, 00124$
00123$:
;src/utils/entity.c:265: move_sprite(sprite_id, esx + (j % 2 ? 8 : 0), ty);
	ldhl	sp,	#8
	ld	(hl), d
	ldhl	sp,	#2
	ld	d, (hl)
	ldhl	sp,	#14
	ld	a, (hl)
	and	a, #0x01
	ld	a, #0x08
	jr	NZ, 00196$
	xor	a, a
00196$:
	add	a, d
	ldhl	sp,	#9
	ld	(hl), a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, e
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	e, l
	ld	d, h
	ld	hl, #_shadow_OAM
	add	hl, de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	push	hl
	ldhl	sp,	#10
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	push	hl
	ldhl	sp,	#11
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/utils/entity.c:266: set_sprite_tile(sprite_id, e->sprite_base + frame_offset + j);
	ld	a, (bc)
	ldhl	sp,	#7
	add	a, (hl)
	ldhl	sp,	#14
	ld	l, (hl)
	add	a, l
	ldhl	sp,	#9
	ld	(hl), a
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl,#_shadow_OAM + 1
	add	hl,de
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(de), a
;src/utils/entity.c:266: set_sprite_tile(sprite_id, e->sprite_base + frame_offset + j);
	jr	00174$
00124$:
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
;src/utils/entity.c:268: move_sprite(sprite_id, 0, 0);
00174$:
;src/utils/entity.c:261: for (int j = 0; j < 4; j++) {
	ldhl	sp,	#14
	inc	(hl)
	jp	00173$
00140$:
;src/utils/entity.c:201: for (uint8_t i = 0; i < count; i++) {
	ldhl	sp,	#13
	inc	(hl)
	jp	00176$
00177$:
;src/utils/entity.c:274: }
	add	sp, #15
	pop	hl
	add	sp, #5
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
