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
	.globl _fade_in
	.globl _fade_out
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
;src/states/game.c:58: uint8_t get_tile_at(uint16_t x, uint16_t y) {
;	---------------------------------
; Function get_tile_at
; ---------------------------------
_get_tile_at::
	add	sp, #-6
;src/states/game.c:59: uint16_t tx = x / 8, ty = y / 8;
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
;src/states/game.c:60: if (tx >= current_map->w || ty >= current_map->h)
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
;src/states/game.c:61: return 1;
	ld	a, #0x01
	jr	00104$
00102$:
;src/states/game.c:62: return current_map->tiles[ty * current_map->w + tx];
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
;src/states/game.c:63: }
	add	sp, #6
	ret
;src/states/game.c:65: void update_camera() {
;	---------------------------------
; Function update_camera
; ---------------------------------
_update_camera::
	add	sp, #-4
;src/states/game.c:66: uint16_t w = current_map->w * 8, h = current_map->h * 8;
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
;src/states/game.c:67: if (player_x > SCREEN_WIDTH / 2)
	ld	hl, #_player_x
	ld	a, #0x50
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00102$
;src/states/game.c:68: camera_x = player_x - SCREEN_WIDTH / 2;
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
;src/states/game.c:70: camera_x = 0;
	xor	a, a
	ld	hl, #_camera_x
	ld	(hl+), a
	ld	(hl), a
00103$:
;src/states/game.c:71: if (player_y > SCREEN_HEIGHT / 2)
	ld	hl, #_player_y
	ld	a, #0x48
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00105$
;src/states/game.c:72: camera_y = player_y - SCREEN_HEIGHT / 2;
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
;src/states/game.c:74: camera_y = 0;
	xor	a, a
	ld	hl, #_camera_y
	ld	(hl+), a
	ld	(hl), a
00106$:
;src/states/game.c:75: if (camera_x > w - SCREEN_WIDTH)
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
;src/states/game.c:76: camera_x = (w > SCREEN_WIDTH) ? (w - SCREEN_WIDTH) : 0;
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
;src/states/game.c:77: if (camera_y > h - SCREEN_HEIGHT)
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
;src/states/game.c:78: camera_y = (h > SCREEN_HEIGHT) ? (h - SCREEN_HEIGHT) : 0;
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
;src/states/game.c:79: move_bkg(camera_x, camera_y);
	ld	a, (_camera_y)
	ld	c, a
	ld	a, (#_camera_x)
	ldh	(_SCX_REG + 0), a
;./gbdk/include/gb/gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/states/game.c:79: move_bkg(camera_x, camera_y);
;src/states/game.c:80: }
	add	sp, #4
	ret
;src/states/game.c:82: void load_map(map_info_t *m) {
;	---------------------------------
; Function load_map
; ---------------------------------
_load_map::
	add	sp, #-3
;src/states/game.c:83: fade_out();
	push	de
	call	_fade_out
	pop	bc
;src/states/game.c:84: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:85: current_map = m;
	ld	hl, #_current_map
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:86: for (int i = 4; i < 40; i++)
	ld	e, #0x04
00108$:
	ld	a, e
	sub	a, #0x28
	jr	NC, 00101$
;src/states/game.c:87: move_sprite(i, 0, 0); // Hide map sprites
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, e
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	a, #<(_shadow_OAM)
	add	a, l
	ld	l, a
	ld	a, #>(_shadow_OAM)
	adc	a, h
	ld	h, a
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/states/game.c:86: for (int i = 4; i < 40; i++)
	inc	e
	jr	00108$
00101$:
;src/states/game.c:89: if (m == &house_map_info)
	ld	a, #<(_house_map_info)
	sub	a, c
	jr	NZ, 00103$
	ld	a, #>(_house_map_info)
	sub	a, b
	jr	NZ, 00103$
;src/states/game.c:90: fill_bkg_rect(0, 0, 32, 32, 26);
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
;src/states/game.c:91: set_bkg_tiles(0, 0, m->w, m->h, m->tiles);
	ld	l, c
	ld	h, b
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ld	d, a
	inc	bc
	inc	bc
	ld	a, (bc)
	push	hl
	push	de
	inc	sp
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/states/game.c:92: update_camera();
	call	_update_camera
;src/states/game.c:95: uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
	ld	a, (_player_x)
	ld	hl, #_camera_x
	ld	c, (hl)
	sub	a, c
	add	a, #0x08
	ldhl	sp,	#0
	ld	(hl), a
	ld	a, (_player_y)
	ld	hl, #_camera_y
	ld	c, (hl)
	sub	a, c
	add	a, #0x10
	ldhl	sp,	#1
	ld	(hl), a
;src/states/game.c:96: for (int i = 0; i < 4; i++)
	ld	e, #0x00
00111$:
	ld	a, e
	sub	a, #0x04
	jr	NC, 00104$
;src/states/game.c:97: move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));
	ldhl	sp,	#1
	ld	c, (hl)
	ld	a, e
	sub	a, #0x02
	jr	C, 00115$
	ld	a, #0x08
	jr	00116$
00115$:
	xor	a, a
00116$:
	add	a, c
	ldhl	sp,	#2
	ld	(hl-), a
	dec	hl
	ld	c, (hl)
	ld	b, e
	ld	a, b
	and	a, #0x01
	ld	a, #0x08
	jr	NZ, 00118$
	xor	a, a
00118$:
	add	a, c
	ld	d, a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	bc, #_shadow_OAM
	add	hl, bc
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	push	hl
	ldhl	sp,	#4
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:96: for (int i = 0; i < 4; i++)
	inc	e
	jr	00111$
00104$:
;src/states/game.c:99: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:100: fade_in();
	call	_fade_in
;src/states/game.c:101: }
	add	sp, #3
	ret
;src/states/game.c:103: void update_player_sprite() {
;	---------------------------------
; Function update_player_sprite
; ---------------------------------
_update_player_sprite::
	dec	sp
;src/states/game.c:104: uint8_t base =
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
;src/states/game.c:108: uint8_t prop = (player_dir == 3) ? S_FLIPX : 0;
	ld	a, b
	or	a, a
	ld	e, #0x20
	jr	NZ, 00131$
	ld	e, #0x00
00131$:
;src/states/game.c:109: if (prop == 0) {
	ld	a, e
	or	a, a
	jr	NZ, 00104$
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), c
;src/states/game.c:111: set_sprite_tile(1, base + 1);
	ld	a, c
	inc	a
	ldhl	sp,	#0
	ld	(hl), a
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	de, #(_shadow_OAM + 6)
	ld	a, (hl)
	ld	(de), a
;src/states/game.c:112: set_sprite_tile(2, base + 2);
	ld	b, c
	inc	b
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), b
;src/states/game.c:113: set_sprite_tile(3, base + 3);
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), c
;src/states/game.c:114: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00117$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00122$
;src/states/game.c:115: set_sprite_prop(i, 0);
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
;src/states/game.c:114: for (int i = 0; i < 4; i++)
	inc	c
	jr	00117$
00104$:
;src/states/game.c:117: set_sprite_tile(0, base + 1);
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
;src/states/game.c:119: set_sprite_tile(2, base + 3);
	ld	c, b
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), c
;src/states/game.c:120: set_sprite_tile(3, base + 2);
	inc	b
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), b
;src/states/game.c:121: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00120$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00122$
;src/states/game.c:122: set_sprite_prop(i, S_FLIPX);
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
;src/states/game.c:121: for (int i = 0; i < 4; i++)
	inc	c
	jr	00120$
00122$:
;src/states/game.c:124: }
	inc	sp
	ret
;src/states/game.c:126: uint8_t is_solid(uint16_t x, uint16_t y) {
;	---------------------------------
; Function is_solid
; ---------------------------------
_is_solid::
;src/states/game.c:127: uint8_t tid = get_tile_at(x, y);
	call	_get_tile_at
	ld	c, a
;src/states/game.c:128: for (int i = 0; i < 16; i++) {
	ld	b, #0x00
00107$:
	ld	a, b
	sub	a, #0x10
	jr	NC, 00105$
;src/states/game.c:129: if (current_map->solid_tiles[i] == 255)
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
;src/states/game.c:131: if (tid == current_map->solid_tiles[i])
	sub	a, c
	jr	NZ, 00108$
;src/states/game.c:132: return 0;
	xor	a, a
	ret
00108$:
;src/states/game.c:128: for (int i = 0; i < 16; i++) {
	inc	b
	jr	00107$
00105$:
;src/states/game.c:134: return 1;
	ld	a, #0x01
;src/states/game.c:135: }
	ret
;src/states/game.c:137: uint8_t can_move(uint16_t nx, uint16_t ny) {
;	---------------------------------
; Function can_move
; ---------------------------------
_can_move::
	add	sp, #-14
	ldhl	sp,	#6
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#4
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:138: uint16_t w = current_map->w * 8, h = current_map->h * 8;
	ld	a, (#_current_map)
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (#_current_map + 1)
	ldhl	sp,	#9
	ld	(hl-), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	a, (bc)
	ldhl	sp,	#12
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x03
00217$:
	ldhl	sp,	#12
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00217$
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0003
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl-)
	ld	(hl+), a
	ld	(hl), #0x00
	ld	a, #0x03
00218$:
	ldhl	sp,	#12
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 00218$
;src/states/game.c:139: if (nx < 4 || nx > w - 20 || ny < 8 || ny > h - 20)
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x04
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00101$
	ldhl	sp,	#10
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,	#10
	ld	e, l
	ld	d, h
	ldhl	sp,	#0
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	C, 00101$
	ldhl	sp,	#4
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x08
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00101$
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0014
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#13
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,	#12
	ld	e, l
	ld	d, h
	ldhl	sp,	#2
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	jr	NC, 00102$
00101$:
;src/states/game.c:140: return 0;
	xor	a, a
	jp	00124$
00102$:
;src/states/game.c:141: if (is_solid(nx + 4, ny + 8) || is_solid(nx + 11, ny + 8) ||
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
	pop	de
	push	de
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_is_solid
	ldhl	sp,#13
	ld	(hl), a
	or	a, a
	jr	NZ, 00106$
	pop	de
	push	de
	ld	hl, #0x000b
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_is_solid
	ldhl	sp,#9
	ld	(hl), a
	or	a, a
	jr	NZ, 00106$
;src/states/game.c:142: is_solid(nx + 4, ny + 15) || is_solid(nx + 11, ny + 15))
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000f
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
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_is_solid
	or	a, a
	jr	NZ, 00106$
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#12
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_is_solid
	or	a, a
	jr	Z, 00138$
00106$:
;src/states/game.c:143: return 0;
	xor	a, a
	jp	00124$
;src/states/game.c:146: for (int i = 0; i < current_map->num_entities; i++) {
00138$:
	xor	a, a
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), a
00123$:
;src/states/game.c:138: uint16_t w = current_map->w * 8, h = current_map->h * 8;
	ld	a, (#_current_map)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (#_current_map + 1)
	ldhl	sp,	#11
;src/states/game.c:146: for (int i = 0; i < current_map->num_entities; i++) {
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#8
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00219$
	bit	7, d
	jr	NZ, 00220$
	cp	a, a
	jr	00220$
00219$:
	bit	7, d
	jr	Z, 00220$
	scf
00220$:
	jp	NC, 00121$
;src/states/game.c:147: entity_t *e = &current_map->entities[i];
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#12
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#8
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
	ldhl	sp,	#12
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
;src/states/game.c:148: if (!e->active)
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
	jp	Z, 00120$
;src/states/game.c:150: int16_t dx = (int16_t)nx - e->x, dy = (int16_t)ny - e->y;
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,#2
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#0
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	pop	hl
	push	hl
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	c, (hl)
	inc	hl
	ld	e, a
	ld	d, c
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#13
	ld	(hl-), a
;src/states/game.c:151: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00114$
;src/states/game.c:152: dx = -dx;
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
00114$:
;src/states/game.c:153: if (dy < 0)
	ldhl	sp,	#12
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00116$
;src/states/game.c:154: dy = -dy;
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
00116$:
;src/states/game.c:155: if (dx < 12 && dy < 12)
	ldhl	sp,	#10
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
	jr	NC, 00120$
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
	jr	NC, 00120$
;src/states/game.c:156: return 0; // Collide if too close
	xor	a, a
	jr	00124$
00120$:
;src/states/game.c:146: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#8
	inc	(hl)
	jp	NZ, 00123$
	inc	hl
	inc	(hl)
	jp	00123$
00121$:
;src/states/game.c:158: return 1;
	ld	a, #0x01
00124$:
;src/states/game.c:159: }
	add	sp, #14
	ret
;src/states/game.c:163: void game_init(void) {
;	---------------------------------
; Function game_init
; ---------------------------------
_game_init::
	add	sp, #-23
;src/states/game.c:164: DISPLAY_OFF;
	call	_display_off
;src/states/game.c:165: set_bkg_data(0, 62, tiles_data); // All tiles
	ld	de, #_tiles_data
	push	de
	ld	hl, #0x3e00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:168: world_map_info.tiles = map_data;
	ld	hl, #_world_map_info
	ld	a, #<(_map_data)
	ld	(hl+), a
;src/states/game.c:169: world_map_info.w = MAP_WIDTH;
	ld	a, #>(_map_data)
	ld	(hl+), a
	ld	(hl), #0x20
;src/states/game.c:170: world_map_info.h = MAP_HEIGHT;
	ld	hl, #_world_map_info + 3
	ld	(hl), #0x20
;src/states/game.c:171: world_map_info.entities = world_ents;
	ld	hl, #(_world_map_info + 4)
	ld	a, #<(_world_ents)
	ld	(hl+), a
;src/states/game.c:172: world_map_info.num_entities = 1;
	ld	a, #>(_world_ents)
	ld	(hl+), a
	ld	(hl), #0x01
;src/states/game.c:173: uint8_t w_pass[] = {0, 2, 3, 4, 5, 21, 22, 58, 59, 255};
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
	ld	a, #0x3a
	ld	(hl+), a
	ld	a, #0x3b
	ld	(hl+), a
	ld	(hl), #0xff
;src/states/game.c:174: memcpy(world_map_info.solid_tiles, w_pass, 10);
	ld	de, #0x000a
	push	de
	ld	de, #(_world_map_info + 7)
	call	_memcpy
;src/states/game.c:175: world_ents[0].x = 210;
	ld	hl, #_world_ents
	ld	a, #0xd2
	ld	(hl+), a
;src/states/game.c:176: world_ents[0].y = 230;
	xor	a, a
	ld	(hl+), a
	ld	a, #0xe6
	ld	(hl+), a
;src/states/game.c:177: world_ents[0].type = ENT_NPC;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/states/game.c:178: world_ents[0].dialogue =
	ld	hl, #(_world_ents + 5)
	ld	a, #<(___str_0)
	ld	(hl+), a
;src/states/game.c:180: world_ents[0].sprite_base = 24;
	ld	a, #>(___str_0)
	ld	(hl+), a
	ld	(hl), #0x18
;src/states/game.c:181: world_ents[0].active = 1;
	ld	hl, #_world_ents + 8
	ld	(hl), #0x01
;src/states/game.c:183: house_map_info.tiles = house_map;
	ld	hl, #_house_map_info
	ld	a, #<(_house_map)
	ld	(hl+), a
;src/states/game.c:184: house_map_info.w = HOUSE_WIDTH;
	ld	a, #>(_house_map)
	ld	(hl+), a
	ld	(hl), #0x14
;src/states/game.c:185: house_map_info.h = HOUSE_HEIGHT;
	ld	hl, #_house_map_info + 3
	ld	(hl), #0x12
;src/states/game.c:186: house_map_info.entities = house_ents;
	ld	hl, #(_house_map_info + 4)
	ld	a, #<(_house_ents)
	ld	(hl+), a
;src/states/game.c:187: house_map_info.num_entities = 1;
	ld	a, #>(_house_ents)
	ld	(hl+), a
	ld	(hl), #0x01
;src/states/game.c:188: uint8_t h_pass[] = {25, 35, 255};
	ldhl	sp,	#10
	ld	c, l
	ld	b, h
	ld	(hl), #0x19
	ldhl	sp,	#11
	ld	a, #0x23
	ld	(hl+), a
	ld	(hl), #0xff
;src/states/game.c:189: memcpy(house_map_info.solid_tiles, h_pass, 3);
	ld	de, #0x0003
	push	de
	ld	de, #(_house_map_info + 7)
	call	_memcpy
;src/states/game.c:190: house_ents[0].x = 40;
	ld	hl, #_house_ents
	ld	a, #0x28
	ld	(hl+), a
;src/states/game.c:191: house_ents[0].y = 48;
	xor	a, a
	ld	(hl+), a
	ld	a, #0x30
	ld	(hl+), a
;src/states/game.c:192: house_ents[0].type = ENT_NPC;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/states/game.c:193: house_ents[0].dialogue = "PUEDES DESCANSAR,\nPERO NO TOQUES\nMIS COSAS!";
	ld	hl, #(_house_ents + 5)
	ld	a, #<(___str_1)
	ld	(hl+), a
;src/states/game.c:194: house_ents[0].sprite_base = 24;
	ld	a, #>(___str_1)
	ld	(hl+), a
	ld	(hl), #0x18
;src/states/game.c:195: house_ents[0].active = 1;
	ld	hl, #_house_ents + 8
	ld	(hl), #0x01
;src/states/game.c:197: level2_map_info.tiles = level2_map;
	ld	hl, #_level2_map_info
	ld	a, #<(_level2_map)
	ld	(hl+), a
;src/states/game.c:198: level2_map_info.w = L2_WIDTH;
	ld	a, #>(_level2_map)
	ld	(hl+), a
	ld	(hl), #0x20
;src/states/game.c:199: level2_map_info.h = L2_HEIGHT;
	ld	hl, #_level2_map_info + 3
	ld	(hl), #0x20
;src/states/game.c:200: level2_map_info.entities = level2_ents;
	ld	hl, #(_level2_map_info + 4)
	ld	a, #<(_level2_ents)
	ld	(hl+), a
;src/states/game.c:201: level2_map_info.num_entities = 0;
	ld	a, #>(_level2_ents)
	ld	(hl+), a
	ld	(hl), #0x00
;src/states/game.c:202: uint8_t l2_pass[] = {0, 2, 3, 4, 255};
	ldhl	sp,	#13
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	ldhl	sp,	#14
	ld	a, #0x02
	ld	(hl+), a
	ld	a, #0x03
	ld	(hl+), a
	ld	a, #0x04
	ld	(hl+), a
	ld	(hl), #0xff
;src/states/game.c:203: memcpy(level2_map_info.solid_tiles, l2_pass, 5);
	ld	de, #0x0005
	push	de
	ld	de, #(_level2_map_info + 7)
	call	_memcpy
;src/states/game.c:205: current_map = &world_map_info;
	ld	bc, #_world_map_info
	ld	hl, #_current_map
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:206: update_camera();
	push	bc
	call	_update_camera
	pop	bc
;src/states/game.c:207: uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
	ld	a, (_player_x)
	ld	hl, #_camera_x
	ld	e, (hl)
	sub	a, e
	add	a, #0x08
	ldhl	sp,	#18
	ld	(hl), a
	ld	a, (_player_y)
	ld	hl, #_camera_y
	ld	e, (hl)
	sub	a, e
	add	a, #0x10
	ldhl	sp,	#19
	ld	(hl), a
;src/states/game.c:208: for (int i = 0; i < 4; i++)
	ld	e, #0x00
00104$:
	ld	a, e
	sub	a, #0x04
	jr	NC, 00101$
;src/states/game.c:209: move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));
	ldhl	sp,	#19
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl), a
	ld	a, e
	sub	a, #0x02
	jr	C, 00108$
	ld	a, #0x08
	jr	00109$
00108$:
	xor	a, a
00109$:
	ldhl	sp,	#22
	ld	l, (hl)
	add	a, l
	ldhl	sp,	#20
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#22
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl)
	and	a, #0x01
	ld	a, #0x08
	jr	NZ, 00111$
	xor	a, a
00111$:
	ldhl	sp,	#22
	ld	d, (hl)
	add	a, d
	ld	(hl-), a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	xor	a, a
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
	push	hl
	ldhl	sp,	#22
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	push	hl
	ldhl	sp,	#24
	ld	a, (hl)
	pop	hl
	ld	(hl), a
;src/states/game.c:208: for (int i = 0; i < 4; i++)
	inc	e
	jr	00104$
00101$:
;src/states/game.c:211: load_map(&world_map_info);
	ld	e, c
	ld	d, b
	call	_load_map
;src/states/game.c:213: BGP_REG = OBP0_REG = OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/states/game.c:214: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:215: set_sprite_data(0, 24, player_sprites);
	ld	de, #_player_sprites
	push	de
	ld	hl, #0x1800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:216: set_sprite_data(24, 4, npc_child_sprite);
	ld	bc, #_npc_child_sprite
	push	bc
	ld	hl, #0x418
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:217: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:218: text_init();
	call	_text_init
;src/states/game.c:219: music_init();
	call	_music_init
;src/states/game.c:220: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:221: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:222: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:223: }
	add	sp, #23
	ret
___str_0:
	.ascii "MI CASA ES LA DE"
	.db 0x0a
	.ascii "AQUI ARRIBA."
	.db 0x0a
	.ascii "BUSCA LA LLAVE EN"
	.db 0x0a
	.ascii "MI ROPERO."
	.db 0x00
___str_1:
	.ascii "PUEDES DESCANSAR,"
	.db 0x0a
	.ascii "PERO NO TOQUES"
	.db 0x0a
	.ascii "MIS COSAS!"
	.db 0x00
;src/states/game.c:225: void game_update(void) {
;	---------------------------------
; Function game_update
; ---------------------------------
_game_update::
	add	sp, #-12
;src/states/game.c:226: music_update();
	call	_music_update
;src/states/game.c:227: uint8_t moved = 0;
	ld	c, #0x00
;src/states/game.c:228: uint16_t nx = player_x, ny = player_y;
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
;src/states/game.c:230: if (input_held(J_UP)) {
	push	bc
	ld	a, #0x04
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00110$
;src/states/game.c:231: ny--;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:232: player_dir = 1;
	ld	hl, #_player_dir
	ld	(hl), #0x01
;src/states/game.c:233: moved = 1;
	ld	c, #0x01
	jr	00111$
00110$:
;src/states/game.c:234: } else if (input_held(J_DOWN)) {
	push	bc
	ld	a, #0x08
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00107$
;src/states/game.c:235: ny++;
	ldhl	sp,	#10
	inc	(hl)
	jr	NZ, 00605$
	inc	hl
	inc	(hl)
00605$:
;src/states/game.c:236: player_dir = 0;
	xor	a, a
	ld	(#_player_dir),a
;src/states/game.c:237: moved = 1;
	ld	c, #0x01
	jr	00111$
00107$:
;src/states/game.c:238: } else if (input_held(J_LEFT)) {
	push	bc
	ld	a, #0x02
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00104$
;src/states/game.c:239: nx--;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:240: player_dir = 2;
	ld	hl, #_player_dir
	ld	(hl), #0x02
;src/states/game.c:241: moved = 1;
	ld	c, #0x01
	jr	00111$
00104$:
;src/states/game.c:242: } else if (input_held(J_RIGHT)) {
	push	bc
	ld	a, #0x01
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00111$
;src/states/game.c:243: nx++;
	ldhl	sp,	#8
	inc	(hl)
	jr	NZ, 00606$
	inc	hl
	inc	(hl)
00606$:
;src/states/game.c:244: player_dir = 3;
	ld	hl, #_player_dir
	ld	(hl), #0x03
;src/states/game.c:245: moved = 1;
	ld	c, #0x01
00111$:
;src/states/game.c:248: if (moved) {
	ld	a, c
	or	a, a
	jp	Z, 00139$
;src/states/game.c:249: if (can_move(nx, ny)) {
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
	jp	Z, 00134$
;src/states/game.c:250: player_x = nx;
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(#_player_x),a
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(#_player_x + 1),a
;src/states/game.c:251: player_y = ny;
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(#_player_y),a
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(#_player_y + 1),a
;src/states/game.c:252: update_camera();
	call	_update_camera
;src/states/game.c:253: uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
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
;src/states/game.c:254: for (int i = 0; i < 4; i++)
	ldhl	sp,	#11
	ld	(hl), #0x00
00191$:
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00112$
;src/states/game.c:255: move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));
	ldhl	sp,	#7
	ld	c, (hl)
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x02
	jr	C, 00207$
	ld	a, #0x08
	jr	00208$
00207$:
	xor	a, a
00208$:
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
	jr	NZ, 00210$
	xor	a, a
00210$:
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
;src/states/game.c:254: for (int i = 0; i < 4; i++)
	ldhl	sp,	#11
	inc	(hl)
	jr	00191$
00112$:
;src/states/game.c:258: uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
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
	jr	NC, 00607$
	inc	d
00607$:
	call	_get_tile_at
	ldhl	sp,	#9
	ld	(hl), a
;src/states/game.c:259: if (current_map == &world_map_info &&
;src/states/game.c:258: uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
	ld	a, (_player_y)
	ld	e, a
	ld	hl, #_player_y + 1
	ld	d, (hl)
	ld	a, (#_player_x)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#11
	ld	(hl), a
;src/states/game.c:263: saved_world_y = player_y + 16;
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	b, h
;src/states/game.c:259: if (current_map == &world_map_info &&
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_world_map_info)
	jr	NZ, 00117$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_world_map_info)
	jr	NZ, 00117$
;src/states/game.c:260: (tid == 21 || tid == 22 || tid == 58 || tid == 59)) {
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x15
	jr	Z, 00116$
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x16
	jr	Z, 00116$
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x3a
	jr	Z, 00116$
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x3b
	jr	NZ, 00117$
00116$:
;src/states/game.c:261: if (player_x > 160 && player_y > 160) {
	ldhl	sp,	#10
	ld	a, #0xa0
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00117$
	ld	a, #0xa0
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	NC, 00117$
;src/states/game.c:262: saved_world_x = player_x;
	ld	a, (#_player_x)
	ld	(#_saved_world_x),a
	ld	a, (#_player_x + 1)
	ld	(#_saved_world_x + 1),a
;src/states/game.c:263: saved_world_y = player_y + 16;
	ld	hl, #_saved_world_y
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:264: player_x = 76;
	ld	hl, #_player_x
	ld	a, #0x4c
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:265: player_y = 120; // Near Door in House
	ld	hl, #_player_y
	ld	a, #0x78
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:266: load_map(&house_map_info);
	ld	de, #_house_map_info
	call	_load_map
;src/states/game.c:267: return;
	jp	00205$
00117$:
;src/states/game.c:270: tid = get_tile_at(player_x + 8, player_y + 16);
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	e, l
	ld	d, h
	call	_get_tile_at
	ld	c, a
;src/states/game.c:271: if (current_map == &house_map_info && tid == 35) {
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_house_map_info)
	jr	NZ, 00123$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_house_map_info)
	jr	NZ, 00123$
	ld	a, c
	sub	a, #0x23
	jr	NZ, 00123$
;src/states/game.c:272: player_x = saved_world_x;
	ld	a, (#_saved_world_x)
	ld	(#_player_x),a
	ld	a, (#_saved_world_x + 1)
	ld	(#_player_x + 1),a
;src/states/game.c:273: player_y = saved_world_y;
	ld	a, (#_saved_world_y)
	ld	(#_player_y),a
	ld	a, (#_saved_world_y + 1)
	ld	(#_player_y + 1),a
;src/states/game.c:274: player_dir = 0;
	xor	a, a
	ld	(#_player_dir),a
;src/states/game.c:275: load_map(&world_map_info);
	ld	de, #_world_map_info
	call	_load_map
;src/states/game.c:276: return;
	jp	00205$
00123$:
;src/states/game.c:278: if (current_map == &level2_map_info && tid == 0 && player_y > 230) {
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_level2_map_info)
	jr	NZ, 00126$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_level2_map_info)
	jr	NZ, 00126$
	or	a, c
	jr	NZ, 00126$
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
	ld	a, #0xe6
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	NC, 00126$
;src/states/game.c:279: player_x = 124;
	ld	hl, #_player_x
	ld	a, #0x7c
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:280: player_y = 32;
	ld	hl, #_player_y
	ld	a, #0x20
	ld	(hl+), a
;src/states/game.c:281: player_dir = 0;
	xor	a, a
	ld	(hl), a
	ld	(#_player_dir),a
;src/states/game.c:282: load_map(&world_map_info);
	ld	de, #_world_map_info
	call	_load_map
;src/states/game.c:283: return;
	jp	00205$
00126$:
;src/states/game.c:286: if (++anim_timer > 6) {
	ld	hl, #_anim_timer
	inc	(hl)
	ld	a, #0x06
	sub	a, (hl)
	jr	NC, 00248$
;src/states/game.c:287: anim_frame = !anim_frame;
	ld	hl, #_anim_frame
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/states/game.c:288: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
;src/states/game.c:289: update_player_sprite();
	call	_update_player_sprite
	jr	00248$
00134$:
;src/states/game.c:291: } else if (anim_frame != 0) {
	ld	hl, #_anim_frame
	ld	a, (hl)
	or	a, a
	jr	Z, 00248$
;src/states/game.c:292: anim_frame = 0;
	ld	(hl), #0x00
;src/states/game.c:293: update_player_sprite();
	call	_update_player_sprite
	jr	00248$
00139$:
;src/states/game.c:296: if (anim_frame != 0) {
	ld	hl, #_anim_frame
	ld	a, (hl)
	or	a, a
	jr	Z, 00137$
;src/states/game.c:297: anim_frame = 0;
	ld	(hl), #0x00
;src/states/game.c:298: update_player_sprite();
	call	_update_player_sprite
00137$:
;src/states/game.c:300: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
;src/states/game.c:304: for (int i = 0; i < current_map->num_entities; i++) {
00248$:
	xor	a, a
	ldhl	sp,	#10
	ld	(hl+), a
	ld	(hl), a
00200$:
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
	jr	Z, 00621$
	bit	7, d
	jr	NZ, 00622$
	cp	a, a
	jr	00622$
00621$:
	bit	7, d
	jr	Z, 00622$
	scf
00622$:
	jp	NC, 00147$
;src/states/game.c:305: entity_t *e = &current_map->entities[i];
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
;src/states/game.c:306: uint16_t esx = e->x - camera_x + 8, esy = e->y - camera_y + 16;
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
;src/states/game.c:307: if (esx < 168 && esy < 160) {
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0xa8
	ld	a, b
	sbc	a, #0x00
	jp	NC, 00247$
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0xa0
	ld	a, b
	sbc	a, #0x00
	jr	NC, 00247$
;src/states/game.c:308: for (int j = 0; j < 4; j++) {
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
00194$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00201$
;src/states/game.c:309: move_sprite(4 + j, esx + (j % 2 ? 8 : 0), esy + (j >= 2 ? 8 : 0));
	ldhl	sp,	#4
	ld	b, (hl)
	ld	a, c
	sub	a, #0x02
	jr	C, 00211$
	ld	a, #0x08
	jr	00212$
00211$:
	xor	a, a
00212$:
	add	a, b
	ld	e, a
	ldhl	sp,	#2
	ld	b, (hl)
	ld	a, c
	and	a, #0x01
	ld	a, #0x08
	jr	NZ, 00214$
	xor	a, a
00214$:
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
;src/states/game.c:310: set_sprite_tile(4 + j, e->sprite_base + j);
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
;src/states/game.c:308: for (int j = 0; j < 4; j++) {
	inc	c
	jr	00194$
;src/states/game.c:313: for (int j = 0; j < 4; j++)
00247$:
	ld	c, #0x00
00197$:
;src/states/game.c:314: move_sprite(4 + j, 0, 0);
	ld	a,c
	cp	a,#0x04
	jr	NC, 00201$
	add	a, #0x04
	ld	b, a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/states/game.c:313: for (int j = 0; j < 4; j++)
	inc	c
	jr	00197$
00201$:
;src/states/game.c:304: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#10
	inc	(hl)
	jp	NZ, 00200$
	inc	hl
	inc	(hl)
	jp	00200$
00147$:
;src/states/game.c:318: if (input_pressed(J_A | J_B)) {
	ld	a, #0x30
	call	_input_pressed
	or	a, a
	jp	Z, 00178$
;src/states/game.c:319: for (int i = 0; i < current_map->num_entities; i++) {
	xor	a, a
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), a
00203$:
;src/states/game.c:304: for (int i = 0; i < current_map->num_entities; i++) {
	ld	a, (#_current_map)
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (#_current_map + 1)
	ldhl	sp,	#9
;src/states/game.c:319: for (int i = 0; i < current_map->num_entities; i++) {
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
	jr	Z, 00624$
	bit	7, d
	jr	NZ, 00625$
	cp	a, a
	jr	00625$
00624$:
	bit	7, d
	jr	Z, 00625$
	scf
00625$:
	jp	NC, 00156$
;src/states/game.c:320: entity_t *e = &current_map->entities[i];
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
;src/states/game.c:321: int16_t dx = (int16_t)player_x - e->x, dy = (int16_t)player_y - e->y;
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
;src/states/game.c:322: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00149$
;src/states/game.c:323: dx = -dx;
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
00149$:
;src/states/game.c:324: if (dy < 0)
	ldhl	sp,	#10
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00151$
;src/states/game.c:325: dy = -dy;
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
00151$:
;src/states/game.c:326: if (dx < 24 && dy < 24 && input_pressed(J_A))
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
	jr	NC, 00204$
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
	jr	NC, 00204$
	ld	a, #0x10
	call	_input_pressed
	or	a, a
	jr	Z, 00204$
;src/states/game.c:327: text_dialogue(e->dialogue);
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
00204$:
;src/states/game.c:319: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#6
	inc	(hl)
	jp	NZ, 00203$
	inc	hl
	inc	(hl)
	jp	00203$
00156$:
;src/states/game.c:330: uint8_t tid = get_tile_at(player_x + 8, player_y);
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	d, (hl)
	add	a, #0x08
	ld	e, a
	jr	NC, 00627$
	inc	d
00627$:
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
	call	_get_tile_at
	ld	c, a
;src/states/game.c:331: if (player_dir == 1)
	ld	a, (#_player_dir)
	dec	a
	jr	NZ, 00158$
;src/states/game.c:332: tid = get_tile_at(player_x + 8, player_y - 4);
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
	jr	NC, 00630$
	inc	d
00630$:
	call	_get_tile_at
	ld	c, a
00158$:
;src/states/game.c:334: if (current_map == &house_map_info &&
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_house_map_info)
	jr	NZ, 00165$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_house_map_info)
	jr	NZ, 00165$
;src/states/game.c:335: (tid == 31 || tid == 32 || tid == 33 || tid == 34)) {
	ld	a,c
	cp	a,#0x1f
	jr	Z, 00164$
	cp	a,#0x20
	jr	Z, 00164$
	cp	a,#0x21
	jr	Z, 00164$
	sub	a, #0x22
	jr	NZ, 00165$
00164$:
;src/states/game.c:336: if (input_pressed(J_B)) {
	push	bc
	ld	a, #0x20
	call	_input_pressed
	pop	bc
	or	a, a
	jr	Z, 00165$
;src/states/game.c:337: if (!has_key) {
	ld	a, (#_has_key)
	or	a, a
	jr	NZ, 00160$
;src/states/game.c:338: text_dialogue("¡HAS ENCONTRADO LA\nLLAVE DEL PORTON!");
	push	bc
	ld	de, #___str_2
	call	_text_dialogue
	pop	bc
;src/states/game.c:339: has_key = 1;
	ld	hl, #_has_key
	ld	(hl), #0x01
	jr	00165$
00160$:
;src/states/game.c:341: text_dialogue("EL ROPERO ESTA\nVACIO.");
	push	bc
	ld	de, #___str_3
	call	_text_dialogue
	pop	bc
00165$:
;src/states/game.c:345: if (current_map == &world_map_info && (tid == 43 || tid == 44)) {
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_world_map_info)
	jr	NZ, 00178$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_world_map_info)
	jr	NZ, 00178$
	ld	a,c
	cp	a,#0x2b
	jr	Z, 00173$
	sub	a, #0x2c
	jr	NZ, 00178$
00173$:
;src/states/game.c:346: if (has_key) {
	ld	a, (#_has_key)
	or	a, a
	jr	Z, 00171$
;src/states/game.c:347: text_dialogue("USAS LA LLAVE...\n¡EL PORTON SE ABRE!");
	ld	de, #___str_4
	call	_text_dialogue
;src/states/game.c:348: player_x = 124;
	ld	hl, #_player_x
	ld	a, #0x7c
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:349: player_y = 230;
	ld	hl, #_player_y
	ld	a, #0xe6
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:350: player_dir = 1;
	ld	hl, #_player_dir
	ld	(hl), #0x01
;src/states/game.c:351: load_map(&level2_map_info);
	ld	de, #_level2_map_info
	call	_load_map
;src/states/game.c:352: return;
	jp	00205$
00171$:
;src/states/game.c:354: text_dialogue("ESTA CERRADO.\nNECESITAS UNA LLAVE.");
	ld	de, #___str_5
	call	_text_dialogue
00178$:
;src/states/game.c:359: if (current_map == &world_map_info) {
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_world_map_info)
	jp	NZ, 00205$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_world_map_info)
	jp	NZ, 00205$
;src/states/game.c:360: if (++env_anim_timer >= 40) {
	ld	hl, #_env_anim_timer
	inc	(hl)
	ld	a, (hl)
	sub	a, #0x28
	jp	C, 00205$
;src/states/game.c:361: env_anim_timer = 0;
	ld	(hl), #0x00
;src/states/game.c:362: env_anim_frame = !env_anim_frame;
	ld	hl, #_env_anim_frame
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/states/game.c:363: if (env_anim_frame) {
	ld	a, (hl)
	or	a, a
	jr	Z, 00180$
;src/states/game.c:364: set_bkg_data(2, 1, &tiles_anim_data[0]);
	ld	de, #_tiles_anim_data
	push	de
	ld	hl, #0x102
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:365: set_bkg_data(4, 1, &tiles_anim_data[16]);
	ld	de, #(_tiles_anim_data + 16)
	push	de
	ld	hl, #0x104
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:366: set_bkg_data(5, 1, &tiles_anim_data[32]);
	ld	de, #(_tiles_anim_data + 32)
	push	de
	ld	hl, #0x105
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:367: set_bkg_data(6, 1, &tiles_anim_data[48]);
	ld	de, #(_tiles_anim_data + 48)
	push	de
	ld	hl, #0x106
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:368: set_bkg_data(12, 1, &tiles_anim_data[64]);
	ld	de, #(_tiles_anim_data + 64)
	push	de
	ld	hl, #0x10c
	push	hl
	call	_set_bkg_data
	add	sp, #4
	jr	00205$
00180$:
;src/states/game.c:370: set_bkg_data(2, 1, &tiles_data[32]);
	ld	de, #(_tiles_data + 32)
	push	de
	ld	hl, #0x102
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:371: set_bkg_data(4, 1, &tiles_data[64]);
	ld	de, #(_tiles_data + 64)
	push	de
	ld	hl, #0x104
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:372: set_bkg_data(5, 1, &tiles_data[80]);
	ld	de, #(_tiles_data + 80)
	push	de
	ld	hl, #0x105
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:373: set_bkg_data(6, 1, &tiles_data[96]);
	ld	de, #(_tiles_data + 96)
	push	de
	ld	hl, #0x106
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:374: set_bkg_data(12, 1, &tiles_data[192]);
	ld	bc, #(_tiles_data + 192)
	push	bc
	ld	hl, #0x10c
	push	hl
	call	_set_bkg_data
	add	sp, #4
00205$:
;src/states/game.c:378: }
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
	.dw #0x0080
__xinit__player_y:
	.dw #0x0080
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
