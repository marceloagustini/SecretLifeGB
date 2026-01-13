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
	.globl _switch_map
	.globl _load_map
	.globl _update_player_sprite
	.globl _update_camera
	.globl _get_tile_at
	.globl _memcpy
	.globl _text_dialogue
	.globl _text_init
	.globl _music_update
	.globl _music_init
	.globl _inventory_has_item
	.globl _inventory_add_item
	.globl _input_held
	.globl _input_pressed
	.globl _fade_in
	.globl _fade_out
	.globl _fill_bkg_rect
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _display_off
	.globl _delay
	.globl _env_anim_frame
	.globl _env_anim_timer
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
	.ds 10
_house_ents::
	.ds 10
_level2_ents::
	.ds 10
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
_env_anim_timer::
	.ds 1
_env_anim_frame::
	.ds 1
_game_ready:
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
;src/states/game.c:59: uint8_t get_tile_at(uint16_t x, uint16_t y) {
;	---------------------------------
; Function get_tile_at
; ---------------------------------
_get_tile_at::
	add	sp, #-6
;src/states/game.c:60: uint16_t tx = x / 8, ty = y / 8;
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
;src/states/game.c:61: if (tx >= current_map->w || ty >= current_map->h)
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
;src/states/game.c:62: return 0;
	xor	a, a
	jr	00104$
00102$:
;src/states/game.c:63: return current_map->tiles[ty * current_map->w + tx];
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
;src/states/game.c:64: }
	add	sp, #6
	ret
;src/states/game.c:66: void update_camera() {
;	---------------------------------
; Function update_camera
; ---------------------------------
_update_camera::
	add	sp, #-4
;src/states/game.c:67: uint16_t w = current_map->w * 8, h = current_map->h * 8;
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
;src/states/game.c:68: if (player_x > SCREEN_WIDTH / 2)
	ld	hl, #_player_x
	ld	a, #0x50
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00102$
;src/states/game.c:69: camera_x = player_x - SCREEN_WIDTH / 2;
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
;src/states/game.c:71: camera_x = 0;
	xor	a, a
	ld	hl, #_camera_x
	ld	(hl+), a
	ld	(hl), a
00103$:
;src/states/game.c:72: if (player_y > SCREEN_HEIGHT / 2)
	ld	hl, #_player_y
	ld	a, #0x48
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00105$
;src/states/game.c:73: camera_y = player_y - SCREEN_HEIGHT / 2;
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
;src/states/game.c:75: camera_y = 0;
	xor	a, a
	ld	hl, #_camera_y
	ld	(hl+), a
	ld	(hl), a
00106$:
;src/states/game.c:76: if (camera_x > w - SCREEN_WIDTH)
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
;src/states/game.c:77: camera_x = (w > SCREEN_WIDTH) ? (w - SCREEN_WIDTH) : 0;
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
;src/states/game.c:78: if (camera_y > h - SCREEN_HEIGHT)
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
;src/states/game.c:79: camera_y = (h > SCREEN_HEIGHT) ? (h - SCREEN_HEIGHT) : 0;
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
;src/states/game.c:80: move_bkg(camera_x, camera_y);
	ld	a, (_camera_y)
	ld	c, a
	ld	a, (#_camera_x)
	ldh	(_SCX_REG + 0), a
;./gbdk/include/gb/gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/states/game.c:80: move_bkg(camera_x, camera_y);
;src/states/game.c:81: }
	add	sp, #4
	ret
;src/states/game.c:83: void update_player_sprite() {
;	---------------------------------
; Function update_player_sprite
; ---------------------------------
_update_player_sprite::
	dec	sp
;src/states/game.c:84: uint8_t base =
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
;src/states/game.c:88: uint8_t prop = (player_dir == 3) ? S_FLIPX : 0;
	ld	a, b
	or	a, a
	ld	e, #0x20
	jr	NZ, 00131$
	ld	e, #0x00
00131$:
;src/states/game.c:89: if (prop == 0) {
	ld	a, e
	or	a, a
	jr	NZ, 00104$
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), c
;src/states/game.c:91: set_sprite_tile(1, base + 1);
	ld	a, c
	inc	a
	ldhl	sp,	#0
	ld	(hl), a
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	de, #(_shadow_OAM + 6)
	ld	a, (hl)
	ld	(de), a
;src/states/game.c:92: set_sprite_tile(2, base + 2);
	ld	b, c
	inc	b
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), b
;src/states/game.c:93: set_sprite_tile(3, base + 3);
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), c
;src/states/game.c:94: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00117$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00122$
;src/states/game.c:95: set_sprite_prop(i, 0);
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
;src/states/game.c:94: for (int i = 0; i < 4; i++)
	inc	c
	jr	00117$
00104$:
;src/states/game.c:97: set_sprite_tile(0, base + 1);
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
;src/states/game.c:99: set_sprite_tile(2, base + 3);
	ld	c, b
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), c
;src/states/game.c:100: set_sprite_tile(3, base + 2);
	inc	b
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), b
;src/states/game.c:101: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00120$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00122$
;src/states/game.c:102: set_sprite_prop(i, S_FLIPX);
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
;src/states/game.c:101: for (int i = 0; i < 4; i++)
	inc	c
	jr	00120$
00122$:
;src/states/game.c:104: }
	inc	sp
	ret
;src/states/game.c:106: void load_map(map_info_t *m) {
;	---------------------------------
; Function load_map
; ---------------------------------
_load_map::
	add	sp, #-3
	ld	c, e
	ld	b, d
;src/states/game.c:107: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:108: current_map = m;
	ld	hl, #_current_map
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:109: for (int i = 4; i < 40; i++)
	ld	e, #0x04
00108$:
	ld	a, e
	sub	a, #0x28
	jr	NC, 00101$
;src/states/game.c:110: move_sprite(i, 0, 0); // Hide map sprites
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
;src/states/game.c:109: for (int i = 4; i < 40; i++)
	inc	e
	jr	00108$
00101$:
;src/states/game.c:112: if (m == &house_map_info)
	ld	a, #<(_house_map_info)
	sub	a, c
	jr	NZ, 00103$
	ld	a, #>(_house_map_info)
	sub	a, b
	jr	NZ, 00103$
;src/states/game.c:113: fill_bkg_rect(0, 0, 32, 32, 26);
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
;src/states/game.c:114: set_bkg_tiles(0, 0, m->w, m->h, m->tiles);
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
;src/states/game.c:115: update_camera();
	call	_update_camera
;src/states/game.c:118: uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
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
;src/states/game.c:119: for (int i = 0; i < 4; i++)
	ld	e, #0x00
00111$:
	ld	a, e
	sub	a, #0x04
	jr	NC, 00104$
;src/states/game.c:120: move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));
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
;src/states/game.c:119: for (int i = 0; i < 4; i++)
	inc	e
	jr	00111$
00104$:
;src/states/game.c:122: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:123: }
	add	sp, #3
	ret
;src/states/game.c:125: void switch_map(map_info_t *new_map, uint16_t new_x, uint16_t new_y) {
;	---------------------------------
; Function switch_map
; ---------------------------------
_switch_map::
;src/states/game.c:126: fade_out();
	push	bc
	push	de
	call	_fade_out
	pop	de
	pop	bc
;src/states/game.c:127: player_x = new_x;
	ld	hl, #_player_x
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:128: player_y = new_y;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(#_player_y),a
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_player_y + 1),a
;src/states/game.c:129: load_map(new_map);
	call	_load_map
;src/states/game.c:130: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:131: fade_in();
	call	_fade_in
;src/states/game.c:132: }
	pop	hl
	pop	af
	jp	(hl)
;src/states/game.c:134: uint8_t is_solid(uint16_t x, uint16_t y) {
;	---------------------------------
; Function is_solid
; ---------------------------------
_is_solid::
;src/states/game.c:135: uint8_t tid = get_tile_at(x, y);
	call	_get_tile_at
	ld	c, a
;src/states/game.c:136: for (int i = 0; i < 16; i++) {
	ld	b, #0x00
00107$:
	ld	a, b
	sub	a, #0x10
	jr	NC, 00105$
;src/states/game.c:137: if (current_map->solid_tiles[i] == 255)
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
;src/states/game.c:139: if (tid == current_map->solid_tiles[i])
	sub	a, c
	jr	NZ, 00108$
;src/states/game.c:140: return 0;
	xor	a, a
	ret
00108$:
;src/states/game.c:136: for (int i = 0; i < 16; i++) {
	inc	b
	jr	00107$
00105$:
;src/states/game.c:142: return 1;
	ld	a, #0x01
;src/states/game.c:143: }
	ret
;src/states/game.c:145: uint8_t can_move(uint16_t nx, uint16_t ny) {
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
;src/states/game.c:146: if (nx < 4 || ny < 4 || nx > (current_map->w * 8 - 12) ||
	ld	a, b
	ld	(hl+), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x04
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00101$
	ldhl	sp,	#4
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x04
	ld	a, (hl)
	sbc	a, #0x00
	jr	C, 00101$
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
	ld	de, #0xfff4
	add	hl, de
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	a, e
	sub	a, (hl)
	inc	hl
	ld	a, d
	sbc	a, (hl)
	jr	C, 00101$
;src/states/game.c:147: ny > (current_map->h * 8 - 12))
	inc	bc
	inc	bc
	inc	bc
	ld	a, (bc)
	ld	l, a
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	bc, #0xfff4
	add	hl,bc
	ld	c, l
	ld	b, h
	ldhl	sp,	#10
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	jr	NC, 00102$
00101$:
;src/states/game.c:148: return 0;
	xor	a, a
	jp	00124$
00102$:
;src/states/game.c:150: if (is_solid(nx + 4, ny + 8) || is_solid(nx + 12, ny + 8) ||
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	e, l
	ld	a, h
	ldhl	sp,	#12
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
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	ld	e, l
	ld	d, h
	push	de
	call	_is_solid
	pop	de
	or	a, a
	jr	NZ, 00106$
;src/states/game.c:151: is_solid(nx + 4, ny + 15) || is_solid(nx + 12, ny + 15)) {
	push	de
	ldhl	sp,#12
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
	ldhl	sp,	#16
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
	jr	Z, 00138$
00106$:
;src/states/game.c:152: return 0;
	xor	a, a
	jp	00124$
;src/states/game.c:155: for (int i = 0; i < current_map->num_entities; i++) {
00138$:
	xor	a, a
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), a
00123$:
;src/states/game.c:146: if (nx < 4 || ny < 4 || nx > (current_map->w * 8 - 12) ||
	ld	a, (_current_map)
	ld	c, a
	ld	hl, #_current_map + 1
	ld	b, (hl)
;src/states/game.c:155: for (int i = 0; i < current_map->num_entities; i++) {
	ld	hl, #0x0006
	add	hl, bc
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#8
	ld	e, l
	ld	d, h
	ldhl	sp,	#12
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
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
	jp	NC, 00121$
;src/states/game.c:156: entity_t *e = &current_map->entities[i];
	ld	hl, #0x0004
	add	hl, bc
	ld	e, l
	ld	d, h
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
	add	hl, bc
	add	hl, hl
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
;src/states/game.c:157: if (!e->active)
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
;src/states/game.c:159: int16_t dx = (int16_t)nx - e->x, dy = (int16_t)ny - e->y;
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
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,	#5
	ld	a, (hl)
	ldhl	sp,	#13
	ld	(hl), a
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl-), a
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
;src/states/game.c:160: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00114$
;src/states/game.c:161: dx = -dx;
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
;src/states/game.c:162: if (dy < 0)
	ldhl	sp,	#12
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00116$
;src/states/game.c:163: dy = -dy;
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
;src/states/game.c:164: if (dx < 12 && dy < 12)
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
;src/states/game.c:165: return 0; // Collide if too close
	xor	a, a
	jr	00124$
00120$:
;src/states/game.c:155: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#8
	inc	(hl)
	jp	NZ, 00123$
	inc	hl
	inc	(hl)
	jp	00123$
00121$:
;src/states/game.c:167: return 1;
	ld	a, #0x01
00124$:
;src/states/game.c:168: }
	add	sp, #14
	ret
;src/states/game.c:174: void game_init(void) {
;	---------------------------------
; Function game_init
; ---------------------------------
_game_init::
	add	sp, #-20
;src/states/game.c:175: DISPLAY_OFF;
	call	_display_off
;src/states/game.c:176: set_bkg_data(0, 77, tiles_data); // All tiles (now 77)
	ld	de, #_tiles_data
	push	de
	ld	hl, #0x4d00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:178: if (game_ready) {
	ld	a, (#_game_ready)
	or	a, a
	jr	Z, 00102$
;src/states/game.c:180: load_map(current_map);
	ld	a, (_current_map)
	ld	e, a
	ld	hl, #_current_map + 1
	ld	d, (hl)
	call	_load_map
;src/states/game.c:181: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:182: BGP_REG = OBP0_REG = OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/states/game.c:183: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:184: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:185: return;
	jp	00103$
00102$:
;src/states/game.c:189: world_map_info.tiles = map_data;
	ld	hl, #_world_map_info
	ld	a, #<(_map_data)
	ld	(hl+), a
;src/states/game.c:190: world_map_info.w = MAP_WIDTH;
	ld	a, #>(_map_data)
	ld	(hl+), a
	ld	(hl), #0x20
;src/states/game.c:191: world_map_info.h = MAP_HEIGHT;
	ld	hl, #_world_map_info + 3
	ld	(hl), #0x20
;src/states/game.c:192: world_map_info.entities = world_ents;
	ld	hl, #(_world_map_info + 4)
	ld	a, #<(_world_ents)
	ld	(hl+), a
;src/states/game.c:193: world_map_info.num_entities = 1;
	ld	a, #>(_world_ents)
	ld	(hl+), a
	ld	(hl), #0x01
;src/states/game.c:194: uint8_t w_pass[] = {0, 2, 3, 4, 5, 21, 22, 58, 59, 70, 71, 255};
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
	ld	a, #0x46
	ld	(hl+), a
	ld	a, #0x47
	ld	(hl+), a
	ld	(hl), #0xff
;src/states/game.c:195: memcpy(world_map_info.solid_tiles, w_pass, 12);
	ld	de, #0x000c
	push	de
	ld	de, #(_world_map_info + 7)
	call	_memcpy
;src/states/game.c:196: world_ents[0].x = 210;
	ld	hl, #_world_ents
	ld	a, #0xd2
	ld	(hl+), a
;src/states/game.c:197: world_ents[0].y = 230;
	xor	a, a
	ld	(hl+), a
	ld	a, #0xe6
	ld	(hl+), a
;src/states/game.c:198: world_ents[0].type = ENT_NPC;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/states/game.c:199: world_ents[0].dialogue =
	ld	hl, #(_world_ents + 5)
	ld	a, #<(___str_0)
	ld	(hl+), a
;src/states/game.c:201: world_ents[0].sprite_base = 24;
	ld	a, #>(___str_0)
	ld	(hl+), a
	ld	(hl), #0x18
;src/states/game.c:202: world_ents[0].active = 1;
	ld	hl, #_world_ents + 8
	ld	(hl), #0x01
;src/states/game.c:204: house_map_info.tiles = house_map;
	ld	hl, #_house_map_info
	ld	a, #<(_house_map)
	ld	(hl+), a
;src/states/game.c:205: house_map_info.w = HOUSE_WIDTH;
	ld	a, #>(_house_map)
	ld	(hl+), a
	ld	(hl), #0x14
;src/states/game.c:206: house_map_info.h = HOUSE_HEIGHT;
	ld	hl, #_house_map_info + 3
	ld	(hl), #0x12
;src/states/game.c:207: house_map_info.entities = house_ents;
	ld	hl, #(_house_map_info + 4)
	ld	a, #<(_house_ents)
	ld	(hl+), a
;src/states/game.c:208: house_map_info.num_entities = 1;
	ld	a, #>(_house_ents)
	ld	(hl+), a
	ld	(hl), #0x01
;src/states/game.c:209: uint8_t h_pass[] = {25, 35, 255};
	ldhl	sp,	#12
	ld	c, l
	ld	b, h
	ld	(hl), #0x19
	ldhl	sp,	#13
	ld	a, #0x23
	ld	(hl+), a
	ld	(hl), #0xff
;src/states/game.c:210: memcpy(house_map_info.solid_tiles, h_pass, 3);
	ld	de, #0x0003
	push	de
	ld	de, #(_house_map_info + 7)
	call	_memcpy
;src/states/game.c:211: house_ents[0].x = 40;
	ld	hl, #_house_ents
	ld	a, #0x28
	ld	(hl+), a
;src/states/game.c:212: house_ents[0].y = 48;
	xor	a, a
	ld	(hl+), a
	ld	a, #0x30
	ld	(hl+), a
;src/states/game.c:213: house_ents[0].type = ENT_NPC;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/states/game.c:214: house_ents[0].dialogue = "PUEDES DESCANSAR,\nPERO NO TOQUES\nMIS COSAS!";
	ld	hl, #(_house_ents + 5)
	ld	a, #<(___str_1)
	ld	(hl+), a
;src/states/game.c:215: house_ents[0].sprite_base = 24;
	ld	a, #>(___str_1)
	ld	(hl+), a
	ld	(hl), #0x18
;src/states/game.c:216: house_ents[0].active = 1;
	ld	hl, #_house_ents + 8
	ld	(hl), #0x01
;src/states/game.c:218: level2_map_info.tiles = level2_map;
	ld	hl, #_level2_map_info
	ld	a, #<(_level2_map)
	ld	(hl+), a
;src/states/game.c:219: level2_map_info.w = L2_WIDTH;
	ld	a, #>(_level2_map)
	ld	(hl+), a
	ld	(hl), #0x20
;src/states/game.c:220: level2_map_info.h = L2_HEIGHT;
	ld	hl, #_level2_map_info + 3
	ld	(hl), #0x20
;src/states/game.c:221: level2_map_info.entities = level2_ents;
	ld	hl, #(_level2_map_info + 4)
	ld	a, #<(_level2_ents)
	ld	(hl+), a
;src/states/game.c:222: level2_map_info.num_entities = 1;
	ld	a, #>(_level2_ents)
	ld	(hl+), a
	ld	(hl), #0x01
;src/states/game.c:223: uint8_t l2_pass[] = {0, 2, 3, 4, 255};
	ldhl	sp,	#15
	ld	c, l
	ld	b, h
	xor	a, a
	ld	(bc), a
	ldhl	sp,	#16
	ld	a, #0x02
	ld	(hl+), a
	ld	a, #0x03
	ld	(hl+), a
	ld	a, #0x04
	ld	(hl+), a
	ld	(hl), #0xff
;src/states/game.c:224: memcpy(level2_map_info.solid_tiles, l2_pass, 5);
	ld	de, #0x0005
	push	de
	ld	de, #(_level2_map_info + 7)
	call	_memcpy
;src/states/game.c:226: level2_ents[0].x = 120;
	ld	hl, #_level2_ents
	ld	a, #0x78
	ld	(hl+), a
;src/states/game.c:227: level2_ents[0].y = 120;
	xor	a, a
	ld	(hl+), a
	ld	a, #0x78
	ld	(hl+), a
;src/states/game.c:228: level2_ents[0].type = ENT_ENEMY;
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x03
;src/states/game.c:229: level2_ents[0].sprite_base = 28; // Guard Sprite
	ld	hl, #_level2_ents + 7
	ld	(hl), #0x1c
;src/states/game.c:230: level2_ents[0].active = 1;
	ld	hl, #_level2_ents + 8
	ld	(hl), #0x01
;src/states/game.c:231: level2_ents[0].dir = 1;
	ld	hl, #_level2_ents + 9
	ld	(hl), #0x01
;src/states/game.c:233: load_map(&world_map_info);
	ld	de, #_world_map_info
	call	_load_map
;src/states/game.c:235: BGP_REG = OBP0_REG = OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/states/game.c:236: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:237: set_sprite_data(0, 24, player_sprites);
	ld	de, #_player_sprites
	push	de
	ld	hl, #0x1800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:238: set_sprite_data(24, 4, npc_child_sprite);
	ld	de, #_npc_child_sprite
	push	de
	ld	hl, #0x418
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:239: set_sprite_data(28, 4, guard_sprite_data);
	ld	de, #_guard_sprite_data
	push	de
	ld	hl, #0x41c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:240: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:241: text_init();
	call	_text_init
;src/states/game.c:242: music_init();
	call	_music_init
;src/states/game.c:243: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:244: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:245: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:246: game_ready = 1;
	ld	hl, #_game_ready
	ld	(hl), #0x01
00103$:
;src/states/game.c:247: }
	add	sp, #20
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
;src/states/game.c:249: void game_update(void) {
;	---------------------------------
; Function game_update
; ---------------------------------
_game_update::
	add	sp, #-13
;src/states/game.c:250: music_update();
	call	_music_update
;src/states/game.c:251: uint8_t moved = 0;
	ld	c, #0x00
;src/states/game.c:252: uint16_t nx = player_x, ny = player_y;
	ld	a, (#_player_x)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (#_player_y)
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#12
	ld	(hl), a
;src/states/game.c:254: if (input_held(J_UP)) {
	push	bc
	ld	a, #0x04
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00110$
;src/states/game.c:255: ny--;
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:256: player_dir = 1;
	ld	hl, #_player_dir
	ld	(hl), #0x01
;src/states/game.c:257: moved = 1;
	ld	c, #0x01
	jr	00111$
00110$:
;src/states/game.c:258: } else if (input_held(J_DOWN)) {
	push	bc
	ld	a, #0x08
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00107$
;src/states/game.c:259: ny++;
	ldhl	sp,	#11
	inc	(hl)
	jr	NZ, 00692$
	inc	hl
	inc	(hl)
00692$:
;src/states/game.c:260: player_dir = 0;
	xor	a, a
	ld	(#_player_dir),a
;src/states/game.c:261: moved = 1;
	ld	c, #0x01
	jr	00111$
00107$:
;src/states/game.c:262: } else if (input_held(J_LEFT)) {
	push	bc
	ld	a, #0x02
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00104$
;src/states/game.c:263: nx--;
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:264: player_dir = 2;
	ld	hl, #_player_dir
	ld	(hl), #0x02
;src/states/game.c:265: moved = 1;
	ld	c, #0x01
	jr	00111$
00104$:
;src/states/game.c:266: } else if (input_held(J_RIGHT)) {
	push	bc
	ld	a, #0x01
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00111$
;src/states/game.c:267: nx++;
	ldhl	sp,	#9
	inc	(hl)
	jr	NZ, 00693$
	inc	hl
	inc	(hl)
00693$:
;src/states/game.c:268: player_dir = 3;
	ld	hl, #_player_dir
	ld	(hl), #0x03
;src/states/game.c:269: moved = 1;
	ld	c, #0x01
00111$:
;src/states/game.c:272: if (moved) {
	ld	a, c
	or	a, a
	jp	Z, 00140$
;src/states/game.c:273: if (can_move(nx, ny)) {
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_can_move
	or	a, a
	jp	Z, 00277$
;src/states/game.c:274: player_x = nx;
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(#_player_x),a
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(#_player_x + 1),a
;src/states/game.c:275: player_y = ny;
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(#_player_y),a
	ldhl	sp,	#12
	ld	a, (hl)
	ld	(#_player_y + 1),a
;src/states/game.c:276: update_camera();
	call	_update_camera
;src/states/game.c:277: uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
	ld	a, (_player_x)
	ld	hl, #_camera_x
	ld	c, (hl)
	sub	a, c
	add	a, #0x08
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (_player_y)
	ld	hl, #_camera_y
	ld	c, (hl)
	sub	a, c
	add	a, #0x10
	ldhl	sp,	#8
	ld	(hl), a
;src/states/game.c:278: for (int i = 0; i < 4; i++)
	ldhl	sp,	#12
	ld	(hl), #0x00
00208$:
	ldhl	sp,	#12
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00112$
;src/states/game.c:279: move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));
	ldhl	sp,	#8
	ld	c, (hl)
	ldhl	sp,	#12
	ld	a, (hl)
	sub	a, #0x02
	jr	C, 00223$
	ld	a, #0x08
	jr	00224$
00223$:
	xor	a, a
00224$:
	add	a, c
	ldhl	sp,	#9
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl)
	and	a, #0x01
	ld	a, #0x08
	jr	NZ, 00226$
	xor	a, a
00226$:
	ldhl	sp,	#10
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
	ldhl	sp,	#11
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	ld	(hl), c
;src/states/game.c:278: for (int i = 0; i < 4; i++)
	ldhl	sp,	#12
	inc	(hl)
	jr	00208$
00112$:
;src/states/game.c:281: if (++anim_timer > 6) {
	ld	hl, #_anim_timer
	inc	(hl)
	ld	a, #0x06
	sub	a, (hl)
	jp	NC, 00277$
;src/states/game.c:282: anim_frame = !anim_frame;
	ld	hl, #_anim_frame
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/states/game.c:283: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
;src/states/game.c:284: update_player_sprite();
	call	_update_player_sprite
	jp	00277$
00140$:
;src/states/game.c:288: if (anim_frame != 0) {
	ld	hl, #_anim_frame
	ld	a, (hl)
	or	a, a
	jr	Z, 00118$
;src/states/game.c:289: anim_frame = 0;
	ld	(hl), #0x00
;src/states/game.c:290: update_player_sprite();
	call	_update_player_sprite
00118$:
;src/states/game.c:292: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
;src/states/game.c:295: if (input_pressed(J_SELECT)) {
	ld	a, #0x40
	call	_input_pressed
	or	a, a
	jr	Z, 00120$
;src/states/game.c:296: game_state = 3; // STATE_INVENTORY
	ld	hl, #_game_state
	ld	(hl), #0x03
;src/states/game.c:297: return;
	jp	00221$
00120$:
;src/states/game.c:301: uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
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
	jr	NC, 00694$
	inc	d
00694$:
	call	_get_tile_at
	ld	e, a
;src/states/game.c:302: if (current_map == &world_map_info &&
;src/states/game.c:301: uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
	ld	a, (#_player_x)
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#12
	ld	(hl), a
;src/states/game.c:302: if (current_map == &world_map_info &&
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_world_map_info)
	jr	NZ, 00125$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_world_map_info)
	jr	NZ, 00125$
;src/states/game.c:303: (tid == 21 || tid == 22 || tid == 58 || tid == 59 || tid == 70 ||
	ld	a,e
	cp	a,#0x15
	jr	Z, 00124$
	cp	a,#0x16
	jr	Z, 00124$
	cp	a,#0x3a
	jr	Z, 00124$
;src/states/game.c:304: tid == 71)) {
	cp	a,#0x3b
	jr	Z, 00124$
	cp	a,#0x46
	jr	Z, 00124$
	sub	a, #0x47
	jr	NZ, 00125$
00124$:
;src/states/game.c:305: if (player_x > 160 && player_y > 160) {
	ldhl	sp,	#11
	ld	a, #0xa0
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00125$
	ld	a, #0xa0
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	NC, 00125$
;src/states/game.c:306: saved_world_x = player_x;
	ld	a, (#_player_x)
	ld	(#_saved_world_x),a
	ld	a, (#_player_x + 1)
	ld	(#_saved_world_x + 1),a
;src/states/game.c:307: saved_world_y = player_y + 16;
	ld	hl, #0x0010
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	hl, #_saved_world_y
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:308: switch_map(&house_map_info, 76, 112);
	ld	de, #0x0070
	push	de
	ld	bc, #0x004c
	ld	de, #_house_map_info
	call	_switch_map
;src/states/game.c:309: return;
	jp	00221$
00125$:
;src/states/game.c:312: tid = get_tile_at(player_x + 8, player_y + 12);
	ld	hl, #0x000c
	add	hl, bc
	ld	c, l
	ld	b, h
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	e, l
	ld	d, h
	call	_get_tile_at
	ld	c, a
;src/states/game.c:313: if (current_map == &house_map_info && tid == 35) {
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_house_map_info)
	jr	NZ, 00133$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_house_map_info)
	jr	NZ, 00133$
	ld	a, c
	sub	a, #0x23
	jr	NZ, 00133$
;src/states/game.c:314: uint16_t wx = saved_world_x;
	ld	a, (_saved_world_x)
	ld	hl, #_saved_world_x + 1
	ld	b, (hl)
;src/states/game.c:315: uint16_t wy = saved_world_y;
	ld	hl, #_saved_world_y
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
;src/states/game.c:316: switch_map(&world_map_info, wx, wy);
	push	de
	ld	c, a
	ld	de, #_world_map_info
	call	_switch_map
;src/states/game.c:317: return;
	jp	00221$
00133$:
;src/states/game.c:319: if (current_map == &level2_map_info && tid == 0 && player_y > 240) {
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_level2_map_info)
	jr	NZ, 00277$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_level2_map_info)
	jr	NZ, 00277$
	or	a, c
	jr	NZ, 00277$
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
	ld	a, #0xf0
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	NC, 00277$
;src/states/game.c:320: switch_map(&world_map_info, 124, 48);
	ld	de, #0x0030
	push	de
	ld	bc, #0x007c
	ld	de, #_world_map_info
	call	_switch_map
;src/states/game.c:321: return;
	jp	00221$
;src/states/game.c:326: for (int i = 0; i < current_map->num_entities; i++) {
00277$:
	xor	a, a
	ldhl	sp,	#10
	ld	(hl+), a
	ld	(hl), a
00217$:
	ld	a, (_current_map)
	ld	c, a
	ld	hl, #_current_map + 1
	ld	b, (hl)
	ld	hl, #0x0006
	add	hl, bc
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), #0x00
	ldhl	sp,	#10
	ld	e, l
	ld	d, h
	ldhl	sp,	#8
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00710$
	bit	7, d
	jr	NZ, 00711$
	cp	a, a
	jr	00711$
00710$:
	bit	7, d
	jr	Z, 00711$
	scf
00711$:
	jp	NC, 00169$
;src/states/game.c:327: entity_t *e = &current_map->entities[i];
	ld	hl, #0x0004
	add	hl, bc
	ld	e, l
	ld	d, h
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
	add	hl, bc
	add	hl, hl
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
;src/states/game.c:328: if (!e->active)
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
	jp	Z, 00168$
;src/states/game.c:331: if (e->type == ENT_ENEMY) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
	ld	c, a
;src/states/game.c:334: if (e->x < 180)
	ldhl	sp,	#8
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl-)
	dec	hl
;src/states/game.c:346: int16_t dx = (int16_t)player_x - e->x, dy = (int16_t)player_y - e->y;
	ld	(hl+), a
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
;src/states/game.c:334: if (e->x < 180)
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
;src/states/game.c:331: if (e->type == ENT_ENEMY) {
	ld	a, c
	sub	a, #0x03
	jp	NZ, 00161$
;src/states/game.c:333: if (e->dir == 1) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0009
	add	hl, de
	ld	c, l
	ld	b, h
	ld	a, (bc)
;src/states/game.c:334: if (e->x < 180)
	ldhl	sp,	#2
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
;src/states/game.c:333: if (e->dir == 1) {
	dec	a
	jr	NZ, 00151$
;src/states/game.c:334: if (e->x < 180)
	ld	a, e
	sub	a, #0xb4
	ld	a, d
	sbc	a, #0x00
	jr	NC, 00145$
;src/states/game.c:335: e->x++;
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00152$
00145$:
;src/states/game.c:337: e->dir = -1;
	ld	a, #0xff
	ld	(bc), a
	jr	00152$
00151$:
;src/states/game.c:339: if (e->x > 80)
	ld	a, #0x50
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	NC, 00148$
;src/states/game.c:340: e->x--;
	ldhl	sp,#2
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	dec	bc
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
	jr	00152$
00148$:
;src/states/game.c:342: e->dir = 1;
	ld	a, #0x01
	ld	(bc), a
00152$:
;src/states/game.c:346: int16_t dx = (int16_t)player_x - e->x, dy = (int16_t)player_y - e->y;
	ld	a, (_player_x)
	ld	c, a
	ld	hl, #_player_x + 1
	ld	b, (hl)
;src/states/game.c:334: if (e->x < 180)
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#2
	ld	(hl+), a
	inc	de
	ld	a, (de)
;src/states/game.c:346: int16_t dx = (int16_t)player_x - e->x, dy = (int16_t)player_y - e->y;
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	e, a
	ld	a, b
	sbc	a, d
	ldhl	sp,	#7
	ld	(hl-), a
	ld	(hl), e
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	a, c
	sub	a, l
	ld	c, a
	ld	a, b
	sbc	a, h
	ld	b, a
;src/states/game.c:347: if (dx < 0)
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00154$
;src/states/game.c:348: dx = -dx;
	ld	de, #0x0000
	ldhl	sp,	#6
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
00154$:
;src/states/game.c:349: if (dy < 0)
	ld	h, b
	bit	7, h
	jr	Z, 00156$
;src/states/game.c:350: dy = -dy;
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
00156$:
;src/states/game.c:351: if (dx < 12 && dy < 12) {
	ldhl	sp,	#6
	ld	a, (hl+)
	sub	a, #0x0c
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00716$
	bit	7, d
	jr	NZ, 00717$
	cp	a, a
	jr	00717$
00716$:
	bit	7, d
	jr	Z, 00717$
	scf
00717$:
	jr	NC, 00161$
	ld	a, c
	sub	a, #0x0c
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00161$
;src/states/game.c:353: fade_out();
	call	_fade_out
;src/states/game.c:354: delay(500);
	ld	de, #0x01f4
	call	_delay
;src/states/game.c:355: player_x = 128;
	ld	hl, #_player_x
	ld	a, #0x80
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:356: player_y = 224;
	ld	hl, #_player_y
	ld	a, #0xe0
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:357: load_map(&level2_map_info);
	ld	de, #_level2_map_info
	call	_load_map
;src/states/game.c:358: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:359: fade_in();
	call	_fade_in
;src/states/game.c:360: return;
	jp	00221$
00161$:
;src/states/game.c:364: uint16_t esx = e->x - camera_x + 8, esy = e->y - camera_y + 16;
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
	ld	a, h
	ldhl	sp,	#1
	ld	(hl), c
	inc	hl
	ld	(hl), a
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
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
	ldhl	sp,	#3
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/states/game.c:365: if (esx < 168 && esy < 160) {
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0xa8
	ld	a, b
	sbc	a, #0x00
	jp	NC, 00276$
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0xa0
	ld	a, (hl)
	sbc	a, #0x00
	jp	NC, 00276$
;src/states/game.c:366: for (int j = 0; j < 4; j++) {
	inc	hl
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
	ldhl	sp,	#12
	ld	(hl), #0x00
00211$:
	ldhl	sp,	#12
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00168$
;src/states/game.c:367: move_sprite(4 + j, esx + (j % 2 ? 8 : 0), esy + (j >= 2 ? 8 : 0));
	ldhl	sp,	#3
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	sub	a, #0x02
	jr	C, 00227$
	ldhl	sp,	#8
	ld	(hl), #0x08
	jr	00228$
00227$:
	ldhl	sp,	#8
	ld	(hl), #0x00
00228$:
	ldhl	sp,	#9
	ld	a, (hl-)
	add	a, (hl)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (hl)
	and	a, #0x01
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	ld	c, #0x08
	jr	NZ, 00230$
	ld	c, #0x00
00230$:
	ldhl	sp,	#8
	ld	a, (hl)
	add	a, c
	ld	(hl), a
	ldhl	sp,	#12
	ld	c, (hl)
	ld	a, c
	add	a, #0x04
	ldhl	sp,	#9
	ld	(hl), a
	ld	e, (hl)
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	xor	a, a
	ld	l, e
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	e, l
	ld	d, h
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	(de), a
	inc	de
;src/states/game.c:368: set_sprite_tile(4 + j, e->sprite_base + j);
	ld	a, (hl-)
	dec	hl
	dec	hl
	ld	(de), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	add	a, c
	ld	c, a
	ldhl	sp,	#9
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	l, (hl)
	ld	de, #_shadow_OAM+0
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;src/states/game.c:366: for (int j = 0; j < 4; j++) {
	ldhl	sp,	#12
	inc	(hl)
	jr	00211$
;src/states/game.c:371: for (int j = 0; j < 4; j++)
00276$:
	ld	c, #0x00
00214$:
;src/states/game.c:372: move_sprite(4 + j, 0, 0);
	ld	a,c
	cp	a,#0x04
	jr	NC, 00168$
	add	a, #0x04
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
;src/states/game.c:371: for (int j = 0; j < 4; j++)
	inc	c
	jr	00214$
00168$:
;src/states/game.c:326: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#10
	inc	(hl)
	jp	NZ, 00217$
	inc	hl
	inc	(hl)
	jp	00217$
00169$:
;src/states/game.c:376: if (input_pressed(J_A | J_B)) {
	ld	a, #0x30
	call	_input_pressed
	or	a, a
	jp	Z, 00200$
;src/states/game.c:377: for (int i = 0; i < current_map->num_entities; i++) {
	xor	a, a
	ldhl	sp,	#7
	ld	(hl+), a
	ld	(hl), a
00219$:
;src/states/game.c:326: for (int i = 0; i < current_map->num_entities; i++) {
	ld	a, (#_current_map)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (#_current_map + 1)
	ldhl	sp,	#10
;src/states/game.c:377: for (int i = 0; i < current_map->num_entities; i++) {
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
	ldhl	sp,	#7
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00719$
	bit	7, d
	jr	NZ, 00720$
	cp	a, a
	jr	00720$
00719$:
	bit	7, d
	jr	Z, 00720$
	scf
00720$:
	jp	NC, 00178$
;src/states/game.c:378: entity_t *e = &current_map->entities[i];
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
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
	ldhl	sp,#7
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	c, l
	ld	b, h
	ldhl	sp,	#11
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#4
	ld	(hl), a
;src/states/game.c:379: int16_t dx = (int16_t)player_x - e->x, dy = (int16_t)player_y - e->y;
	ld	a, (_player_x)
	ld	c, a
	ld	hl, #_player_x + 1
	ld	b, (hl)
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, c
	ld	(hl+), a
	ld	a, b
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#10
	ld	(hl-), a
	ld	(hl), e
	ld	a, (#_player_y)
	ldhl	sp,	#1
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#2
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#5
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	c, (hl)
	ld	e, a
	ld	d, c
	ldhl	sp,	#5
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#12
	ld	(hl-), a
;src/states/game.c:380: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00171$
;src/states/game.c:381: dx = -dx;
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#10
	ld	(hl-), a
	ld	(hl), e
00171$:
;src/states/game.c:382: if (dy < 0)
	ldhl	sp,	#11
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00173$
;src/states/game.c:383: dy = -dy;
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#12
	ld	(hl-), a
	ld	(hl), e
00173$:
;src/states/game.c:384: if (dx < 24 && dy < 24 && input_pressed(J_A))
	ldhl	sp,	#9
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
	jr	NC, 00220$
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
	jr	NC, 00220$
	ld	a, #0x10
	call	_input_pressed
	or	a, a
	jr	Z, 00220$
;src/states/game.c:385: text_dialogue(e->dialogue);
	ldhl	sp,#3
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
00220$:
;src/states/game.c:377: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#7
	inc	(hl)
	jp	NZ, 00219$
	inc	hl
	inc	(hl)
	jp	00219$
00178$:
;src/states/game.c:388: uint8_t tid = get_tile_at(player_x + 8, player_y);
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	d, (hl)
	add	a, #0x08
	ld	e, a
	jr	NC, 00722$
	inc	d
00722$:
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
	call	_get_tile_at
	ldhl	sp,	#11
	ld	(hl), a
;src/states/game.c:389: if (player_dir == 1)
	ld	a, (#_player_dir)
	dec	a
	jr	NZ, 00180$
;src/states/game.c:390: tid = get_tile_at(player_x + 8, player_y - 4);
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
	jr	NC, 00725$
	inc	d
00725$:
	call	_get_tile_at
	ldhl	sp,	#11
	ld	(hl), a
00180$:
;src/states/game.c:392: if (current_map == &house_map_info &&
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_house_map_info)
	jr	NZ, 00187$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_house_map_info)
	jr	NZ, 00187$
;src/states/game.c:393: (tid == 31 || tid == 32 || tid == 33 || tid == 34)) {
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x1f
	jr	Z, 00186$
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x20
	jr	Z, 00186$
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x21
	jr	Z, 00186$
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x22
	jr	NZ, 00187$
00186$:
;src/states/game.c:394: if (input_pressed(J_B)) {
	ld	a, #0x20
	call	_input_pressed
	or	a, a
	jr	Z, 00187$
;src/states/game.c:395: if (!inventory_has_item("LLAVE")) {
	ld	de, #___str_2
	call	_inventory_has_item
	ldhl	sp,#12
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00182$
;src/states/game.c:396: text_dialogue("HAS ENCONTRADO LA\nLLAVE DEL PORTON!");
	ld	de, #___str_3
	call	_text_dialogue
;src/states/game.c:397: inventory_add_item("LLAVE", "ABRE EL PORTON NORTE", 41);
	ld	a, #0x29
	push	af
	inc	sp
	ld	bc, #___str_4
	ld	de, #___str_2
	call	_inventory_add_item
	jr	00187$
00182$:
;src/states/game.c:399: text_dialogue("EL ROPERO ESTA\nVACIO.");
	ld	de, #___str_5
	call	_text_dialogue
00187$:
;src/states/game.c:403: if (current_map == &world_map_info && (tid == 43 || tid == 44)) {
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_world_map_info)
	jr	NZ, 00200$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_world_map_info)
	jr	NZ, 00200$
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x2b
	jr	Z, 00195$
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x2c
	jr	NZ, 00200$
00195$:
;src/states/game.c:404: if (inventory_has_item("LLAVE")) {
	ld	de, #___str_2
	call	_inventory_has_item
	or	a, a
	jr	Z, 00193$
;src/states/game.c:405: text_dialogue("USAS LA LLAVE...\nEL PORTON SE ABRE!");
	ld	de, #___str_6
	call	_text_dialogue
;src/states/game.c:406: switch_map(&level2_map_info, 128, 224);
	ld	de, #0x00e0
	push	de
	ld	bc, #0x0080
	ld	de, #_level2_map_info
	call	_switch_map
;src/states/game.c:407: return;
	jr	00221$
00193$:
;src/states/game.c:409: text_dialogue("EL PORTON ESTA\nCERRADO.");
	ld	de, #___str_7
	call	_text_dialogue
00200$:
;src/states/game.c:414: if ((env_anim_timer % 32) == 0) {
	ld	a, (_env_anim_timer)
	and	a, #0x1f
	jr	NZ, 00202$
;src/states/game.c:415: env_anim_frame = !env_anim_frame;
	ld	hl, #_env_anim_frame
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/states/game.c:419: set_bkg_data(2, 1, env_anim_frame ? &tiles_anim_data[0] : &tiles_data[32]);
	ld	a, (hl)
	or	a, a
	jr	Z, 00231$
	ld	bc, #_tiles_anim_data+0
	jr	00232$
00231$:
	ld	bc, #_tiles_data+32
00232$:
	push	bc
	ld	hl, #0x102
	push	hl
	call	_set_bkg_data
	add	sp, #4
00202$:
;src/states/game.c:421: env_anim_timer++;
	ld	hl, #_env_anim_timer
	inc	(hl)
00221$:
;src/states/game.c:422: }
	add	sp, #13
	ret
___str_2:
	.ascii "LLAVE"
	.db 0x00
___str_3:
	.ascii "HAS ENCONTRADO LA"
	.db 0x0a
	.ascii "LLAVE DEL PORTON!"
	.db 0x00
___str_4:
	.ascii "ABRE EL PORTON NORTE"
	.db 0x00
___str_5:
	.ascii "EL ROPERO ESTA"
	.db 0x0a
	.ascii "VACIO."
	.db 0x00
___str_6:
	.ascii "USAS LA LLAVE..."
	.db 0x0a
	.ascii "EL PORTON SE ABRE!"
	.db 0x00
___str_7:
	.ascii "EL PORTON ESTA"
	.db 0x0a
	.ascii "CERRADO."
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
__xinit__env_anim_timer:
	.db #0x00	; 0
__xinit__env_anim_frame:
	.db #0x00	; 0
__xinit__game_ready:
	.db #0x00	; 0
	.area _CABS (ABS)
