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
	.globl _load_map
	.globl _update_camera
	.globl _get_tile_at
	.globl _memcpy
	.globl _text_dialogue
	.globl _text_init
	.globl _music_update
	.globl _music_init
	.globl _input_held
	.globl _input_pressed
	.globl _fill_bkg_rect
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _display_off
	.globl _env_anim_frame
	.globl _env_anim_timer
	.globl _has_key
	.globl _camera_y
	.globl _camera_x
	.globl _anim_timer
	.globl _anim_frame
	.globl _player_dir
	.globl _player_y
	.globl _player_x
	.globl _saved_world_y
	.globl _saved_world_x
	.globl _current_map
	.globl _level2_map_info
	.globl _house_map_info
	.globl _world_map_info
	.globl _level2_ents
	.globl _house_ents
	.globl _world_ents
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
_world_ents::
	.ds 9
_house_ents::
	.ds 9
_level2_ents::
	.ds 9
_world_map_info::
	.ds 23
_house_map_info::
	.ds 23
_level2_map_info::
	.ds 23
_current_map::
	.ds 2
_saved_world_x::
	.ds 2
_saved_world_y::
	.ds 2
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
_has_key::
	.ds 1
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
;src/states/game.c:57: uint8_t get_tile_at(uint16_t x, uint16_t y) {
;	---------------------------------
; Function get_tile_at
; ---------------------------------
_get_tile_at::
	add	sp, #-6
;src/states/game.c:58: uint16_t tx = x / 8, ty = y / 8;
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
;src/states/game.c:59: if (tx >= current_map->w || ty >= current_map->h)
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
;src/states/game.c:60: return 1;
	ld	a, #0x01
	jr	00104$
00102$:
;src/states/game.c:61: return current_map->tiles[ty * current_map->w + tx];
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
;src/states/game.c:62: }
	add	sp, #6
	ret
;src/states/game.c:64: void update_camera() {
;	---------------------------------
; Function update_camera
; ---------------------------------
_update_camera::
	add	sp, #-4
;src/states/game.c:65: uint16_t w = current_map->w * 8, h = current_map->h * 8;
	ld	a, (_current_map)
	ld	c, a
	ld	hl, #_current_map + 1
	ld	b, (hl)
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	ld	e, h
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), e
	inc	bc
	inc	bc
	inc	bc
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	ld	c, h
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), c
;src/states/game.c:66: if (player_x > SCREEN_WIDTH / 2)
	ld	hl, #_player_x
	ld	a, #0x50
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00102$
;src/states/game.c:67: camera_x = player_x - SCREEN_WIDTH / 2;
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
;src/states/game.c:69: camera_x = 0;
	xor	a, a
	ld	hl, #_camera_x
	ld	(hl+), a
	ld	(hl), a
00103$:
;src/states/game.c:70: if (player_y > SCREEN_HEIGHT / 2)
	ld	hl, #_player_y
	ld	a, #0x48
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00105$
;src/states/game.c:71: camera_y = player_y - SCREEN_HEIGHT / 2;
	ld	a, (_player_y)
	ld	hl, #_player_y + 1
	ld	b, (hl)
	add	a, #0xb8
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	hl, #_camera_y
	ld	(hl), c
	inc	hl
	ld	(hl), a
	jr	00106$
00105$:
;src/states/game.c:73: camera_y = 0;
	xor	a, a
	ld	hl, #_camera_y
	ld	(hl+), a
	ld	(hl), a
00106$:
;src/states/game.c:74: if (camera_x > w - SCREEN_WIDTH)
	pop	bc
	push	bc
	ld	a, c
	add	a, #0x60
	ld	e, a
	ld	a, b
	adc	a, #0xff
	ld	d, a
	ld	a, (_camera_x)
	ld	l, a
	ld	a, (_camera_x + 1)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	a, d
	sbc	a, h
	jr	NC, 00108$
;src/states/game.c:75: camera_x = (w > SCREEN_WIDTH) ? (w - SCREEN_WIDTH) : 0;
	ld	a, #0xa0
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	C, 00115$
	ld	de, #0x0000
00115$:
	ld	hl, #_camera_x
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00108$:
;src/states/game.c:76: if (camera_y > h - SCREEN_HEIGHT)
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
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
;src/states/game.c:77: camera_y = (h > SCREEN_HEIGHT) ? (h - SCREEN_HEIGHT) : 0;
	ld	a, #0x90
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	C, 00117$
	ld	bc, #0x0000
00117$:
	ld	hl, #_camera_y
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
00110$:
;src/states/game.c:78: move_bkg(camera_x, camera_y);
	ld	a, (_camera_y)
	ld	c, a
	ld	a, (#_camera_x)
	ldh	(_SCX_REG + 0), a
;./gbdk/include/gb/gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/states/game.c:78: move_bkg(camera_x, camera_y);
;src/states/game.c:79: }
	add	sp, #4
	ret
;src/states/game.c:81: void load_map(map_info_t *m) {
;	---------------------------------
; Function load_map
; ---------------------------------
_load_map::
	add	sp, #-7
	ldhl	sp,	#5
	ld	a, e
	ld	(hl+), a
;src/states/game.c:82: HIDE_BKG;
;src/states/game.c:83: current_map = m;
	ld	a, d
	ld	(hl-), a
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
	ld	a, (hl)
	ld	(#_current_map),a
	ldhl	sp,	#6
	ld	a, (hl)
	ld	(#_current_map + 1),a
;src/states/game.c:85: for (int i = 4; i < 40; i++)
	ld	c, #0x04
00106$:
	ld	a, c
	sub	a, #0x28
	jr	NC, 00101$
;src/states/game.c:86: move_sprite(i, 0, 0);
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, c
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
;src/states/game.c:85: for (int i = 4; i < 40; i++)
	inc	c
	jr	00106$
00101$:
;src/states/game.c:88: if (m == &house_map_info)
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #<(_house_map_info)
	jr	NZ, 00103$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_house_map_info)
	jr	NZ, 00103$
;src/states/game.c:89: fill_bkg_rect(0, 0, 32, 32, 26); // Wall filler
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
00103$:
;src/states/game.c:90: set_bkg_tiles(0, 0, m->w, m->h, m->tiles);
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
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
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
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
	ld	d, (hl)
	ld	a, (de)
	ld	(hl-), a
	dec	hl
	pop	de
	push	de
	push	de
	ld	a, (hl+)
	inc	hl
	push	af
	inc	sp
	ld	a, (hl)
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/states/game.c:91: update_camera();
	call	_update_camera
;src/states/game.c:92: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:93: }
	add	sp, #7
	ret
;src/states/game.c:95: void update_player_sprite() {
;	---------------------------------
; Function update_player_sprite
; ---------------------------------
_update_player_sprite::
	dec	sp
;src/states/game.c:96: uint8_t base =
	ld	a, (#_player_dir)
	sub	a, #0x03
	ld	a, #0x01
	jr	Z, 00198$
	xor	a, a
00198$:
	ld	b, a
	or	a, a
	jr	Z, 00124$
	ld	c, #0x10
	jr	00125$
00124$:
	ld	a, (#_player_dir)
	sub	a, #0x02
	jr	NZ, 00126$
	ld	c, #0x10
	jr	00127$
00126$:
	ld	a, (#_player_dir)
	dec	a
	ld	c, #0x08
	jr	Z, 00129$
	ld	c, #0x00
00129$:
00127$:
00125$:
	ld	a, (_anim_frame)
	add	a, a
	add	a, a
	add	a, c
	ld	c, a
;src/states/game.c:100: uint8_t prop = (player_dir == 3) ? S_FLIPX : 0;
	ld	a, b
	or	a, a
	ld	e, #0x20
	jr	NZ, 00131$
	ld	e, #0x00
00131$:
;src/states/game.c:101: if (prop == 0) {
	ld	a, e
	or	a, a
	jr	NZ, 00104$
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), c
;src/states/game.c:103: set_sprite_tile(1, base + 1);
	ld	a, c
	inc	a
	ldhl	sp,	#0
	ld	(hl), a
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	de, #(_shadow_OAM + 6)
	ld	a, (hl)
	ld	(de), a
;src/states/game.c:104: set_sprite_tile(2, base + 2);
	ld	b, c
	inc	b
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), b
;src/states/game.c:105: set_sprite_tile(3, base + 3);
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), c
;src/states/game.c:106: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00117$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00122$
;src/states/game.c:107: set_sprite_prop(i, 0);
;./gbdk/include/gb/gb.h:1946: shadow_OAM[nb].prop=prop;
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	inc	hl
	ld	(hl), #0x00
;src/states/game.c:106: for (int i = 0; i < 4; i++)
	inc	c
	jr	00117$
00104$:
;src/states/game.c:109: set_sprite_tile(0, base + 1);
	ld	b, c
	ld	a, b
	inc	a
	ldhl	sp,	#0
	ld	(hl), a
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	de, #(_shadow_OAM + 2)
	ld	a, (hl)
	ld	(de), a
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), c
;src/states/game.c:111: set_sprite_tile(2, base + 3);
	ld	c, b
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), c
;src/states/game.c:112: set_sprite_tile(3, base + 2);
	inc	b
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), b
;src/states/game.c:113: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00120$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00122$
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
	jr	00120$
00122$:
;src/states/game.c:116: }
	inc	sp
	ret
;src/states/game.c:118: uint8_t is_solid(uint16_t x, uint16_t y) {
;	---------------------------------
; Function is_solid
; ---------------------------------
_is_solid::
;src/states/game.c:119: uint8_t tid = get_tile_at(x, y);
	call	_get_tile_at
	ld	c, a
;src/states/game.c:120: for (int i = 0; i < 16; i++) {
	ld	b, #0x00
00107$:
	ld	a, b
	sub	a, #0x10
	jr	NC, 00105$
;src/states/game.c:121: if (current_map->solid_tiles[i] == 255)
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
;src/states/game.c:123: if (tid == current_map->solid_tiles[i])
	sub	a, c
	jr	NZ, 00108$
;src/states/game.c:124: return 0;
	xor	a, a
	ret
00108$:
;src/states/game.c:120: for (int i = 0; i < 16; i++) {
	inc	b
	jr	00107$
00105$:
;src/states/game.c:126: return 1;
	ld	a, #0x01
;src/states/game.c:127: }
	ret
;src/states/game.c:129: uint8_t can_move(uint16_t nx, uint16_t ny) {
;	---------------------------------
; Function can_move
; ---------------------------------
_can_move::
	add	sp, #-8
	ldhl	sp,	#6
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:130: uint16_t w = current_map->w * 8, h = current_map->h * 8;
	ld	a, (_current_map)
	ld	hl, #_current_map + 1
	ld	b, (hl)
	ld	l, a
	ld	h, b
	inc	hl
	inc	hl
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	c, a
	inc	bc
	inc	bc
	inc	bc
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
	ld	a, c
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, a
	rl	b
	ld	c, a
;src/states/game.c:131: if (nx < 4 || nx > w - 20 || ny < 8 || ny > h - 20)
	ld	a, e
	sub	a, #0x04
	ld	a, d
	sbc	a, #0x00
	jr	C, 00101$
	ld	a, l
	add	a, #0xec
	ld	l, a
	ld	a, h
	adc	a, #0xff
	ld	h, a
	ld	a, l
	sub	a, e
	ld	a, h
	sbc	a, d
	jr	C, 00101$
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#1
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
;src/states/game.c:132: return 0;
	xor	a, a
	jr	00111$
00102$:
;src/states/game.c:133: if (is_solid(nx + 4, ny + 8) || is_solid(nx + 11, ny + 8) ||
	push	de
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	pop	de
	ld	c, l
	ld	a, h
	ldhl	sp,	#2
	ld	(hl), c
	inc	hl
	ld	(hl), a
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), c
	inc	hl
	ld	(hl), a
	push	de
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_is_solid
	pop	de
	or	a, a
	jr	NZ, 00106$
	ld	hl, #0x000b
	add	hl, de
	ld	e, l
	ld	d, h
	push	de
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	call	_is_solid
	pop	de
	or	a, a
	jr	NZ, 00106$
;src/states/game.c:134: is_solid(nx + 4, ny + 15) || is_solid(nx + 11, ny + 15))
	push	de
	ldhl	sp,#2
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
;src/states/game.c:135: return 0;
	xor	a, a
	jr	00111$
00107$:
;src/states/game.c:136: return 1;
	ld	a, #0x01
00111$:
;src/states/game.c:137: }
	add	sp, #8
	ret
;src/states/game.c:141: void game_init(void) {
;	---------------------------------
; Function game_init
; ---------------------------------
_game_init::
	add	sp, #-16
;src/states/game.c:142: DISPLAY_OFF;
	call	_display_off
;src/states/game.c:143: set_bkg_data(0, 45, tiles_data); // Tiles 0-44
	ld	de, #_tiles_data
	push	de
	ld	hl, #0x2d00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:146: world_map_info.tiles = map_data;
	ld	hl, #_world_map_info
	ld	a, #<(_map_data)
	ld	(hl+), a
;src/states/game.c:147: world_map_info.w = MAP_WIDTH;
	ld	a, #>(_map_data)
	ld	(hl+), a
	ld	(hl), #0x20
;src/states/game.c:148: world_map_info.h = MAP_HEIGHT;
	ld	hl, #_world_map_info + 3
	ld	(hl), #0x20
;src/states/game.c:149: world_map_info.entities = world_ents;
	ld	hl, #(_world_map_info + 4)
	ld	a, #<(_world_ents)
	ld	(hl+), a
;src/states/game.c:150: world_map_info.num_entities = 1;
	ld	a, #>(_world_ents)
	ld	(hl+), a
	ld	(hl), #0x01
;src/states/game.c:151: uint8_t w_pass[] = {0, 2, 3, 4, 5, 21, 22, 255};
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	ldhl	sp,	#1
	ld	a, #0x02
	ld	(hl+), a
	ld	a, #0x03
	ld	(hl+), a
	ld	a, #0x04
	ld	(hl+), a
	ld	a, #0x05
	ld	(hl+), a
	ld	a, #0x15
	ld	(hl+), a
	ld	a, #0x16
	ld	(hl+), a
	ld	(hl), #0xff
;src/states/game.c:152: memcpy(world_map_info.solid_tiles, w_pass, 8);
	ld	de, #0x0008
	push	de
	ld	de, #(_world_map_info + 7)
	call	_memcpy
;src/states/game.c:153: world_ents[0].x = 120;
	ld	hl, #_world_ents
	ld	a, #0x78
	ld	(hl+), a
;src/states/game.c:154: world_ents[0].y = 72;
	xor	a, a
	ld	(hl+), a
	ld	a, #0x48
	ld	(hl+), a
;src/states/game.c:155: world_ents[0].type = ENT_NPC;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/states/game.c:156: world_ents[0].dialogue =
	ld	hl, #(_world_ents + 5)
	ld	a, #<(___str_0)
	ld	(hl+), a
;src/states/game.c:158: world_ents[0].sprite_base = 24;
	ld	a, #>(___str_0)
	ld	(hl+), a
	ld	(hl), #0x18
;src/states/game.c:159: world_ents[0].active = 1;
	ld	hl, #_world_ents + 8
	ld	(hl), #0x01
;src/states/game.c:161: house_map_info.tiles = house_map;
	ld	hl, #_house_map_info
	ld	a, #<(_house_map)
	ld	(hl+), a
;src/states/game.c:162: house_map_info.w = HOUSE_WIDTH;
	ld	a, #>(_house_map)
	ld	(hl+), a
	ld	(hl), #0x14
;src/states/game.c:163: house_map_info.h = HOUSE_HEIGHT;
	ld	hl, #_house_map_info + 3
	ld	(hl), #0x12
;src/states/game.c:164: house_map_info.entities = house_ents;
	ld	hl, #(_house_map_info + 4)
	ld	a, #<(_house_ents)
	ld	(hl+), a
;src/states/game.c:165: house_map_info.num_entities = 1;
	ld	a, #>(_house_ents)
	ld	(hl+), a
	ld	(hl), #0x01
;src/states/game.c:166: uint8_t h_pass[] = {25, 35, 255};
	ldhl	sp,	#8
	ld	c, l
	ld	b, h
	ld	(hl), #0x19
	ldhl	sp,	#9
	ld	a, #0x23
	ld	(hl+), a
	ld	(hl), #0xff
;src/states/game.c:167: memcpy(house_map_info.solid_tiles, h_pass, 3);
	ld	de, #0x0003
	push	de
	ld	de, #(_house_map_info + 7)
	call	_memcpy
;src/states/game.c:168: house_ents[0].x = 40;
	ld	hl, #_house_ents
	ld	a, #0x28
	ld	(hl+), a
;src/states/game.c:169: house_ents[0].y = 48;
	xor	a, a
	ld	(hl+), a
	ld	a, #0x30
	ld	(hl+), a
;src/states/game.c:170: house_ents[0].type = ENT_NPC;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/states/game.c:171: house_ents[0].dialogue = "PUEDES DESCANSAR,\nPERO NO TOQUES\nMIS COSAS!";
	ld	hl, #(_house_ents + 5)
	ld	a, #<(___str_1)
	ld	(hl+), a
;src/states/game.c:172: house_ents[0].sprite_base = 24;
	ld	a, #>(___str_1)
	ld	(hl+), a
	ld	(hl), #0x18
;src/states/game.c:173: house_ents[0].active = 1;
	ld	hl, #_house_ents + 8
	ld	(hl), #0x01
;src/states/game.c:175: level2_map_info.tiles = level2_map;
	ld	hl, #_level2_map_info
	ld	a, #<(_level2_map)
	ld	(hl+), a
;src/states/game.c:176: level2_map_info.w = L2_WIDTH;
	ld	a, #>(_level2_map)
	ld	(hl+), a
	ld	(hl), #0x20
;src/states/game.c:177: level2_map_info.h = L2_HEIGHT;
	ld	hl, #_level2_map_info + 3
	ld	(hl), #0x20
;src/states/game.c:178: level2_map_info.entities = NULL;
	ld	hl, #(_level2_map_info + 4)
	xor	a, a
	ld	(hl+), a
;src/states/game.c:179: level2_map_info.num_entities = 0;
	ld	(hl+), a
	ld	(hl), #0x00
;src/states/game.c:180: uint8_t l2_pass[] = {0, 2, 3, 4, 255};
	ldhl	sp,	#11
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	ldhl	sp,	#12
	ld	a, #0x02
	ld	(hl+), a
	ld	a, #0x03
	ld	(hl+), a
	ld	a, #0x04
	ld	(hl+), a
	ld	(hl), #0xff
;src/states/game.c:181: memcpy(level2_map_info.solid_tiles, l2_pass, 5);
	ld	de, #0x0005
	push	de
	ld	de, #(_level2_map_info + 7)
	call	_memcpy
;src/states/game.c:183: load_map(&world_map_info);
	ld	de, #_world_map_info
	call	_load_map
;src/states/game.c:185: BGP_REG = OBP0_REG = OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/states/game.c:186: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:187: set_sprite_data(0, 24, player_sprites);
	ld	de, #_player_sprites
	push	de
	ld	hl, #0x1800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:188: set_sprite_data(24, 4, npc_child_sprite);
	ld	de, #_npc_child_sprite
	push	de
	ld	hl, #0x418
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:189: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:190: text_init();
	call	_text_init
;src/states/game.c:191: music_init();
	call	_music_init
;src/states/game.c:192: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:193: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:194: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:195: }
	add	sp, #16
	ret
___str_0:
	.ascii "HOLA AMIGO,"
	.db 0x0a
	.ascii "BUSCA LA LLAVE EN"
	.db 0x0a
	.ascii "MI CASA PARA"
	.db 0x0a
	.ascii "ABRIR EL PORTON."
	.db 0x00
___str_1:
	.ascii "PUEDES DESCANSAR,"
	.db 0x0a
	.ascii "PERO NO TOQUES"
	.db 0x0a
	.ascii "MIS COSAS!"
	.db 0x00
;src/states/game.c:197: void game_update(void) {
;	---------------------------------
; Function game_update
; ---------------------------------
_game_update::
	add	sp, #-12
;src/states/game.c:198: music_update();
	call	_music_update
;src/states/game.c:199: uint8_t moved = 0;
	ld	c, #0x00
;src/states/game.c:200: uint16_t nx = player_x, ny = player_y;
	ld	a, (#_player_x)
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (#_player_y)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#11
	ld	(hl), a
;src/states/game.c:202: if (input_held(J_UP)) {
	push	bc
	ld	a, #0x04
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00110$
;src/states/game.c:203: ny--;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:204: player_dir = 1;
	ld	hl, #_player_dir
	ld	(hl), #0x01
;src/states/game.c:205: moved = 1;
	ld	c, #0x01
	jr	00111$
00110$:
;src/states/game.c:206: } else if (input_held(J_DOWN)) {
	push	bc
	ld	a, #0x08
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00107$
;src/states/game.c:207: ny++;
	ldhl	sp,	#10
	inc	(hl)
	jr	NZ, 00547$
	inc	hl
	inc	(hl)
00547$:
;src/states/game.c:208: player_dir = 0;
	xor	a, a
	ld	(#_player_dir),a
;src/states/game.c:209: moved = 1;
	ld	c, #0x01
	jr	00111$
00107$:
;src/states/game.c:210: } else if (input_held(J_LEFT)) {
	push	bc
	ld	a, #0x02
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00104$
;src/states/game.c:211: nx--;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:212: player_dir = 2;
	ld	hl, #_player_dir
	ld	(hl), #0x02
;src/states/game.c:213: moved = 1;
	ld	c, #0x01
	jr	00111$
00104$:
;src/states/game.c:214: } else if (input_held(J_RIGHT)) {
	push	bc
	ld	a, #0x01
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00111$
;src/states/game.c:215: nx++;
	ldhl	sp,	#8
	inc	(hl)
	jr	NZ, 00548$
	inc	hl
	inc	(hl)
00548$:
;src/states/game.c:216: player_dir = 3;
	ld	hl, #_player_dir
	ld	(hl), #0x03
;src/states/game.c:217: moved = 1;
	ld	c, #0x01
00111$:
;src/states/game.c:220: if (moved) {
	ld	a, c
	or	a, a
	jp	Z, 00130$
;src/states/game.c:221: if (can_move(nx, ny)) {
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
;src/states/game.c:222: player_x = nx;
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(#_player_x),a
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(#_player_x + 1),a
;src/states/game.c:223: player_y = ny;
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(#_player_y),a
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(#_player_y + 1),a
;src/states/game.c:224: update_camera();
	call	_update_camera
;src/states/game.c:225: uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
	ld	a, (_player_x)
	ld	hl, #_camera_x
	ld	c, (hl)
	sub	a, c
	add	a, #0x08
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, (_player_y)
	ld	hl, #_camera_y
	ld	c, (hl)
	sub	a, c
	add	a, #0x10
	ldhl	sp,	#7
	ld	(hl), a
;src/states/game.c:226: for (int i = 0; i < 4; i++)
	ldhl	sp,	#11
	ld	(hl), #0x00
00182$:
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00112$
;src/states/game.c:227: move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));
	ldhl	sp,	#7
	ld	c, (hl)
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x02
	jr	C, 00198$
	ld	a, #0x08
	jr	00199$
00198$:
	xor	a, a
00199$:
	add	a, c
	ldhl	sp,	#8
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl)
	and	a, #0x01
	ld	a, #0x08
	jr	NZ, 00201$
	xor	a, a
00201$:
	ldhl	sp,	#9
	ld	c, (hl)
	inc	hl
	add	a, c
	ld	c, a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	push	hl
	ldhl	sp,	#10
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	ld	(hl), c
;src/states/game.c:226: for (int i = 0; i < 4; i++)
	ldhl	sp,	#11
	inc	(hl)
	jr	00182$
00112$:
;src/states/game.c:230: uint8_t tid = get_tile_at(player_x + 8, player_y + 4); // Head check
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	d, (hl)
	add	a, #0x08
	ld	e, a
	jr	NC, 00549$
	inc	d
00549$:
	call	_get_tile_at
	ld	e, a
;src/states/game.c:231: if (current_map == &world_map_info && (tid == 21 || tid == 22)) {
;src/states/game.c:230: uint8_t tid = get_tile_at(player_x + 8, player_y + 4); // Head check
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
;src/states/game.c:233: saved_world_y = player_y + 16;
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	b, h
;src/states/game.c:231: if (current_map == &world_map_info && (tid == 21 || tid == 22)) {
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_world_map_info)
	jr	NZ, 00114$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_world_map_info)
	jr	NZ, 00114$
	ld	a,e
	cp	a,#0x15
	jr	Z, 00113$
	sub	a, #0x16
	jr	NZ, 00114$
00113$:
;src/states/game.c:232: saved_world_x = player_x;
	ld	a, (#_player_x)
	ld	(#_saved_world_x),a
	ld	a, (#_player_x + 1)
	ld	(#_saved_world_x + 1),a
;src/states/game.c:233: saved_world_y = player_y + 16;
	ld	hl, #_saved_world_y
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:234: player_x = 80;
	ld	hl, #_player_x
	ld	a, #0x50
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:235: player_y = 120;
	ld	hl, #_player_y
	ld	a, #0x78
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:236: load_map(&house_map_info);
	ld	de, #_house_map_info
	call	_load_map
;src/states/game.c:237: return;
	jp	00196$
00114$:
;src/states/game.c:239: tid = get_tile_at(player_x + 8, player_y + 16); // Foot check
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	d, (hl)
	add	a, #0x08
	ld	e, a
	jr	NC, 00555$
	inc	d
00555$:
	call	_get_tile_at
	ld	c, a
;src/states/game.c:240: if (current_map == &house_map_info && tid == 35) {
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_house_map_info)
	jr	NZ, 00118$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_house_map_info)
	jr	NZ, 00118$
	ld	a, c
	sub	a, #0x23
	jr	NZ, 00118$
;src/states/game.c:241: player_x = saved_world_x;
	ld	a, (#_saved_world_x)
	ld	(#_player_x),a
	ld	a, (#_saved_world_x + 1)
	ld	(#_player_x + 1),a
;src/states/game.c:242: player_y = saved_world_y;
	ld	a, (#_saved_world_y)
	ld	(#_player_y),a
	ld	a, (#_saved_world_y + 1)
	ld	(#_player_y + 1),a
;src/states/game.c:243: player_dir = 0;
	xor	a, a
	ld	(#_player_dir),a
;src/states/game.c:244: load_map(&world_map_info);
	ld	de, #_world_map_info
	call	_load_map
;src/states/game.c:245: return;
	jp	00196$
00118$:
;src/states/game.c:248: if (++anim_timer > 6) {
	ld	hl, #_anim_timer
	inc	(hl)
	ld	a, #0x06
	sub	a, (hl)
	jr	NC, 00232$
;src/states/game.c:249: anim_frame = !anim_frame;
	ld	hl, #_anim_frame
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/states/game.c:250: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
;src/states/game.c:251: update_player_sprite();
	call	_update_player_sprite
	jr	00232$
00125$:
;src/states/game.c:253: } else if (anim_frame != 0) {
	ld	hl, #_anim_frame
	ld	a, (hl)
	or	a, a
	jr	Z, 00232$
;src/states/game.c:254: anim_frame = 0;
	ld	(hl), #0x00
;src/states/game.c:255: update_player_sprite();
	call	_update_player_sprite
	jr	00232$
00130$:
;src/states/game.c:258: if (anim_frame != 0) {
	ld	hl, #_anim_frame
	ld	a, (hl)
	or	a, a
	jr	Z, 00128$
;src/states/game.c:259: anim_frame = 0;
	ld	(hl), #0x00
;src/states/game.c:260: update_player_sprite();
	call	_update_player_sprite
00128$:
;src/states/game.c:262: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
;src/states/game.c:266: for (int i = 0; i < current_map->num_entities; i++) {
00232$:
	xor	a, a
	ldhl	sp,	#10
	ld	(hl+), a
	ld	(hl), a
00191$:
	ld	a, (#_current_map)
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, (#_current_map + 1)
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#10
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00560$
	bit	7, d
	jr	NZ, 00561$
	cp	a, a
	jr	00561$
00560$:
	bit	7, d
	jr	Z, 00561$
	scf
00561$:
	jp	NC, 00138$
;src/states/game.c:267: entity_t *e = &current_map->entities[i];
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
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
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#6
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#10
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#6
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#10
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#9
;src/states/game.c:268: uint16_t esx = e->x - camera_x + 8, esy = e->y - camera_y + 16;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, c
	ld	hl, #_camera_x
	sub	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	sbc	a, (hl)
	ld	b, a
	ld	hl, #0x0008
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#2
	ld	(hl), c
	inc	hl
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	ld	hl, #_camera_y
	sub	a, (hl)
	inc	hl
	ld	c, a
	ld	a, b
	sbc	a, (hl)
	ld	b, a
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/states/game.c:269: if (esx < 168 && esy < 160) {
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0xa8
	ld	a, b
	sbc	a, #0x00
	jp	NC, 00231$
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0xa0
	ld	a, b
	sbc	a, #0x00
	jr	NC, 00231$
;src/states/game.c:270: for (int j = 0; j < 4; j++) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#8
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#7
	ld	(hl), a
	ld	c, #0x00
00185$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00192$
;src/states/game.c:271: move_sprite(4 + j, esx + (j % 2 ? 8 : 0), esy + (j >= 2 ? 8 : 0));
	ldhl	sp,	#4
	ld	b, (hl)
	ld	a, c
	sub	a, #0x02
	jr	C, 00202$
	ld	a, #0x08
	jr	00203$
00202$:
	xor	a, a
00203$:
	add	a, b
	ld	e, a
	ldhl	sp,	#2
	ld	b, (hl)
	ld	a, c
	and	a, #0x01
	ld	a, #0x08
	jr	NZ, 00205$
	xor	a, a
00205$:
	add	a, b
	ldhl	sp,	#9
	ld	(hl-), a
	ld	b, c
	ld	a, b
	add	a, #0x04
	ld	(hl), a
	ld	d, (hl)
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, d
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	a, #<(_shadow_OAM)
	add	a, l
	ld	l, a
	ld	a, #>(_shadow_OAM)
	adc	a, h
	ld	h, a
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ld	a, e
	ld	(hl+), a
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
;src/states/game.c:272: set_sprite_tile(4 + j, e->sprite_base + j);
	ld	a, (hl-)
	dec	hl
	dec	hl
	ld	(de), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	inc	hl
	ld	d, a
	ld	a, (de)
	add	a, b
	ld	(hl-), a
	ld	b, (hl)
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	de, #_shadow_OAM+0
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(de), a
;src/states/game.c:270: for (int j = 0; j < 4; j++) {
	inc	c
	jr	00185$
;src/states/game.c:275: for (int j = 0; j < 4; j++)
00231$:
	ld	c, #0x00
00188$:
;src/states/game.c:276: move_sprite(4 + j, 0, 0);
	ld	a,c
	cp	a,#0x04
	jr	NC, 00192$
	add	a, #0x04
	ld	b, a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	h, #0x00
	ld	l, b
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/states/game.c:275: for (int j = 0; j < 4; j++)
	inc	c
	jr	00188$
00192$:
;src/states/game.c:266: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#10
	inc	(hl)
	jp	NZ, 00191$
	inc	hl
	inc	(hl)
	jp	00191$
00138$:
;src/states/game.c:281: if (input_pressed(J_A | J_B)) {
	ld	a, #0x30
	call	_input_pressed
	or	a, a
	jp	Z, 00169$
;src/states/game.c:283: for (int i = 0; i < current_map->num_entities; i++) {
	xor	a, a
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), a
00194$:
;src/states/game.c:266: for (int i = 0; i < current_map->num_entities; i++) {
	ld	a, (#_current_map)
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (#_current_map + 1)
	ldhl	sp,	#9
;src/states/game.c:283: for (int i = 0; i < current_map->num_entities; i++) {
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#6
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00563$
	bit	7, d
	jr	NZ, 00564$
	cp	a, a
	jr	00564$
00563$:
	bit	7, d
	jr	Z, 00564$
	scf
00564$:
	jp	NC, 00147$
;src/states/game.c:284: entity_t *e = &current_map->entities[i];
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#12
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
	ld	(hl), a
;src/states/game.c:285: int16_t dx = (int16_t)player_x - e->x, dy = (int16_t)player_y - e->y;
	ld	a, (_player_x)
	ld	c, a
	ld	hl, #_player_x + 1
	ld	b, (hl)
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, c
	ld	(hl+), a
	ld	a, b
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
	ldhl	sp,	#9
	ld	(hl-), a
	ld	(hl), e
	ld	a, (#_player_y)
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#1
	ld	(hl+), a
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
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#4
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	c, (hl)
	ld	e, a
	ld	d, c
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
;src/states/game.c:286: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00140$
;src/states/game.c:287: dx = -dx;
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#9
	ld	(hl-), a
	ld	(hl), e
00140$:
;src/states/game.c:288: if (dy < 0)
	ldhl	sp,	#10
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00142$
;src/states/game.c:289: dy = -dy;
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
00142$:
;src/states/game.c:290: if (dx < 24 && dy < 24 && input_pressed(J_A))
	ldhl	sp,	#8
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
	jr	NC, 00195$
	inc	hl
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
	jr	NC, 00195$
	ld	a, #0x10
	call	_input_pressed
	or	a, a
	jr	Z, 00195$
;src/states/game.c:291: text_dialogue(e->dialogue);
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl)
	ld	e, c
	ld	d, a
	call	_text_dialogue
00195$:
;src/states/game.c:283: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#6
	inc	(hl)
	jp	NZ, 00194$
	inc	hl
	inc	(hl)
	jp	00194$
00147$:
;src/states/game.c:295: uint8_t tid = get_tile_at(player_x + 8, player_y); // Check in front
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	d, (hl)
	add	a, #0x08
	ld	e, a
	jr	NC, 00566$
	inc	d
00566$:
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
	call	_get_tile_at
	ld	c, a
;src/states/game.c:296: if (player_dir == 1)
	ld	a, (#_player_dir)
	dec	a
	jr	NZ, 00149$
;src/states/game.c:297: tid = get_tile_at(player_x + 8, player_y - 4); // Up
	ld	a, (_player_y)
	ld	hl, #_player_y + 1
	ld	b, (hl)
	add	a, #0xfc
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	d, (hl)
	add	a, #0x08
	ld	e, a
	jr	NC, 00569$
	inc	d
00569$:
	call	_get_tile_at
	ld	c, a
00149$:
;src/states/game.c:299: if (current_map == &house_map_info &&
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_house_map_info)
	jr	NZ, 00156$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_house_map_info)
	jr	NZ, 00156$
;src/states/game.c:300: (tid == 31 || tid == 32 || tid == 33 || tid == 34)) {
	ld	a,c
	cp	a,#0x1f
	jr	Z, 00155$
	cp	a,#0x20
	jr	Z, 00155$
	cp	a,#0x21
	jr	Z, 00155$
	sub	a, #0x22
	jr	NZ, 00156$
00155$:
;src/states/game.c:301: if (input_pressed(J_B)) {
	push	bc
	ld	a, #0x20
	call	_input_pressed
	pop	bc
	or	a, a
	jr	Z, 00156$
;src/states/game.c:302: if (!has_key) {
	ld	a, (#_has_key)
	or	a, a
	jr	NZ, 00151$
;src/states/game.c:303: text_dialogue("¡HAS ENCONTRADO LA\nLLAVE DEL PORTON!");
	push	bc
	ld	de, #___str_2
	call	_text_dialogue
	pop	bc
;src/states/game.c:304: has_key = 1;
	ld	hl, #_has_key
	ld	(hl), #0x01
	jr	00156$
00151$:
;src/states/game.c:306: text_dialogue("EL ROPERO ESTA\nVACIO.");
	push	bc
	ld	de, #___str_3
	call	_text_dialogue
	pop	bc
00156$:
;src/states/game.c:311: if (current_map == &world_map_info && (tid == 43 || tid == 44)) {
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_world_map_info)
	jr	NZ, 00169$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_world_map_info)
	jr	NZ, 00169$
	ld	a,c
	cp	a,#0x2b
	jr	Z, 00164$
	sub	a, #0x2c
	jr	NZ, 00169$
00164$:
;src/states/game.c:312: if (has_key) {
	ld	a, (#_has_key)
	or	a, a
	jr	Z, 00162$
;src/states/game.c:313: text_dialogue("USAS LA LLAVE...\n¡EL PORTON SE ABRE!");
	ld	de, #___str_4
	call	_text_dialogue
;src/states/game.c:314: player_x = 120;
	ld	hl, #_player_x
	ld	a, #0x78
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:315: player_y = 230; // Level 2 entrance
	ld	hl, #_player_y
	ld	a, #0xe6
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:316: load_map(&level2_map_info);
	ld	de, #_level2_map_info
	call	_load_map
;src/states/game.c:317: return;
	jp	00196$
00162$:
;src/states/game.c:319: text_dialogue("ESTA CERRADO.\nNECESITAS UNA LLAVE.");
	ld	de, #___str_5
	call	_text_dialogue
00169$:
;src/states/game.c:325: if (current_map == &world_map_info) {
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_world_map_info)
	jp	NZ, 00196$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_world_map_info)
	jp	NZ, 00196$
;src/states/game.c:326: if (++env_anim_timer >= 40) {
	ld	hl, #_env_anim_timer
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x28
	jp	C, 00196$
;src/states/game.c:327: env_anim_timer = 0;
	ld	(hl), #0x00
;src/states/game.c:328: env_anim_frame = !env_anim_frame;
	ld	hl, #_env_anim_frame
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/states/game.c:329: if (env_anim_frame) {
	ld	a, (hl)
	or	a, a
	jr	Z, 00171$
;src/states/game.c:330: set_bkg_data(2, 1, &tiles_anim_data[0]);
	ld	de, #_tiles_anim_data
	push	de
	ld	hl, #0x102
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:331: set_bkg_data(4, 1, &tiles_anim_data[16]);
	ld	de, #(_tiles_anim_data + 16)
	push	de
	ld	hl, #0x104
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:332: set_bkg_data(5, 1, &tiles_anim_data[32]);
	ld	de, #(_tiles_anim_data + 32)
	push	de
	ld	hl, #0x105
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:333: set_bkg_data(6, 1, &tiles_anim_data[48]);
	ld	de, #(_tiles_anim_data + 48)
	push	de
	ld	hl, #0x106
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:334: set_bkg_data(12, 1, &tiles_anim_data[64]);
	ld	de, #(_tiles_anim_data + 64)
	push	de
	ld	hl, #0x10c
	push	hl
	call	_set_bkg_data
	add	sp, #4
	jr	00196$
00171$:
;src/states/game.c:336: set_bkg_data(2, 1, &tiles_data[32]);
	ld	de, #(_tiles_data + 32)
	push	de
	ld	hl, #0x102
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:337: set_bkg_data(4, 1, &tiles_data[64]);
	ld	de, #(_tiles_data + 64)
	push	de
	ld	hl, #0x104
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:338: set_bkg_data(5, 1, &tiles_data[80]);
	ld	de, #(_tiles_data + 80)
	push	de
	ld	hl, #0x105
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:339: set_bkg_data(6, 1, &tiles_data[96]);
	ld	de, #(_tiles_data + 96)
	push	de
	ld	hl, #0x106
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:340: set_bkg_data(12, 1, &tiles_data[192]);
	ld	de, #(_tiles_data + 192)
	push	de
	ld	hl, #0x10c
	push	hl
	call	_set_bkg_data
	add	sp, #4
00196$:
;src/states/game.c:344: }
	add	sp, #12
	ret
___str_2:
	.db 0xc2
	.db 0xa1
	.ascii "HAS ENCONTRADO LA"
	.db 0x0a
	.ascii "LLAVE DEL PORTON!"
	.db 0x00
___str_3:
	.ascii "EL ROPERO ESTA"
	.db 0x0a
	.ascii "VACIO."
	.db 0x00
___str_4:
	.ascii "USAS LA LLAVE..."
	.db 0x0a
	.db 0xc2
	.db 0xa1
	.ascii "EL PORTON SE ABRE!"
	.db 0x00
___str_5:
	.ascii "ESTA CERRADO."
	.db 0x0a
	.ascii "NECESITAS UNA LLAVE."
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__player_x:
	.dw #0x0098
__xinit__player_y:
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
__xinit__has_key:
	.db #0x00	; 0
__xinit__env_anim_timer:
	.db #0x00	; 0
__xinit__env_anim_frame:
	.db #0x00	; 0
	.area _CABS (ABS)
