;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module game
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _can_move
	.globl _is_solid
	.globl _update_player_sprite
	.globl _update_camera
	.globl _text_dialogue
	.globl _text_init
	.globl _input_held
	.globl _input_pressed
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _display_off
	.globl _camera_y
	.globl _camera_x
	.globl _anim_timer
	.globl _anim_frame
	.globl _player_dir
	.globl _player_y
	.globl _player_x
	.globl _game_init
	.globl _game_update
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_game_update_last_dir_10001_261:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_player_x::
	.ds 2
_player_y::
	.ds 2
_player_dir::
	.ds 1
_anim_frame::
	.ds 1
_anim_timer::
	.ds 1
_camera_x::
	.ds 2
_camera_y::
	.ds 2
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
;src/states/game.c:252: static uint8_t last_dir = 0;
	xor	a, a
	ld	hl, #_game_update_last_dir_10001_261
	ld	(hl), a
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/states/game.c:27: void update_camera() {
;	---------------------------------
; Function update_camera
; ---------------------------------
_update_camera::
;src/states/game.c:29: if (player_x > SCREEN_WIDTH / 2) {
	ld	hl, #_player_x
	ld	a, #0x50
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00102$
;src/states/game.c:30: camera_x = player_x - SCREEN_WIDTH / 2;
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	b, (hl)
	add	a, #0xb0
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	hl, #_camera_x
	ld	(hl), c
	inc	hl
	ld	(hl), a
	jr	00103$
00102$:
;src/states/game.c:32: camera_x = 0;
	xor	a, a
	ld	hl, #_camera_x
	ld	(hl+), a
	ld	(hl), a
00103$:
;src/states/game.c:35: if (player_y > SCREEN_HEIGHT / 2) {
	ld	hl, #_player_y
	ld	a, #0x48
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00105$
;src/states/game.c:36: camera_y = player_y - SCREEN_HEIGHT / 2;
	ld	a, (_player_y)
	ld	hl, #_player_y + 1
	ld	c, (hl)
	add	a, #0xb8
	ld	b, a
	ld	a, c
	adc	a, #0xff
	ld	hl, #_camera_y
	ld	(hl), b
	inc	hl
	ld	(hl), a
	jr	00106$
00105$:
;src/states/game.c:38: camera_y = 0;
	xor	a, a
	ld	hl, #_camera_y
	ld	(hl+), a
	ld	(hl), a
00106$:
;src/states/game.c:42: if (camera_x > WORLD_WIDTH - SCREEN_WIDTH) {
	ld	hl, #_camera_x
	ld	a, #0x60
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00108$
;src/states/game.c:43: camera_x = WORLD_WIDTH - SCREEN_WIDTH;
	ld	hl, #_camera_x
	ld	a, #0x60
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00108$:
;src/states/game.c:45: if (camera_y > WORLD_HEIGHT - SCREEN_HEIGHT) {
	ld	hl, #_camera_y
	ld	a, #0x70
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00110$
;src/states/game.c:46: camera_y = WORLD_HEIGHT - SCREEN_HEIGHT;
	ld	hl, #_camera_y
	ld	a, #0x70
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00110$:
;src/states/game.c:49: move_bkg(camera_x, camera_y);
	ld	a, (_camera_y)
	ld	c, a
	ld	a, (#_camera_x)
	ldh	(_SCX_REG + 0), a
;./gbdk/include/gb/gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/states/game.c:49: move_bkg(camera_x, camera_y);
;src/states/game.c:50: }
	ret
;src/states/game.c:52: void update_player_sprite() {
;	---------------------------------
; Function update_player_sprite
; ---------------------------------
_update_player_sprite::
	add	sp, #-3
;src/states/game.c:53: uint8_t base_tile = 0;
	ldhl	sp,	#0
;src/states/game.c:54: uint8_t prop = 0; // 0 or S_FLIPX
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	(hl), #0x00
;src/states/game.c:56: switch (player_dir) {
	ld	a, #0x03
	ld	hl, #_player_dir
	sub	a, (hl)
	jr	C, 00105$
;src/states/game.c:58: base_tile = 0 + (anim_frame * 4);
	ld	a, (_anim_frame)
	add	a, a
	add	a, a
;src/states/game.c:64: base_tile = 16 + (anim_frame * 4);
	ld	b, a
	add	a, #0x10
	ld	c, a
;src/states/game.c:56: switch (player_dir) {
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #00141$
	add	hl, de
	add	hl, de
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	jp	(hl)
00141$:
	.dw	00101$
	.dw	00102$
	.dw	00103$
	.dw	00104$
;src/states/game.c:57: case 0: // Down
00101$:
;src/states/game.c:58: base_tile = 0 + (anim_frame * 4);
	ldhl	sp,	#0
	ld	(hl), b
;src/states/game.c:59: break;
	jr	00105$
;src/states/game.c:60: case 1: // Up
00102$:
;src/states/game.c:61: base_tile = 8 + (anim_frame * 4);
	ld	a, b
	add	a, #0x08
	ldhl	sp,	#0
	ld	(hl), a
;src/states/game.c:62: break;
	jr	00105$
;src/states/game.c:63: case 2: // Left
00103$:
;src/states/game.c:64: base_tile = 16 + (anim_frame * 4);
	ldhl	sp,	#0
	ld	(hl), c
;src/states/game.c:65: break;
	jr	00105$
;src/states/game.c:66: case 3: // Right
00104$:
;src/states/game.c:67: base_tile = 16 + (anim_frame * 4);
	ldhl	sp,	#0
;src/states/game.c:68: prop = S_FLIPX;
	ld	a, c
	ld	(hl+), a
	inc	hl
	ld	(hl), #0x20
;src/states/game.c:70: }
00105$:
;src/states/game.c:72: if (prop == 0) {
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	NZ, 00107$
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	dec	hl
	dec	hl
	ld	de, #(_shadow_OAM + 2)
	ld	a, (hl)
	ld	(de), a
;src/states/game.c:74: set_sprite_tile(1, base_tile + 1); // TR
	ld	c, (hl)
	ld	b, c
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), b
;src/states/game.c:75: set_sprite_tile(2, base_tile + 2); // BL
	ld	b, c
	inc	b
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), b
;src/states/game.c:76: set_sprite_tile(3, base_tile + 3); // BR
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), c
;./gbdk/include/gb/gb.h:1946: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 3)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 7)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 11)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 15)
	ld	(hl), #0x00
;src/states/game.c:81: set_sprite_prop(3, 0);
	jr	00125$
00107$:
;src/states/game.c:84: set_sprite_tile(0, base_tile + 1); // TR of Left -> TL of Right
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(hl), a
	ld	a, (hl+)
	inc	a
	ld	(hl), a
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	de, #(_shadow_OAM + 2)
	ld	a, (hl-)
	dec	hl
	ld	(de), a
	ld	de, #(_shadow_OAM + 6)
;src/states/game.c:86: set_sprite_tile(2, base_tile + 3); // BR of Left -> BL of Right
	ld	a, (hl+)
	ld	(de), a
	ld	c, (hl)
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), c
;src/states/game.c:87: set_sprite_tile(3, base_tile + 2); // BL of Left -> BR of Right
	ldhl	sp,	#1
	ld	c, (hl)
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), c
;./gbdk/include/gb/gb.h:1946: shadow_OAM[nb].prop=prop;
	ld	hl, #(_shadow_OAM + 3)
	ld	(hl), #0x20
	ld	hl, #(_shadow_OAM + 7)
	ld	(hl), #0x20
	ld	hl, #(_shadow_OAM + 11)
	ld	(hl), #0x20
	ld	hl, #(_shadow_OAM + 15)
	ld	(hl), #0x20
;src/states/game.c:92: set_sprite_prop(3, S_FLIPX);
00125$:
;src/states/game.c:94: }
	add	sp, #3
	ret
;src/states/game.c:100: uint8_t is_solid(uint16_t x, uint16_t y) {
;	---------------------------------
; Function is_solid
; ---------------------------------
_is_solid::
;src/states/game.c:101: uint16_t tile_x = x / 8;
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
;src/states/game.c:102: uint16_t tile_y = y / 8;
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
;src/states/game.c:104: if (tile_x >= MAP_WIDTH || tile_y >= MAP_HEIGHT)
	ld	l, e
	ld	h, d
	ld	a, l
	sub	a, #0x20
	ld	a, h
	sbc	a, #0x00
	jr	NC, 00101$
	ld	l, c
	ld	h, b
	ld	a, l
	sub	a, #0x20
	ld	a, h
	sbc	a, #0x00
	jr	C, 00102$
00101$:
;src/states/game.c:105: return 1;
	ld	a, #0x01
	ret
00102$:
;src/states/game.c:107: uint16_t tile_index = tile_y * MAP_WIDTH + tile_x;
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, de
;src/states/game.c:108: uint8_t tile_id = map_data[tile_index];
	ld	bc, #_map_data
	add	hl, bc
	ld	a, (hl)
;src/states/game.c:112: if (tile_id == 0 || tile_id == 2 || tile_id == 3 || tile_id == 4) {
	or	a, a
	jr	Z, 00104$
	cp	a, #0x02
	jr	Z, 00104$
	cp	a, #0x03
	jr	Z, 00104$
	sub	a, #0x04
	jr	NZ, 00105$
00104$:
;src/states/game.c:113: return 0;
	xor	a, a
	ret
00105$:
;src/states/game.c:115: return 1;
	ld	a, #0x01
;src/states/game.c:116: }
	ret
;src/states/game.c:119: uint8_t can_move(uint16_t new_x, uint16_t new_y) {
;	---------------------------------
; Function can_move
; ---------------------------------
_can_move::
;src/states/game.c:121: if (new_x < 8)
	add	sp, #-4
	push	de
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, #0x08
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00102$
;src/states/game.c:122: return 0;
	xor	a, a
	jp	00117$
00102$:
;src/states/game.c:123: if (new_x > WORLD_WIDTH - 24)
	ld	a, #0xe8
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	NC, 00104$
;src/states/game.c:124: return 0;
	xor	a, a
	jp	00117$
00104$:
;src/states/game.c:125: if (new_y < 16)
	ldhl	sp,	#2
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x10
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00106$
;src/states/game.c:126: return 0;
	xor	a, a
	jr	00117$
00106$:
;src/states/game.c:127: if (new_y > WORLD_HEIGHT - 24)
	ld	a, #0xe8
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	NC, 00108$
;src/states/game.c:128: return 0;
	xor	a, a
	jr	00117$
00108$:
;src/states/game.c:132: if (is_solid(new_x + 4, new_y + 8))
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), e
	inc	hl
	ld	(hl-), a
	push	bc
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_is_solid
	pop	bc
	or	a, a
	jr	Z, 00110$
;src/states/game.c:133: return 0;
	xor	a, a
	jr	00117$
00110$:
;src/states/game.c:135: if (is_solid(new_x + 11, new_y + 8))
	pop	de
	push	de
	ld	hl, #0x000b
	add	hl, de
	ld	e, l
	ld	d, h
	push	de
	call	_is_solid
	pop	de
	or	a, a
	jr	Z, 00112$
;src/states/game.c:136: return 0;
	xor	a, a
	jr	00117$
00112$:
;src/states/game.c:138: if (is_solid(new_x + 4, new_y + 15))
	push	de
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
	add	hl, de
	pop	de
	ld	c, l
	ld	b, h
	push	bc
	push	de
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_is_solid
	pop	de
	pop	bc
	or	a, a
	jr	Z, 00114$
;src/states/game.c:139: return 0;
	xor	a, a
	jr	00117$
00114$:
;src/states/game.c:141: if (is_solid(new_x + 11, new_y + 15))
	call	_is_solid
	or	a, a
	jr	Z, 00116$
;src/states/game.c:142: return 0;
	xor	a, a
	jr	00117$
00116$:
;src/states/game.c:144: return 1;
	ld	a, #0x01
00117$:
;src/states/game.c:145: }
	add	sp, #6
	ret
;src/states/game.c:147: void game_init(void) {
;	---------------------------------
; Function game_init
; ---------------------------------
_game_init::
;src/states/game.c:148: DISPLAY_OFF;
	call	_display_off
;src/states/game.c:151: set_bkg_data(0, 12, tiles_data);
	ld	de, #_tiles_data
	push	de
	ld	hl, #0xc00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:152: set_bkg_tiles(0, 0, MAP_WIDTH, MAP_HEIGHT, map_data);
	ld	de, #_map_data
	push	de
	ld	hl, #0x2020
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/states/game.c:155: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/states/game.c:156: OBP0_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
;src/states/game.c:157: OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
;src/states/game.c:160: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:161: set_sprite_data(0, 24, player_sprites);
	ld	de, #_player_sprites
	push	de
	ld	hl, #0x1800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:162: set_sprite_data(24, 4, npc_dog_sprite); // NPC dog at tiles 24-27
	ld	de, #_npc_dog_sprite
	push	de
	ld	hl, #0x418
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:167: update_camera();
	call	_update_camera
;src/states/game.c:168: move_sprite(0, player_x - camera_x + 8, player_y - camera_y + 16);
	ld	a, (_player_y)
	ld	hl, #_camera_y
	ld	c, (hl)
	sub	a, c
	add	a, #0x10
	ld	b, a
	ld	a, (_player_x)
	ld	hl, #_camera_x
	ld	c, (hl)
	sub	a, c
	add	a, #0x08
	ld	c, a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/states/game.c:169: move_sprite(1, player_x - camera_x + 16, player_y - camera_y + 16);
	ld	a, (_player_y)
	ld	hl, #_camera_y
	ld	c, (hl)
	sub	a, c
	add	a, #0x10
	ld	b, a
	ld	a, (_player_x)
	ld	hl, #_camera_x
	ld	c, (hl)
	sub	a, c
	add	a, #0x10
	ld	c, a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/states/game.c:170: move_sprite(2, player_x - camera_x + 8, player_y - camera_y + 24);
	ld	a, (_player_y)
	ld	hl, #_camera_y
	ld	c, (hl)
	sub	a, c
	add	a, #0x18
	ld	b, a
	ld	a, (_player_x)
	ld	hl, #_camera_x
	ld	c, (hl)
	sub	a, c
	add	a, #0x08
	ld	c, a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/states/game.c:171: move_sprite(3, player_x - camera_x + 16, player_y - camera_y + 24);
	ld	a, (_player_y)
	ld	hl, #_camera_y
	ld	c, (hl)
	sub	a, c
	add	a, #0x18
	ld	b, a
	ld	a, (_player_x)
	ld	hl, #_camera_x
	ld	c, (hl)
	sub	a, c
	add	a, #0x10
	ld	c, a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 12)
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/states/game.c:174: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:177: text_init();
	call	_text_init
;src/states/game.c:179: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:180: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:181: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:182: }
	ret
;src/states/game.c:184: void game_update(void) {
;	---------------------------------
; Function game_update
; ---------------------------------
_game_update::
	add	sp, #-4
;src/states/game.c:185: uint8_t moved = 0;
	ldhl	sp,	#3
	ld	(hl), #0x00
;src/states/game.c:186: uint16_t new_x = player_x;
	ld	a, (_player_x)
	ld	e, a
	ld	hl, #_player_x + 1
	ld	d, (hl)
;src/states/game.c:187: uint16_t new_y = player_y;
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
;src/states/game.c:189: if (input_held(J_UP)) {
	push	bc
	push	de
	ld	a, #0x04
	call	_input_held
	pop	de
	pop	bc
	or	a, a
	jr	Z, 00110$
;src/states/game.c:190: new_y--;
	dec	bc
;src/states/game.c:191: player_dir = 1;
	ld	hl, #_player_dir
	ld	(hl), #0x01
;src/states/game.c:192: moved = 1;
	ldhl	sp,	#3
	ld	(hl), #0x01
	jr	00111$
00110$:
;src/states/game.c:193: } else if (input_held(J_DOWN)) {
	push	bc
	push	de
	ld	a, #0x08
	call	_input_held
	pop	de
	pop	bc
	or	a, a
	jr	Z, 00107$
;src/states/game.c:194: new_y++;
	inc	bc
;src/states/game.c:195: player_dir = 0;
	xor	a, a
	ld	(#_player_dir),a
;src/states/game.c:196: moved = 1;
	ldhl	sp,	#3
	ld	(hl), #0x01
	jr	00111$
00107$:
;src/states/game.c:197: } else if (input_held(J_LEFT)) {
	push	bc
	push	de
	ld	a, #0x02
	call	_input_held
	pop	de
	pop	bc
	or	a, a
	jr	Z, 00104$
;src/states/game.c:198: new_x--;
	dec	de
;src/states/game.c:199: player_dir = 2;
	ld	hl, #_player_dir
	ld	(hl), #0x02
;src/states/game.c:200: moved = 1;
	ldhl	sp,	#3
	ld	(hl), #0x01
	jr	00111$
00104$:
;src/states/game.c:201: } else if (input_held(J_RIGHT)) {
	push	bc
	push	de
	ld	a, #0x01
	call	_input_held
	pop	de
	pop	bc
	or	a, a
	jr	Z, 00111$
;src/states/game.c:202: new_x++;
	inc	de
;src/states/game.c:203: player_dir = 3;
	ld	hl, #_player_dir
	ld	(hl), #0x03
;src/states/game.c:204: moved = 1;
	ldhl	sp,	#3
	ld	(hl), #0x01
00111$:
;src/states/game.c:207: if (moved) {
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, a
	jp	Z, 00124$
;src/states/game.c:209: uint8_t can_walk = can_move(new_x, new_y);
	push	bc
	push	de
	call	_can_move
	ldhl	sp,	#7
	ld	(hl), a
	pop	de
	pop	bc
	ldhl	sp,	#3
	ld	a, (hl-)
	dec	hl
;src/states/game.c:210: if (can_walk) {
	ld	(hl+), a
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00113$
;src/states/game.c:211: player_x = new_x;
	ld	hl, #_player_x
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:212: player_y = new_y;
	ld	hl, #_player_y
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:214: update_camera();
	call	_update_camera
;src/states/game.c:218: uint16_t screen_x = player_x - camera_x + 8;
	ld	a, (#_player_x)
	ld	hl, #_camera_x
	sub	a, (hl)
	ld	c, a
	ld	a, (#_player_x + 1)
	ld	hl, #_camera_x + 1
	sbc	a, (hl)
	ld	b, a
	ld	hl, #0x0008
	add	hl, bc
	ld	e, l
;src/states/game.c:219: uint16_t screen_y = player_y - camera_y + 16;
	ld	a, (#_player_y)
	ld	hl, #_camera_y
	sub	a, (hl)
	ld	c, a
	ld	a, (#_player_y + 1)
	ld	hl, #_camera_y + 1
	sbc	a, (hl)
	ld	b, a
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#2
	ld	(hl), c
	inc	hl
;src/states/game.c:221: move_sprite(0, screen_x, screen_y);
	ld	(hl-), a
	ld	b, (hl)
	ld	c, e
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/states/game.c:222: move_sprite(1, screen_x + 8, screen_y);
	ldhl	sp,	#2
	ld	c, (hl)
	ld	a, c
	ld	(hl+), a
	ld	a, e
	add	a, #0x08
	ld	b, a
	ld	(hl), b
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	push	hl
	ldhl	sp,	#4
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	push	hl
	ldhl	sp,	#5
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/states/game.c:223: move_sprite(2, screen_x, screen_y + 8);
	ld	a, c
	add	a, #0x08
	ld	c, a
	ldhl	sp,	#3
	ld	(hl), c
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	push	hl
	ldhl	sp,	#5
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	ld	(hl), e
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 12)
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:224: move_sprite(3, screen_x + 8, screen_y + 8);
00113$:
;src/states/game.c:228: if (can_walk) {
	ldhl	sp,	#1
	ld	a, (hl)
	or	a, a
	jr	Z, 00119$
;src/states/game.c:229: anim_timer++;
	ld	hl, #_anim_timer
	inc	(hl)
;src/states/game.c:230: if (anim_timer > 6) {
	ld	a, #0x06
	sub	a, (hl)
	jr	NC, 00125$
;src/states/game.c:231: anim_frame = !anim_frame;
	ld	hl, #_anim_frame
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/states/game.c:232: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
;src/states/game.c:233: update_player_sprite();
	call	_update_player_sprite
	jr	00125$
00119$:
;src/states/game.c:237: if (anim_frame != 0) {
	ld	hl, #_anim_frame
	ld	a, (hl)
	or	a, a
	jr	Z, 00125$
;src/states/game.c:238: anim_frame = 0;
	ld	(hl), #0x00
;src/states/game.c:239: update_player_sprite();
	call	_update_player_sprite
	jr	00125$
00124$:
;src/states/game.c:244: if (anim_frame != 0) {
	ld	hl, #_anim_frame
	ld	a, (hl)
	or	a, a
	jr	Z, 00122$
;src/states/game.c:245: anim_frame = 0;
	ld	(hl), #0x00
;src/states/game.c:246: update_player_sprite();
	call	_update_player_sprite
00122$:
;src/states/game.c:248: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
00125$:
;src/states/game.c:253: if (last_dir != player_dir) {
	ld	a, (#_game_update_last_dir_10001_261)
	ld	hl, #_player_dir
	sub	a, (hl)
	jr	Z, 00127$
;src/states/game.c:254: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:255: last_dir = player_dir;
	ld	a, (#_player_dir)
	ld	(#_game_update_last_dir_10001_261),a
00127$:
;src/states/game.c:264: uint16_t npc_screen_x = npc_x - camera_x + 8;
	ld	a, #0x78
	ld	hl, #_camera_x
	sub	a, (hl)
	inc	hl
	ld	c, a
	sbc	a, a
	sub	a, (hl)
	ld	b, a
	ld	hl, #0x0008
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#0
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/states/game.c:265: uint16_t npc_screen_y = npc_y - camera_y + 16;
	ld	a, #0x48
	ld	hl, #_camera_y
	sub	a, (hl)
	inc	hl
	ld	c, a
	sbc	a, a
	sub	a, (hl)
	ld	b, a
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#2
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/states/game.c:268: if (npc_screen_x < 168 && npc_screen_y < 160) {
	pop	bc
	push	bc
	ld	a, c
	sub	a, #0xa8
	ld	a, b
	sbc	a, #0x00
	jr	NC, 00129$
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0xa0
	ld	a, b
	sbc	a, #0x00
	jr	NC, 00129$
;src/states/game.c:269: move_sprite(4, npc_screen_x, npc_screen_y);
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	c, a
	ld	b, (hl)
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 16)
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:270: move_sprite(5, npc_screen_x + 8, npc_screen_y);
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(hl), a
	ld	b, (hl)
	ldhl	sp,	#0
	ld	a, (hl+)
	inc	hl
	ld	c, a
	add	a, #0x08
	ld	(hl), a
	ld	e, (hl)
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), e
;src/states/game.c:271: move_sprite(6, npc_screen_x, npc_screen_y + 8);
	ldhl	sp,	#3
	ld	a, (hl)
	add	a, #0x08
	ld	(hl), a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, (hl)
	ld	hl, #(_shadow_OAM + 24)
	ld	(hl+), a
	ld	(hl), c
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	de, #(_shadow_OAM + 28)
	ldhl	sp,	#3
	ld	a, (hl-)
	ld	(de), a
	ld	de, #(_shadow_OAM + 29)
	ld	a, (hl)
	ld	(de), a
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 18)
	ld	(hl), #0x18
	ld	hl, #(_shadow_OAM + 22)
	ld	(hl), #0x19
	ld	hl, #(_shadow_OAM + 26)
	ld	(hl), #0x1a
	ld	hl, #(_shadow_OAM + 30)
	ld	(hl), #0x1b
;src/states/game.c:278: set_sprite_tile(7, 27);
	jr	00130$
00129$:
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 16)
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 20)
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 24)
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 28)
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/states/game.c:283: move_sprite(7, 0, 0);
00130$:
;src/states/game.c:287: if (input_pressed(J_A)) {
	ld	a, #0x10
	call	_input_pressed
	ld	c, a
	or	a, a
	jr	Z, 00157$
;src/states/game.c:289: int16_t dx = (int16_t)player_x - npc_x;
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	c, (hl)
	add	a, #0x88
	ld	b, a
	ld	a, c
	adc	a, #0xff
	ld	c, a
;src/states/game.c:290: int16_t dy = (int16_t)player_y - npc_y;
	ld	a, (_player_y)
	ld	hl, #_player_y + 1
	ld	e, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), e
	pop	de
	push	de
	ld	hl, #0x0048
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	(hl), e
;src/states/game.c:291: if (dx < 0)
	ld	h, c
	bit	7, h
	jr	Z, 00133$
;src/states/game.c:292: dx = -dx;
	xor	a, a
	sub	a, b
	ld	b, a
	sbc	a, a
	sub	a, c
	ld	c, a
00133$:
;src/states/game.c:293: if (dy < 0)
	ldhl	sp,	#2
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#3
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00135$
;src/states/game.c:294: dy = -dy;
	inc	hl
	ld	de, #0x0000
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	(hl), e
00135$:
;src/states/game.c:297: if (dx < 24 && dy < 24) {
	ld	a, b
	sub	a, #0x18
	ld	a, c
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00157$
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x18
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00157$
;src/states/game.c:298: text_dialogue("HOLA AMIGO, QUE NECESITAS?");
	ld	de, #___str_0
	call	_text_dialogue
00157$:
;src/states/game.c:301: }
	add	sp, #4
	ret
___str_0:
	.ascii "HOLA AMIGO, QUE NECESITAS?"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__player_x:
	.dw #0x0050
__xinit__player_y:
	.dw #0x0048
__xinit__player_dir:
	.db #0x00	; 0
__xinit__anim_frame:
	.db #0x00	; 0
__xinit__anim_timer:
	.db #0x00	; 0
__xinit__camera_x:
	.dw #0x0000
__xinit__camera_y:
	.dw #0x0000
	.area _CABS (ABS)
