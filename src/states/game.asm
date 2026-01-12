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
	.globl _load_location
	.globl _update_camera
	.globl _get_tile_at
	.globl _text_dialogue
	.globl _text_init
	.globl _input_held
	.globl _input_pressed
	.globl _fill_bkg_rect
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _display_off
	.globl _env_anim_frame
	.globl _env_anim_timer
	.globl _camera_y
	.globl _camera_x
	.globl _anim_timer
	.globl _anim_frame
	.globl _player_dir
	.globl _world_saved_y
	.globl _world_saved_x
	.globl _player_y
	.globl _player_x
	.globl _current_loc
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
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_current_loc::
	.ds 1
_player_x::
	.ds 2
_player_y::
	.ds 2
_world_saved_x::
	.ds 2
_world_saved_y::
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
_env_anim_timer::
	.ds 1
_env_anim_frame::
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
;src/states/game.c:33: uint8_t get_tile_at(uint16_t x, uint16_t y) {
;	---------------------------------
; Function get_tile_at
; ---------------------------------
_get_tile_at::
	add	sp, #-6
;src/states/game.c:34: uint16_t tx = x / 8;
	srl	d
	rr	e
	srl	d
	rr	e
	srl	d
	rr	e
	inc	sp
	inc	sp
	push	de
;src/states/game.c:35: uint16_t ty = y / 8;
	srl	b
	rr	c
	srl	b
	rr	c
	srl	b
	rr	c
;src/states/game.c:37: if (tx >= MAP_WIDTH || ty >= MAP_HEIGHT)
	ldhl	sp,	#0
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl+), a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:36: if (current_loc == LOC_WORLD) {
	ld	hl, #_current_loc
	bit	0, (hl)
	jr	NZ, 00108$
;src/states/game.c:37: if (tx >= MAP_WIDTH || ty >= MAP_HEIGHT)
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, #0x20
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00101$
	inc	hl
	ld	a, (hl+)
	sub	a, #0x20
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00102$
00101$:
;src/states/game.c:38: return 1;
	ld	a, #0x01
	jr	00110$
00102$:
;src/states/game.c:39: return map_data[ty * MAP_WIDTH + tx];
	ld	a, #0x05
00133$:
	ldhl	sp,	#4
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00133$
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	hl
	push	hl
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#6
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#5
	ld	(hl), a
	ld	de, #_map_data
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
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
	jr	00110$
00108$:
;src/states/game.c:41: if (tx >= HOUSE_WIDTH || ty >= HOUSE_HEIGHT)
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, #0x14
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00104$
	inc	hl
	ld	a, (hl+)
	sub	a, #0x12
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00105$
00104$:
;src/states/game.c:42: return 1;
	ld	a, #0x01
	jr	00110$
00105$:
;src/states/game.c:43: return house_map[ty * HOUSE_WIDTH + tx];
	ldhl	sp,#4
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
	ld	c, l
	ld	b, h
	pop	hl
	push	hl
	add	hl, bc
	ld	bc, #_house_map
	add	hl, bc
	ld	a, (hl)
00110$:
;src/states/game.c:45: }
	add	sp, #6
	ret
;src/states/game.c:47: void update_camera() {
;	---------------------------------
; Function update_camera
; ---------------------------------
_update_camera::
	add	sp, #-4
;src/states/game.c:48: uint16_t w = (current_loc == LOC_WORLD) ? (MAP_WIDTH * 8) : (HOUSE_WIDTH * 8);
	ld	hl, #_current_loc
	bit	0, (hl)
	jr	NZ, 00114$
	ld	de, #0x0100
	jr	00115$
00114$:
	ld	de, #0x00a0
00115$:
;src/states/game.c:49: uint16_t h =
	ld	hl, #_current_loc
	bit	0, (hl)
	jr	NZ, 00116$
	ld	bc, #0x0100
	jr	00117$
00116$:
	ld	bc, #0x0090
00117$:
;src/states/game.c:52: if (player_x > SCREEN_WIDTH / 2)
	ld	hl, #_player_x
	ld	a, #0x50
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00102$
;src/states/game.c:53: camera_x = player_x - SCREEN_WIDTH / 2;
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	h, (hl)
	add	a, #0xb0
	ld	l, a
	ld	a, h
	adc	a, #0xff
	ld	h, a
	ld	a, l
	ld	(_camera_x), a
	ld	a, h
	ld	(_camera_x + 1), a
	jr	00103$
00102$:
;src/states/game.c:55: camera_x = 0;
	xor	a, a
	ld	hl, #_camera_x
	ld	(hl+), a
	ld	(hl), a
00103$:
;src/states/game.c:57: if (player_y > SCREEN_HEIGHT / 2)
	ld	hl, #_player_y
	ld	a, #0x48
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00105$
;src/states/game.c:58: camera_y = player_y - SCREEN_HEIGHT / 2;
	ld	a, (_player_y)
	ld	hl, #_player_y + 1
	ld	h, (hl)
	add	a, #0xb8
	ld	l, a
	ld	a, h
	adc	a, #0xff
	ld	h, a
	ld	a, l
	ld	(_camera_y), a
	ld	a, h
	ld	(_camera_y + 1), a
	jr	00106$
00105$:
;src/states/game.c:60: camera_y = 0;
	xor	a, a
	ld	hl, #_camera_y
	ld	(hl+), a
	ld	(hl), a
00106$:
;src/states/game.c:62: if (camera_x > w - SCREEN_WIDTH)
	inc	sp
	inc	sp
	push	de
	ld	hl, #0x00a0
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#3
	ld	(hl-), a
	ld	(hl), e
	ld	a, (_camera_x)
	ld	e, a
	ld	hl, #_camera_x + 1
	ld	d, (hl)
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, e
	ld	a, (hl)
	sbc	a, d
	jr	NC, 00108$
;src/states/game.c:63: camera_x = (w > SCREEN_WIDTH) ? (w - SCREEN_WIDTH) : 0;
	ldhl	sp,	#0
	ld	a, #0xa0
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00118$
	ldhl	sp,	#2
	ld	a, (hl)
	jr	00119$
00118$:
	xor	a, a
00119$:
	ld	hl, #_camera_x
	ld	(hl+), a
	ld	(hl), #0x00
00108$:
;src/states/game.c:64: if (camera_y > h - SCREEN_HEIGHT)
	ld	e, c
	ld	d, b
	ld	a, e
	add	a, #0x70
	ld	c, a
	ld	a, d
	adc	a, #0xff
	ld	b, a
	ld	a, (_camera_y)
	ld	l, a
	ld	a, (_camera_y + 1)
	ld	h, a
	ld	a, c
	sub	a, l
	ld	a, b
	sbc	a, h
	jr	NC, 00110$
;src/states/game.c:65: camera_y = (h > SCREEN_HEIGHT) ? (h - SCREEN_HEIGHT) : 0;
	ld	a, #0x90
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	C, 00121$
	ld	c, #0x00
00121$:
	ld	hl, #_camera_y
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x00
00110$:
;src/states/game.c:67: move_bkg(camera_x, camera_y);
	ld	a, (_camera_y)
	ld	c, a
	ld	a, (#_camera_x)
	ldh	(_SCX_REG + 0), a
;./gbdk/include/gb/gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/states/game.c:67: move_bkg(camera_x, camera_y);
;src/states/game.c:68: }
	add	sp, #4
	ret
;src/states/game.c:70: void load_location(location_t loc) {
;	---------------------------------
; Function load_location
; ---------------------------------
_load_location::
	ld	c, a
;src/states/game.c:71: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:72: current_loc = loc;
	ld	hl, #_current_loc
	ld	(hl), c
;src/states/game.c:73: if (loc == LOC_WORLD) {
	bit	0, c
	jr	NZ, 00102$
;src/states/game.c:74: set_bkg_tiles(0, 0, MAP_WIDTH, MAP_HEIGHT, map_data);
	ld	de, #_map_data
	push	de
	ld	hl, #0x2020
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
	jr	00103$
00102$:
;src/states/game.c:76: fill_bkg_rect(0, 0, 32, 32, 26);
	ld	hl, #0x1a20
	push	hl
	ld	a, #0x20
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_fill_bkg_rect
	add	sp, #5
;src/states/game.c:77: set_bkg_tiles(0, 0, HOUSE_WIDTH, HOUSE_HEIGHT, house_map);
	ld	de, #_house_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
00103$:
;src/states/game.c:79: update_camera();
	call	_update_camera
;src/states/game.c:80: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:81: }
	ret
;src/states/game.c:83: void update_player_sprite() {
;	---------------------------------
; Function update_player_sprite
; ---------------------------------
_update_player_sprite::
	add	sp, #-3
;src/states/game.c:84: uint8_t base_tile = 0;
	ldhl	sp,	#0
;src/states/game.c:85: uint8_t prop = 0;
	xor	a, a
	ld	(hl+), a
	inc	hl
	ld	(hl), #0x00
;src/states/game.c:86: switch (player_dir) {
	ld	a, #0x03
	ld	hl, #_player_dir
	sub	a, (hl)
	jr	C, 00105$
;src/states/game.c:88: base_tile = 0 + (anim_frame * 4);
	ld	a, (_anim_frame)
	add	a, a
	add	a, a
;src/states/game.c:94: base_tile = 16 + (anim_frame * 4);
	ld	b, a
	add	a, #0x10
	ld	c, a
;src/states/game.c:86: switch (player_dir) {
	ld	e, (hl)
	ld	d, #0x00
	ld	hl, #00173$
	add	hl, de
	add	hl, de
	ld	e, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, e
	jp	(hl)
00173$:
	.dw	00101$
	.dw	00102$
	.dw	00103$
	.dw	00104$
;src/states/game.c:87: case 0:
00101$:
;src/states/game.c:88: base_tile = 0 + (anim_frame * 4);
	ldhl	sp,	#0
	ld	(hl), b
;src/states/game.c:89: break;
	jr	00105$
;src/states/game.c:90: case 1:
00102$:
;src/states/game.c:91: base_tile = 8 + (anim_frame * 4);
	ld	a, b
	add	a, #0x08
	ldhl	sp,	#0
	ld	(hl), a
;src/states/game.c:92: break;
	jr	00105$
;src/states/game.c:93: case 2:
00103$:
;src/states/game.c:94: base_tile = 16 + (anim_frame * 4);
	ldhl	sp,	#0
	ld	(hl), c
;src/states/game.c:95: break;
	jr	00105$
;src/states/game.c:96: case 3:
00104$:
;src/states/game.c:97: base_tile = 16 + (anim_frame * 4);
	ldhl	sp,	#0
;src/states/game.c:98: prop = S_FLIPX;
	ld	a, c
	ld	(hl+), a
	inc	hl
	ld	(hl), #0x20
;src/states/game.c:100: }
00105$:
;src/states/game.c:101: if (prop == 0) {
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	NZ, 00109$
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	dec	hl
	dec	hl
	ld	de, #(_shadow_OAM + 2)
	ld	a, (hl)
	ld	(de), a
;src/states/game.c:103: set_sprite_tile(1, base_tile + 1);
	ld	c, (hl)
	ld	b, c
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), b
;src/states/game.c:104: set_sprite_tile(2, base_tile + 2);
	ld	b, c
	inc	b
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), b
;src/states/game.c:105: set_sprite_tile(3, base_tile + 3);
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), c
;src/states/game.c:106: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00122$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00127$
;src/states/game.c:107: set_sprite_prop(i, 0);
;./gbdk/include/gb/gb.h:1946: shadow_OAM[nb].prop=prop;
	ld	l, c
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;src/states/game.c:106: for (int i = 0; i < 4; i++)
	inc	c
	jr	00122$
00109$:
;src/states/game.c:109: set_sprite_tile(0, base_tile + 1);
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
;src/states/game.c:111: set_sprite_tile(2, base_tile + 3);
	ld	a, (hl+)
	ld	(de), a
	ld	c, (hl)
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), c
;src/states/game.c:112: set_sprite_tile(3, base_tile + 2);
	ldhl	sp,	#1
	ld	c, (hl)
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), c
;src/states/game.c:113: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00125$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00127$
;src/states/game.c:114: set_sprite_prop(i, S_FLIPX);
;./gbdk/include/gb/gb.h:1946: shadow_OAM[nb].prop=prop;
	ld	l, c
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x20
;src/states/game.c:113: for (int i = 0; i < 4; i++)
	inc	c
	jr	00125$
00127$:
;src/states/game.c:116: }
	add	sp, #3
	ret
;src/states/game.c:118: uint8_t is_solid(uint16_t x, uint16_t y) {
;	---------------------------------
; Function is_solid
; ---------------------------------
_is_solid::
;src/states/game.c:119: uint8_t tid = get_tile_at(x, y);
	call	_get_tile_at
	ld	c, a
;src/states/game.c:120: if (current_loc == LOC_WORLD) {
	ld	hl, #_current_loc
	bit	0, (hl)
	jr	NZ, 00113$
;src/states/game.c:121: if (tid == 0 || tid == 2 || tid == 3 || tid == 4 || tid == 5 || tid == 21 ||
	ld	a, c
	or	a, a
	jr	Z, 00101$
	ld	a,c
	cp	a,#0x02
	jr	Z, 00101$
	cp	a,#0x03
	jr	Z, 00101$
	cp	a,#0x04
	jr	Z, 00101$
;src/states/game.c:122: tid == 22)
	cp	a,#0x05
	jr	Z, 00101$
	cp	a,#0x15
	jr	Z, 00101$
	sub	a, #0x16
	jr	NZ, 00114$
00101$:
;src/states/game.c:123: return 0;
	xor	a, a
	ret
00113$:
;src/states/game.c:125: if (tid == 25 || tid == 35)
	ld	a,c
	cp	a,#0x19
	jr	Z, 00109$
	sub	a, #0x23
	jr	NZ, 00114$
00109$:
;src/states/game.c:126: return 0;
	xor	a, a
	ret
00114$:
;src/states/game.c:128: return 1;
	ld	a, #0x01
;src/states/game.c:129: }
	ret
;src/states/game.c:131: uint8_t can_move(uint16_t nx, uint16_t ny) {
;	---------------------------------
; Function can_move
; ---------------------------------
_can_move::
	add	sp, #-8
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:132: uint16_t w = (current_loc == LOC_WORLD) ? (MAP_WIDTH * 8) : (HOUSE_WIDTH * 8);
	ld	hl, #_current_loc
	bit	0, (hl)
	jr	NZ, 00113$
	ld	bc, #0x0100
	jr	00114$
00113$:
	ld	bc, #0x00a0
00114$:
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:133: uint16_t h =
	ld	hl, #_current_loc
	bit	0, (hl)
	jr	NZ, 00115$
	ld	bc, #0x0100
	jr	00116$
00115$:
	ld	bc, #0x0090
00116$:
;src/states/game.c:135: if (nx < 4 || nx > w - 20 || ny < 8 || ny > h - 20)
	inc	sp
	inc	sp
	push	de
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, #0x04
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00101$
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	d, (hl)
	add	a, #0xec
	ld	e, a
	ld	a, d
	adc	a, #0xff
	ld	d, a
	ldhl	sp,	#0
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00101$
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x08
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00101$
	dec	hl
	ld	a, c
	add	a, #0xec
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00102$
00101$:
;src/states/game.c:136: return 0;
	xor	a, a
	jr	00111$
00102$:
;src/states/game.c:137: if (is_solid(nx + 4, ny + 8) || is_solid(nx + 11, ny + 8) ||
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
	jr	NZ, 00106$
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
	jr	NZ, 00106$
;src/states/game.c:138: is_solid(nx + 4, ny + 15) || is_solid(nx + 11, ny + 15))
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
	jr	NZ, 00106$
	call	_is_solid
	or	a, a
	jr	Z, 00107$
00106$:
;src/states/game.c:139: return 0;
	xor	a, a
	jr	00111$
00107$:
;src/states/game.c:140: return 1;
	ld	a, #0x01
00111$:
;src/states/game.c:141: }
	add	sp, #8
	ret
;src/states/game.c:143: void game_init(void) {
;	---------------------------------
; Function game_init
; ---------------------------------
_game_init::
;src/states/game.c:144: DISPLAY_OFF;
	call	_display_off
;src/states/game.c:145: set_bkg_data(0, 36, tiles_data);
	ld	de, #_tiles_data
	push	de
	ld	hl, #0x2400
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:146: load_location(LOC_WORLD);
	xor	a, a
	call	_load_location
;src/states/game.c:147: BGP_REG = OBP0_REG = OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/states/game.c:148: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:149: set_sprite_data(0, 24, player_sprites);
	ld	de, #_player_sprites
	push	de
	ld	hl, #0x1800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:150: set_sprite_data(24, 4, npc_child_sprite);
	ld	de, #_npc_child_sprite
	push	de
	ld	hl, #0x418
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:151: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:152: text_init();
	call	_text_init
;src/states/game.c:153: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:154: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:155: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:156: }
	ret
;src/states/game.c:158: void game_update(void) {
;	---------------------------------
; Function game_update
; ---------------------------------
_game_update::
	add	sp, #-12
;src/states/game.c:159: uint8_t moved = 0;
	ld	c, #0x00
;src/states/game.c:160: uint16_t nx = player_x;
	ld	a, (#_player_x)
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#9
	ld	(hl), a
;src/states/game.c:161: uint16_t ny = player_y;
	ld	a, (#_player_y)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#11
	ld	(hl), a
;src/states/game.c:163: if (input_held(J_UP)) {
	push	bc
	ld	a, #0x04
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00110$
;src/states/game.c:164: ny--;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:165: player_dir = 1;
	ld	hl, #_player_dir
	ld	(hl), #0x01
;src/states/game.c:166: moved = 1;
	ld	c, #0x01
	jr	00111$
00110$:
;src/states/game.c:167: } else if (input_held(J_DOWN)) {
	push	bc
	ld	a, #0x08
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00107$
;src/states/game.c:168: ny++;
	ldhl	sp,	#10
	inc	(hl)
	jr	NZ, 00366$
	inc	hl
	inc	(hl)
00366$:
;src/states/game.c:169: player_dir = 0;
	xor	a, a
	ld	(#_player_dir),a
;src/states/game.c:170: moved = 1;
	ld	c, #0x01
	jr	00111$
00107$:
;src/states/game.c:171: } else if (input_held(J_LEFT)) {
	push	bc
	ld	a, #0x02
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00104$
;src/states/game.c:172: nx--;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:173: player_dir = 2;
	ld	hl, #_player_dir
	ld	(hl), #0x02
;src/states/game.c:174: moved = 1;
	ld	c, #0x01
	jr	00111$
00104$:
;src/states/game.c:175: } else if (input_held(J_RIGHT)) {
	push	bc
	ld	a, #0x01
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00111$
;src/states/game.c:176: nx++;
	ldhl	sp,	#8
	inc	(hl)
	jr	NZ, 00367$
	inc	hl
	inc	(hl)
00367$:
;src/states/game.c:177: player_dir = 3;
	ld	hl, #_player_dir
	ld	(hl), #0x03
;src/states/game.c:178: moved = 1;
	ld	c, #0x01
00111$:
;src/states/game.c:181: if (moved) {
	ld	a, c
	or	a, a
	jp	Z, 00130$
;src/states/game.c:182: if (can_move(nx, ny)) {
	ldhl	sp,	#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_can_move
	or	a, a
	jp	Z, 00125$
;src/states/game.c:183: player_x = nx;
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(#_player_x),a
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(#_player_x + 1),a
;src/states/game.c:184: player_y = ny;
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(#_player_y),a
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(#_player_y + 1),a
;src/states/game.c:185: update_camera();
	call	_update_camera
;src/states/game.c:186: uint16_t sx = player_x - camera_x + 8;
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
;src/states/game.c:187: uint16_t sy = player_y - camera_y + 16;
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
	ldhl	sp,	#10
	ld	(hl), c
	inc	hl
;src/states/game.c:188: move_sprite(0, sx, sy);
	ld	(hl-), a
	ld	b, (hl)
	ld	c, e
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/states/game.c:189: move_sprite(1, sx + 8, sy);
	ldhl	sp,	#10
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
	ldhl	sp,	#12
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	push	hl
	ldhl	sp,	#13
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/states/game.c:190: move_sprite(2, sx, sy + 8);
	ld	a, c
	add	a, #0x08
	ld	c, a
	ldhl	sp,	#11
	ld	(hl), c
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 8)
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	push	hl
	ldhl	sp,	#13
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
;src/states/game.c:196: uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	d, (hl)
	add	a, #0x08
	ld	e, a
	jr	NC, 00368$
	inc	d
00368$:
;src/states/game.c:194: if (current_loc == LOC_WORLD) {
	ld	hl, #_current_loc
	bit	0, (hl)
	jr	NZ, 00118$
;src/states/game.c:196: uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	call	_get_tile_at
;src/states/game.c:197: if (tid == 21 || tid == 22) {
	cp	a, #0x15
	jr	Z, 00112$
	sub	a, #0x16
	jr	NZ, 00119$
00112$:
;src/states/game.c:198: world_saved_x = player_x;
	ld	a, (#_player_x)
	ld	(#_world_saved_x),a
	ld	a, (#_player_x + 1)
	ld	(#_world_saved_x + 1),a
;src/states/game.c:199: world_saved_y = player_y + 16; // Return position (safe distance)
	ld	a, (_player_y)
	ld	hl, #_player_y + 1
	ld	b, (hl)
	add	a, #0x10
	ld	c, a
	ld	a, b
	adc	a, #0x00
	ld	hl, #_world_saved_y
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/states/game.c:200: player_x = 80;
	ld	hl, #_player_x
	ld	a, #0x50
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:201: player_y = 120;
	ld	hl, #_player_y
	ld	a, #0x78
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:202: load_location(LOC_HOUSE);
	ld	a, #0x01
	call	_load_location
;src/states/game.c:203: return;
	jp	00173$
00118$:
;src/states/game.c:207: uint8_t tid = get_tile_at(player_x + 8, player_y + 16);
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	b, h
	call	_get_tile_at
;src/states/game.c:208: if (tid == 35) {
	sub	a, #0x23
	jr	NZ, 00119$
;src/states/game.c:209: player_x = world_saved_x;
	ld	a, (#_world_saved_x)
	ld	(#_player_x),a
	ld	a, (#_world_saved_x + 1)
	ld	(#_player_x + 1),a
;src/states/game.c:210: player_y = world_saved_y;
	ld	a, (#_world_saved_y)
	ld	(#_player_y),a
	ld	a, (#_world_saved_y + 1)
	ld	(#_player_y + 1),a
;src/states/game.c:211: player_dir = 0; // Face Down when exiting
;src/states/game.c:212: load_location(LOC_WORLD);
	xor	a, a
	ld	(#_player_dir), a
	call	_load_location
;src/states/game.c:213: return;
	jp	00173$
00119$:
;src/states/game.c:217: anim_timer++;
	ld	hl, #_anim_timer
	inc	(hl)
;src/states/game.c:218: if (anim_timer > 6) {
	ld	a, #0x06
	sub	a, (hl)
	jr	NC, 00131$
;src/states/game.c:219: anim_frame = !anim_frame;
	ld	hl, #_anim_frame
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/states/game.c:220: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
;src/states/game.c:221: update_player_sprite();
	call	_update_player_sprite
	jr	00131$
00125$:
;src/states/game.c:223: } else if (anim_frame != 0) {
	ld	hl, #_anim_frame
	ld	a, (hl)
	or	a, a
	jr	Z, 00131$
;src/states/game.c:224: anim_frame = 0;
	ld	(hl), #0x00
;src/states/game.c:225: update_player_sprite();
	call	_update_player_sprite
	jr	00131$
00130$:
;src/states/game.c:228: if (anim_frame != 0) {
	ld	hl, #_anim_frame
	ld	a, (hl)
	or	a, a
	jr	Z, 00128$
;src/states/game.c:229: anim_frame = 0;
	ld	(hl), #0x00
;src/states/game.c:230: update_player_sprite();
	call	_update_player_sprite
00128$:
;src/states/game.c:232: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
00131$:
;src/states/game.c:238: if (current_loc == LOC_WORLD) {
	ld	hl, #_current_loc
	bit	0, (hl)
	jr	NZ, 00133$
;src/states/game.c:239: npc_x = 120;
	ldhl	sp,	#2
	ld	a, #0x78
	ld	(hl+), a
	xor	a, a
;src/states/game.c:240: npc_y = 72;
	ld	(hl+), a
	ld	a, #0x48
	ld	(hl+), a
	xor	a, a
;src/states/game.c:242: "HOLA AMIGO,\nTIENES QUE CONSEGUIR\nLA LLAVE EN ALGUN\nLADO DEBE ESTAR";
	ld	(hl+), a
	ld	a, #<(___str_0)
	ld	(hl+), a
	ld	(hl), #>(___str_0)
	jr	00134$
00133$:
;src/states/game.c:244: npc_x = 40;
	ldhl	sp,	#2
	ld	a, #0x28
	ld	(hl+), a
	xor	a, a
;src/states/game.c:245: npc_y = 48;
	ld	(hl+), a
	ld	a, #0x30
	ld	(hl+), a
	xor	a, a
;src/states/game.c:247: "DESCANSAR\nEN LA CAMA.";
	ld	(hl+), a
	ld	a, #<(___str_1)
	ld	(hl+), a
	ld	(hl), #>(___str_1)
00134$:
;src/states/game.c:250: uint16_t nsx = npc_x - camera_x + 8;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_camera_x
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	b, a
	ld	c, e
	ld	hl, #0x0008
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#8
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:251: uint16_t nsy = npc_y - camera_y + 16;
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_camera_y
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	b, a
	ld	c, e
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	b, h
	inc	sp
	inc	sp
	push	bc
;src/states/game.c:252: if (nsx < 168 && nsy < 160) {
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0xa8
	ld	a, b
	sbc	a, #0x00
	jp	NC, 00193$
	pop	bc
	push	bc
	ld	a, c
	sub	a, #0xa0
	ld	a, b
	sbc	a, #0x00
	jp	NC, 00193$
;src/states/game.c:253: move_sprite(4, nsx, nsy);
	ldhl	sp,	#0
	ld	c, (hl)
	ldhl	sp,	#8
	ld	b, (hl)
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 16)
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:254: move_sprite(5, nsx + 8, nsy);
	ldhl	sp,	#0
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x08
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	de, #(_shadow_OAM + 20)
	ldhl	sp,	#1
	ld	a, (hl)
	ld	(de), a
	ld	de, #(_shadow_OAM + 21)
	ldhl	sp,	#9
;src/states/game.c:255: move_sprite(6, nsx, nsy + 8);
	ld	a, (hl+)
	ld	(de), a
	ld	a, (hl-)
	add	a, #0x08
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl), a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	de, #(_shadow_OAM + 24)
	ld	a, (hl+)
	ld	(de), a
	ld	de, #(_shadow_OAM + 25)
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, (hl-)
	dec	hl
	ld	(de), a
	ld	de, #(_shadow_OAM + 28)
	ld	a, (hl-)
	ld	(de), a
	ld	de, #(_shadow_OAM + 29)
	ld	a, (hl)
	ld	(de), a
;src/states/game.c:257: for (int i = 0; i < 4; i++)
	ldhl	sp,	#11
	ld	(hl), #0x00
00168$:
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00139$
;src/states/game.c:258: set_sprite_tile(4 + i, 24 + i);
	ld	c, (hl)
	ld	a, c
	add	a, #0x18
	ldhl	sp,	#8
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	(hl+), a
	inc	c
	inc	c
	inc	c
	inc	c
	ld	a, c
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00374$:
	ldhl	sp,	#9
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00374$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #_shadow_OAM
	add	hl, de
	inc	sp
	inc	sp
	ld	e, l
	ld	d, h
	push	de
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (hl)
	ld	(de), a
;src/states/game.c:257: for (int i = 0; i < 4; i++)
	ldhl	sp,	#11
	inc	(hl)
	jr	00168$
;src/states/game.c:260: for (int i = 0; i < 4; i++)
00193$:
	ldhl	sp,	#11
	ld	(hl), #0x00
00171$:
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00139$
;src/states/game.c:261: move_sprite(4 + i, 0, 0);
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	a, (hl-)
	dec	hl
	add	a, #0x04
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x02
00375$:
	ldhl	sp,	#0
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00375$
	pop	de
	push	de
	ld	hl, #_shadow_OAM
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	pop	hl
	ld	(hl), #0x00
	ld	e, l
	ld	d, h
	push	de
	ld	l, e
	ld	h, d
	inc	hl
	push	hl
	ld	a, l
	ldhl	sp,	#11
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
;src/states/game.c:260: for (int i = 0; i < 4; i++)
	ldhl	sp,	#11
	inc	(hl)
	jr	00171$
00139$:
;src/states/game.c:264: if (input_pressed(J_A)) {
	ld	a, #0x10
	call	_input_pressed
	ld	c, a
	or	a, a
	jp	Z, 00149$
;src/states/game.c:265: int16_t dx = (int16_t)player_x - npc_x;
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	b, (hl)
	ld	e, a
	ld	d, b
	ldhl	sp,	#2
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ld	b, a
	ld	c, e
;src/states/game.c:266: int16_t dy = (int16_t)player_y - npc_y;
	ld	a, (_player_y)
	ld	hl, #_player_y + 1
	ld	e, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	ld	a, e
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#4
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
;src/states/game.c:267: if (dx < 0)
	ld	h, b
	bit	7, h
	jr	Z, 00142$
;src/states/game.c:268: dx = -dx;
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
00142$:
;src/states/game.c:269: if (dy < 0)
	ldhl	sp,	#10
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00144$
;src/states/game.c:270: dy = -dy;
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
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
00144$:
;src/states/game.c:271: if (dx < 24 && dy < 24)
	ld	a, c
	sub	a, #0x18
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00149$
	ldhl	sp,	#10
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
	jr	NC, 00149$
;src/states/game.c:272: text_dialogue(dial);
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_text_dialogue
00149$:
;src/states/game.c:276: if (current_loc == LOC_WORLD) {
	ld	hl, #_current_loc
	bit	0, (hl)
	jp	NZ, 00173$
;src/states/game.c:277: env_anim_timer++;
	ld	hl, #_env_anim_timer
	inc	(hl)
;src/states/game.c:278: if (env_anim_timer >= 40) {
	ld	a, (hl)
	sub	a, #0x28
	jp	C, 00173$
;src/states/game.c:279: env_anim_timer = 0;
	ld	(hl), #0x00
;src/states/game.c:280: env_anim_frame = !env_anim_frame;
	ld	hl, #_env_anim_frame
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/states/game.c:281: if (env_anim_frame) {
	ld	a, (hl)
	or	a, a
	jr	Z, 00151$
;src/states/game.c:282: set_bkg_data(2, 1, &tiles_anim_data[0]);   // Grass
	ld	de, #_tiles_anim_data
	push	de
	ld	hl, #0x102
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:283: set_bkg_data(4, 1, &tiles_anim_data[16]);  // Tree TL
	ld	de, #(_tiles_anim_data + 16)
	push	de
	ld	hl, #0x104
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:284: set_bkg_data(5, 1, &tiles_anim_data[32]);  // Tree TR
	ld	de, #(_tiles_anim_data + 32)
	push	de
	ld	hl, #0x105
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:285: set_bkg_data(6, 1, &tiles_anim_data[48]);  // Tree BL
	ld	de, #(_tiles_anim_data + 48)
	push	de
	ld	hl, #0x106
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:286: set_bkg_data(12, 1, &tiles_anim_data[64]); // Tree BR
	ld	de, #(_tiles_anim_data + 64)
	push	de
	ld	hl, #0x10c
	push	hl
	call	_set_bkg_data
	add	sp, #4
	jr	00173$
00151$:
;src/states/game.c:288: set_bkg_data(2, 1, &tiles_data[32]);   // Grass
	ld	de, #(_tiles_data + 32)
	push	de
	ld	hl, #0x102
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:289: set_bkg_data(4, 1, &tiles_data[64]);   // Tree TL
	ld	de, #(_tiles_data + 64)
	push	de
	ld	hl, #0x104
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:290: set_bkg_data(5, 1, &tiles_data[80]);   // Tree TR
	ld	de, #(_tiles_data + 80)
	push	de
	ld	hl, #0x105
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:291: set_bkg_data(6, 1, &tiles_data[96]);   // Tree BL
	ld	de, #(_tiles_data + 96)
	push	de
	ld	hl, #0x106
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:292: set_bkg_data(12, 1, &tiles_data[192]); // Tree BR
	ld	de, #(_tiles_data + 192)
	push	de
	ld	hl, #0x10c
	push	hl
	call	_set_bkg_data
	add	sp, #4
00173$:
;src/states/game.c:296: }
	add	sp, #12
	ret
___str_0:
	.ascii "HOLA AMIGO,"
	.db 0x0a
	.ascii "TIENES QUE CONSEGUIR"
	.db 0x0a
	.ascii "LA LLAVE EN ALGUN"
	.db 0x0a
	.ascii "LADO DEBE ESTAR"
	.db 0x00
___str_1:
	.ascii "BIENVENIDO A MI CASA."
	.db 0x0a
	.ascii "EL ROPERO ESTA TRABADO,"
	.db 0x0a
	.ascii "PERO PUEDES DESCANSAR"
	.db 0x0a
	.ascii "EN LA CAMA."
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__current_loc:
	.db #0x00	;  0
__xinit__player_x:
	.dw #0x0098
__xinit__player_y:
	.dw #0x0078
__xinit__world_saved_x:
	.dw #0x0098
__xinit__world_saved_y:
	.dw #0x0078
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
__xinit__env_anim_timer:
	.db #0x00	; 0
__xinit__env_anim_frame:
	.db #0x00	; 0
	.area _CABS (ABS)
