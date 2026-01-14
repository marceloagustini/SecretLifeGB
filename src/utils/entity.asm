;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module entity
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _entity_init
	.globl _ai_npc_static
	.globl _ai_enemy_random_walk
	.globl _ai_enemy_shooter
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
;src/utils/entity.c:5: void entity_init(entity_t *e, ent_type_t type, uint16_t x, uint16_t y,
;	---------------------------------
; Function entity_init
; ---------------------------------
_entity_init::
	ld	c, a
;src/utils/entity.c:7: e->type = type;
	ld	hl, #0x0004
	add	hl, de
	ld	(hl), c
;src/utils/entity.c:8: e->x = x;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
	dec	de
;src/utils/entity.c:9: e->y = y;
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	push	hl
	ldhl	sp,	#6
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	push	hl
	ldhl	sp,	#7
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/utils/entity.c:10: e->sprite_base = sprite_base;
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ldhl	sp,	#8
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/utils/entity.c:11: e->dialogue = dialogue;
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ldhl	sp,	#9
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	push	hl
	ldhl	sp,	#10
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/utils/entity.c:12: e->active = 1;
	ld	hl, #0x0008
	add	hl, de
	ld	(hl), #0x01
;src/utils/entity.c:13: e->dir = 0;
	ld	hl, #0x0009
	add	hl, de
	ld	(hl), #0x00
;src/utils/entity.c:14: e->anim_frame = 0;
	ld	hl, #0x000a
	add	hl, de
	ld	(hl), #0x00
;src/utils/entity.c:15: e->anim_timer = 0;
	ld	hl, #0x000b
	add	hl, de
	ld	(hl), #0x00
;src/utils/entity.c:16: e->move_timer = 0;
	ld	hl, #0x000c
	add	hl, de
	ld	(hl), #0x00
;src/utils/entity.c:19: e->update = ai_enemy_random_walk;
	ld	hl, #0x000d
	add	hl, de
;src/utils/entity.c:18: if (type == ENT_ENEMY) {
	ld	a, c
	sub	a, #0x03
	jr	NZ, 00102$
;src/utils/entity.c:19: e->update = ai_enemy_random_walk;
	ld	(hl), #<(_ai_enemy_random_walk)
	inc	hl
	ld	(hl), #>(_ai_enemy_random_walk)
	jr	00104$
00102$:
;src/utils/entity.c:21: e->update = ai_npc_static;
	ld	(hl), #<(_ai_npc_static)
	inc	hl
	ld	(hl), #>(_ai_npc_static)
00104$:
;src/utils/entity.c:23: }
	pop	hl
	add	sp, #7
	jp	(hl)
;src/utils/entity.c:25: void ai_npc_static(entity_t *self) {
;	---------------------------------
; Function ai_npc_static
; ---------------------------------
_ai_npc_static::
;src/utils/entity.c:28: }
	ret
;src/utils/entity.c:30: void ai_enemy_random_walk(entity_t *self) {
;	---------------------------------
; Function ai_enemy_random_walk
; ---------------------------------
_ai_enemy_random_walk::
	add	sp, #-4
	ldhl	sp,	#2
	ld	a, e
	ld	(hl+), a
;src/utils/entity.c:31: if (self->move_timer > 0) {
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
;src/utils/entity.c:32: self->move_timer--;
	dec	c
	pop	hl
	push	hl
	ld	(hl), c
;src/utils/entity.c:33: if (self->dir == 0) { // Down
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
;src/utils/entity.c:34: if (self->y < 240)
	ldhl	sp,	#2
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	inc	bc
	inc	bc
;src/utils/entity.c:33: if (self->dir == 0) { // Down
	or	a, a
	jr	NZ, 00122$
;src/utils/entity.c:34: if (self->y < 240)
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
;src/utils/entity.c:35: self->y++;
	inc	hl
	ld	a, l
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
	jr	00123$
00102$:
;src/utils/entity.c:37: self->move_timer = 0;
	pop	hl
	ld	(hl), #0x00
	push	hl
	jr	00123$
00122$:
;src/utils/entity.c:38: } else if (self->dir == 1) { // Up
	cp	a, #0x01
	jr	NZ, 00119$
;src/utils/entity.c:39: if (self->y > 16)
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
;src/utils/entity.c:40: self->y--;
	dec	hl
	ld	a, l
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
	jr	00123$
00105$:
;src/utils/entity.c:42: self->move_timer = 0;
	pop	hl
	ld	(hl), #0x00
	push	hl
	jr	00123$
00119$:
;src/utils/entity.c:44: if (self->x > 16)
	ldhl	sp,	#2
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
;src/utils/entity.c:43: } else if (self->dir == 2) { // Left
	cp	a, #0x02
	jr	NZ, 00116$
;src/utils/entity.c:44: if (self->x > 16)
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
;src/utils/entity.c:45: self->x--;
	dec	hl
	ld	a, l
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
	jr	00123$
00108$:
;src/utils/entity.c:47: self->move_timer = 0;
	pop	hl
	ld	(hl), #0x00
	push	hl
	jr	00123$
00116$:
;src/utils/entity.c:48: } else if (self->dir == 3) { // Right
	sub	a, #0x03
	jr	NZ, 00123$
;src/utils/entity.c:49: if (self->x < 240)
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
;src/utils/entity.c:50: self->x++;
	inc	hl
	ld	a, l
	ld	(bc), a
	inc	bc
	ld	a, h
	ld	(bc), a
	jr	00123$
00111$:
;src/utils/entity.c:52: self->move_timer = 0;
	pop	hl
	ld	(hl), #0x00
	push	hl
00123$:
;src/utils/entity.c:55: if (++self->anim_timer > 8) {
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
;src/utils/entity.c:56: self->anim_frame = !self->anim_frame;
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
;src/utils/entity.c:57: self->anim_timer = 0;
	xor	a, a
	ld	(bc), a
	jr	00132$
00130$:
;src/utils/entity.c:61: uint8_t r = DIV_REG & 0x0F;
	ldh	a, (_DIV_REG + 0)
	and	a, #0x0f
	ld	c, a
;src/utils/entity.c:33: if (self->dir == 0) { // Down
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	e, l
	ld	d, h
;src/utils/entity.c:62: if (r < 4)
;src/utils/entity.c:63: self->dir = r; // 0=D, 1=U, 2=L, 3=R
	ld	a,c
	cp	a,#0x04
	jr	NC, 00127$
	ld	(de), a
	jr	00128$
00127$:
;src/utils/entity.c:65: self->dir = -1; // Wait/Idle
	ld	a, #0xff
	ld	(de), a
00128$:
;src/utils/entity.c:66: self->move_timer = 30 + (DIV_REG & 0x1F);
	ldh	a, (_DIV_REG + 0)
	and	a, #0x1f
	add	a, #0x1e
	pop	hl
	push	hl
	ld	(hl), a
00132$:
;src/utils/entity.c:68: }
	add	sp, #4
	ret
;src/utils/entity.c:70: void ai_enemy_shooter(entity_t *self, uint16_t player_x, uint16_t player_y) {
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
;src/utils/entity.c:74: if (++self->move_timer > 60) { // Shoot every 60 frames (~1 second)
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
;src/utils/entity.c:75: self->move_timer = 0;
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/utils/entity.c:78: int16_t dx = (int16_t)player_x - (int16_t)self->x;
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
;src/utils/entity.c:79: int16_t dy = (int16_t)player_y - (int16_t)self->y;
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
;src/utils/entity.c:82: int8_t vx = 0, vy = 0;
	ld	a, e
	ld	(hl+), a
	inc	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/utils/entity.c:83: if (dx > 10)
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
;src/utils/entity.c:84: vx = 2;
	ldhl	sp,	#8
	ld	(hl), #0x02
	jr	00105$
00104$:
;src/utils/entity.c:85: else if (dx < -10)
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
;src/utils/entity.c:86: vx = -2;
	ldhl	sp,	#8
	ld	(hl), #0xfe
00105$:
;src/utils/entity.c:87: if (dy > 10)
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
;src/utils/entity.c:88: vy = 2;
	ldhl	sp,	#9
	ld	(hl), #0x02
	jr	00110$
00109$:
;src/utils/entity.c:89: else if (dy < -10)
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
;src/utils/entity.c:90: vy = -2;
	ldhl	sp,	#9
	ld	(hl), #0xfe
00110$:
;src/utils/entity.c:92: if (vx != 0 || vy != 0) {
	ldhl	sp,	#8
	ld	a, (hl)
	or	a, a
	jr	NZ, 00111$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00116$
00111$:
;src/utils/entity.c:93: projectile_spawn(self->x + 8, self->y + 8, vx, vy);
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
	ldhl	sp,	#9
	ld	a, (hl-)
	ld	d, a
	ld	a, (hl-)
	dec	hl
	ld	e, a
	push	de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_projectile_spawn
00116$:
;src/utils/entity.c:96: }
	add	sp, #14
	pop	hl
	pop	af
	jp	(hl)
;src/utils/entity.c:98: void entity_update_all(entity_t *entities, uint8_t count) {
;	---------------------------------
; Function entity_update_all
; ---------------------------------
_entity_update_all::
	add	sp, #-8
	ldhl	sp,	#5
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
	ld	(hl), a
;src/utils/entity.c:99: for (uint8_t i = 0; i < count; i++) {
	ldhl	sp,	#7
	ld	(hl), #0x00
00106$:
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#4
	sub	a, (hl)
	jr	NC, 00108$
;src/utils/entity.c:100: if (entities[i].active && entities[i].update) {
	ldhl	sp,	#7
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
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
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	or	a, a
	jr	Z, 00107$
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000d
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, b
	or	a, c
	jr	Z, 00107$
;src/utils/entity.c:101: entities[i].update(&entities[i]);
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	l, c
	ld	h, b
	call	___sdcc_call_hl
00107$:
;src/utils/entity.c:99: for (uint8_t i = 0; i < count; i++) {
	ldhl	sp,	#7
	inc	(hl)
	jr	00106$
00108$:
;src/utils/entity.c:104: }
	add	sp, #8
	ret
;src/utils/entity.c:106: void entity_render_all(entity_t *entities, uint8_t count, uint16_t camera_x,
;	---------------------------------
; Function entity_render_all
; ---------------------------------
_entity_render_all::
	add	sp, #-14
	ldhl	sp,	#10
	ld	(hl), e
	inc	hl
	ld	(hl), d
	dec	hl
	dec	hl
	ld	(hl), a
;src/utils/entity.c:108: for (uint8_t i = 0; i < count; i++) {
	ldhl	sp,	#12
	ld	(hl), #0x00
00126$:
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#9
	sub	a, (hl)
	jp	NC, 00127$
;src/utils/entity.c:109: entity_t *e = &entities[i];
	ldhl	sp,	#12
	ld	c, (hl)
	ld	b, #0x00
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#10
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
;src/utils/entity.c:110: if (!e->active) {
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
;src/utils/entity.c:111: for (int j = 0; j < 4; j++)
	or	a, a
	jr	NZ, 00103$
	ld	c, a
00117$:
	ld	a, c
	sub	a, #0x04
	jp	NC, 00110$
;src/utils/entity.c:112: move_sprite(sprite_offset + (i * 4) + j, 0, 0);
	ldhl	sp,	#12
	ld	a, (hl)
	add	a, a
	add	a, a
	ldhl	sp,	#20
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
;src/utils/entity.c:111: for (int j = 0; j < 4; j++)
	inc	c
	jr	00117$
;src/utils/entity.c:113: continue;
00103$:
;src/utils/entity.c:116: uint16_t esx = e->x - camera_x + 8, esy = e->y - camera_y + 16;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ldhl	sp,#16
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ld	c, e
	ld	b, a
	ld	hl, #0x0008
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#0
	ld	(hl), c
	inc	hl
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	b, (hl)
	ld	e, a
	ld	d, b
	ldhl	sp,	#18
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	c, e
	ld	b, a
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#2
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/utils/entity.c:117: if (esx < 168 && esy < 160) {
	pop	bc
	push	bc
	ld	a, c
	sub	a, #0xa8
	ld	a, b
	sbc	a, #0x00
	jp	NC, 00144$
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0xa0
	ld	a, b
	sbc	a, #0x00
	jp	NC, 00144$
;src/utils/entity.c:118: uint8_t frame_offset = (e->anim_frame * 4);
	ldhl	sp,#7
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
	ldhl	sp,	#4
	ld	(hl), a
;src/utils/entity.c:119: for (int j = 0; j < 4; j++) {
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#13
	ld	(hl), #0x00
00120$:
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00110$
;src/utils/entity.c:120: uint8_t sprite_id = sprite_offset + (i * 4) + j;
	dec	hl
	ld	a, (hl)
	add	a, a
	add	a, a
	ldhl	sp,	#20
	ld	c, (hl)
	add	a, c
	ldhl	sp,	#13
	ld	c, (hl)
	add	a, c
	ldhl	sp,	#7
	ld	(hl), a
;src/utils/entity.c:121: move_sprite(sprite_id, esx + (j % 2 ? 8 : 0), esy + (j >= 2 ? 8 : 0));
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	sub	a, #0x02
	jr	C, 00129$
	ld	a, #0x08
	jr	00130$
00129$:
	xor	a, a
00130$:
	ldhl	sp,	#8
	ld	c, (hl)
	add	a, c
	ld	c, a
	ldhl	sp,	#0
	ld	b, (hl)
	ldhl	sp,	#13
	ld	a, (hl)
	and	a, #0x01
	ld	a, #0x08
	jr	NZ, 00132$
	xor	a, a
00132$:
	add	a, b
	ld	b, a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ldhl	sp,	#7
	ld	e, (hl)
	xor	a, a
	sla	e
	adc	a, a
	sla	e
	adc	a, a
	ld	(hl), e
	inc	hl
	ld	(hl), a
	ld	de, #_shadow_OAM
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	add	hl, de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/utils/entity.c:122: set_sprite_tile(sprite_id, e->sprite_base + frame_offset + j);
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	add	a, (hl)
	ldhl	sp,	#13
	ld	c, (hl)
	add	a, c
	ld	c, a
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	de, #_shadow_OAM
	ldhl	sp,	#7
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, c
	ld	(de), a
;src/utils/entity.c:119: for (int j = 0; j < 4; j++) {
	ldhl	sp,	#13
	inc	(hl)
	jr	00120$
;src/utils/entity.c:125: for (int j = 0; j < 4; j++)
00144$:
	ld	c, #0x00
00123$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00110$
;src/utils/entity.c:126: move_sprite(sprite_offset + (i * 4) + j, 0, 0);
	ldhl	sp,	#12
	ld	a, (hl)
	add	a, a
	add	a, a
	ldhl	sp,	#20
	ld	b, (hl)
	add	a, b
	ld	b, c
	add	a, b
	ld	b, a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	ld	l, b
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/utils/entity.c:125: for (int j = 0; j < 4; j++)
	inc	c
	jr	00123$
00110$:
;src/utils/entity.c:108: for (uint8_t i = 0; i < count; i++) {
	ldhl	sp,	#12
	inc	(hl)
	jp	00126$
00127$:
;src/utils/entity.c:129: }
	add	sp, #14
	pop	hl
	add	sp, #5
	jp	(hl)
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
