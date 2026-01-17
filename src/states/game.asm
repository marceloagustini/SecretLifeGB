;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module game
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _player_hit
	.globl _can_move
	.globl _is_solid
	.globl _switch_map
	.globl _load_map
	.globl _update_player_sprite
	.globl _hud_update
	.globl _update_camera
	.globl _get_tile_at
	.globl _map_init_data
	.globl _strcmp
	.globl _get_tile_for_char
	.globl _text_dialogue
	.globl _text_init
	.globl _projectile_check_collision
	.globl _projectile_render_all
	.globl _projectile_update_all
	.globl _projectile_spawn
	.globl _projectile_init
	.globl _sfx_success
	.globl _sfx_pickup
	.globl _music_update
	.globl _music_init
	.globl _map_is_solid
	.globl _inventory_has_item
	.globl _inventory_add_item
	.globl _inventory_init
	.globl _input_held
	.globl _input_pressed
	.globl _fade_in
	.globl _fade_out
	.globl _entity_render_all
	.globl _entity_update_all
	.globl _fill_bkg_rect
	.globl _set_sprite_data
	.globl _set_win_tiles
	.globl _set_bkg_tile_xy
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _display_off
	.globl _delay
	.globl _player_ammo
	.globl _player_lives
	.globl _env_anim_frame
	.globl _env_anim_timer
	.globl _level2_door_y
	.globl _level2_door_x
	.globl _camera_y
	.globl _camera_x
	.globl _anim_timer
	.globl _anim_frame
	.globl _player_dir
	.globl _enter_y
	.globl _enter_x
	.globl _player_y
	.globl _player_x
	.globl _saved_world_y
	.globl _saved_world_x
	.globl _game_init
	.globl _game_update
	.globl _game_reset
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
_enter_x::
	.ds 2
_enter_y::
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
_level2_door_x::
	.ds 2
_level2_door_y::
	.ds 2
_env_anim_timer::
	.ds 1
_env_anim_frame::
	.ds 1
_player_lives::
	.ds 1
_player_ammo::
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
;src/states/game.c:47: uint8_t get_tile_at(uint16_t x, uint16_t y) {
;	---------------------------------
; Function get_tile_at
; ---------------------------------
_get_tile_at::
	add	sp, #-6
;src/states/game.c:48: uint16_t tx = x / 8, ty = y / 8;
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
;src/states/game.c:49: if (tx >= current_map->w || ty >= current_map->h)
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
;src/states/game.c:50: return 0;
	xor	a, a
	jr	00104$
00102$:
;src/states/game.c:51: return current_map->tiles[ty * current_map->w + tx];
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
;src/states/game.c:52: }
	add	sp, #6
	ret
;src/states/game.c:54: void update_camera(void) {
;	---------------------------------
; Function update_camera
; ---------------------------------
_update_camera::
	add	sp, #-4
;src/states/game.c:55: uint16_t w = current_map->w * 8, h = current_map->h * 8;
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
;src/states/game.c:56: if (player_x > SCREEN_WIDTH / 2)
	ld	hl, #_player_x
	ld	a, #0x50
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00102$
;src/states/game.c:57: camera_x = player_x - SCREEN_WIDTH / 2;
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
;src/states/game.c:59: camera_x = 0;
	xor	a, a
	ld	hl, #_camera_x
	ld	(hl+), a
	ld	(hl), a
00103$:
;src/states/game.c:60: if (player_y > SCREEN_HEIGHT / 2)
	ld	hl, #_player_y
	ld	a, #0x48
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00105$
;src/states/game.c:61: camera_y = player_y - SCREEN_HEIGHT / 2;
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
;src/states/game.c:63: camera_y = 0;
	xor	a, a
	ld	hl, #_camera_y
	ld	(hl+), a
	ld	(hl), a
00106$:
;src/states/game.c:64: if (camera_x > w - SCREEN_WIDTH)
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
;src/states/game.c:65: camera_x = (w > SCREEN_WIDTH) ? (w - SCREEN_WIDTH) : 0;
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
;src/states/game.c:66: if (camera_y > h - SCREEN_HEIGHT)
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
;src/states/game.c:67: camera_y = (h > SCREEN_HEIGHT) ? (h - SCREEN_HEIGHT) : 0;
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
;src/states/game.c:68: move_bkg(camera_x, camera_y);
	ld	a, (_camera_y)
	ld	c, a
	ld	a, (#_camera_x)
	ldh	(_SCX_REG + 0), a
;./gbdk/include/gb/gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/states/game.c:68: move_bkg(camera_x, camera_y);
;src/states/game.c:69: }
	add	sp, #4
	ret
;src/states/game.c:71: void hud_update(void) {
;	---------------------------------
; Function hud_update
; ---------------------------------
_hud_update::
	add	sp, #-20
;src/states/game.c:73: for (int i = 0; i < 20; i++)
	ld	c, #0x00
00106$:
	ld	a, c
	sub	a, #0x14
	jr	NC, 00101$
;src/states/game.c:74: hud_tiles[i] = get_tile_for_char(' ');
	ld	e, c
	ld	d, #0x00
	ld	hl, #0
	add	hl, sp
	add	hl, de
	push	hl
	push	bc
	ld	a, #0x20
	call	_get_tile_for_char
	pop	bc
	pop	hl
	ld	(hl), a
;src/states/game.c:73: for (int i = 0; i < 20; i++)
	inc	c
	jr	00106$
00101$:
;src/states/game.c:76: hud_tiles[1] = get_tile_for_char('V');
	ld	a, #0x56
	call	_get_tile_for_char
	ldhl	sp,	#1
	ld	(hl), a
;src/states/game.c:77: hud_tiles[2] = get_tile_for_char('i');
	ld	a, #0x69
	call	_get_tile_for_char
	ldhl	sp,	#2
	ld	(hl), a
;src/states/game.c:78: hud_tiles[3] = get_tile_for_char('d');
	ld	a, #0x64
	call	_get_tile_for_char
	ldhl	sp,	#3
	ld	(hl), a
;src/states/game.c:79: hud_tiles[4] = get_tile_for_char('a');
	ld	a, #0x61
	call	_get_tile_for_char
	ldhl	sp,	#4
	ld	(hl), a
;src/states/game.c:80: hud_tiles[5] = get_tile_for_char('s');
	ld	a, #0x73
	call	_get_tile_for_char
	ldhl	sp,	#5
	ld	(hl), a
;src/states/game.c:81: hud_tiles[6] = get_tile_for_char(':');
	ld	a, #0x3a
	call	_get_tile_for_char
	ldhl	sp,	#6
	ld	(hl), a
;src/states/game.c:82: hud_tiles[8] = get_tile_for_char('0' + player_lives);
	ld	a, (_player_lives)
	add	a, #0x30
	call	_get_tile_for_char
	ldhl	sp,	#8
	ld	(hl), a
;src/states/game.c:84: if (inventory_has_item("ARMA")) {
	ld	de, #___str_0
	call	_inventory_has_item
	or	a, a
	jr	Z, 00103$
;src/states/game.c:85: hud_tiles[10] = get_tile_for_char('B');
	ld	a, #0x42
	call	_get_tile_for_char
	ldhl	sp,	#10
	ld	(hl), a
;src/states/game.c:86: hud_tiles[11] = get_tile_for_char(':');
	ld	a, #0x3a
	call	_get_tile_for_char
	ldhl	sp,	#11
	ld	(hl), a
;src/states/game.c:87: hud_tiles[12] = get_tile_for_char('0' + (player_ammo / 10));
	ld	a, (_player_ammo)
	ld	e, #0x0a
	call	__divuchar
	ld	a, c
	add	a, #0x30
	call	_get_tile_for_char
	ldhl	sp,	#12
	ld	(hl), a
;src/states/game.c:88: hud_tiles[13] = get_tile_for_char('0' + (player_ammo % 10));
	ld	a, (_player_ammo)
	ld	e, #0x0a
	call	__moduchar
	ld	a, c
	add	a, #0x30
	call	_get_tile_for_char
	ldhl	sp,	#13
	ld	(hl), a
00103$:
;src/states/game.c:91: set_win_tiles(0, 0, 20, 1, hud_tiles);
	ld	hl, #0
	add	hl, sp
	push	hl
	ld	hl, #0x114
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_win_tiles
	add	sp, #6
;./gbdk/include/gb/gb.h:1739: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x88
	ldh	(_WY_REG + 0), a
;src/states/game.c:93: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:94: }
	add	sp, #20
	ret
___str_0:
	.ascii "ARMA"
	.db 0x00
;src/states/game.c:96: void update_player_sprite(void) {
;	---------------------------------
; Function update_player_sprite
; ---------------------------------
_update_player_sprite::
	dec	sp
;src/states/game.c:97: uint8_t base =
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
;src/states/game.c:101: uint8_t prop = (player_dir == 3) ? S_FLIPX : 0;
	ld	a, b
	or	a, a
	ld	e, #0x20
	jr	NZ, 00131$
	ld	e, #0x00
00131$:
;src/states/game.c:102: if (prop == 0) {
	ld	a, e
	or	a, a
	jr	NZ, 00104$
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), c
;src/states/game.c:104: set_sprite_tile(1, base + 1);
	ld	a, c
	inc	a
	ldhl	sp,	#0
	ld	(hl), a
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	de, #(_shadow_OAM + 6)
	ld	a, (hl)
	ld	(de), a
;src/states/game.c:105: set_sprite_tile(2, base + 2);
	ld	b, c
	inc	b
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), b
;src/states/game.c:106: set_sprite_tile(3, base + 3);
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), c
;src/states/game.c:107: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00117$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00122$
;src/states/game.c:108: set_sprite_prop(i, 0);
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
;src/states/game.c:107: for (int i = 0; i < 4; i++)
	inc	c
	jr	00117$
00104$:
;src/states/game.c:110: set_sprite_tile(0, base + 1);
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
;src/states/game.c:112: set_sprite_tile(2, base + 3);
	ld	c, b
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), c
;src/states/game.c:113: set_sprite_tile(3, base + 2);
	inc	b
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), b
;src/states/game.c:114: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00120$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00122$
;src/states/game.c:115: set_sprite_prop(i, S_FLIPX);
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
;src/states/game.c:114: for (int i = 0; i < 4; i++)
	inc	c
	jr	00120$
00122$:
;src/states/game.c:117: }
	inc	sp
	ret
;src/states/game.c:119: void load_map(map_t *m, uint16_t x, uint16_t y) {
;	---------------------------------
; Function load_map
; ---------------------------------
_load_map::
	add	sp, #-6
	ldhl	sp,	#4
	ld	a, e
	ld	(hl+), a
;src/states/game.c:120: HIDE_BKG;
;src/states/game.c:121: current_map = m;
	ld	a, d
	ld	(hl-), a
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
	ld	a, (hl)
	ld	(#_current_map),a
	ldhl	sp,	#5
	ld	a, (hl)
	ld	(#_current_map + 1),a
;src/states/game.c:122: player_x = x;
	ld	hl, #_player_x
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:123: player_y = y;
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(#_player_y),a
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(#_player_y + 1),a
;src/states/game.c:125: for (int i = 4; i < 40; i++)
	ld	c, #0x04
00113$:
	ld	a, c
	sub	a, #0x28
	jr	NC, 00101$
;src/states/game.c:126: move_sprite(i, 0, 0); // Hide map sprites
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, c
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/states/game.c:125: for (int i = 4; i < 40; i++)
	inc	c
	jr	00113$
00101$:
;src/states/game.c:128: if (m == &maps[1]) // HOUSE_MAP
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, #<((_maps + 26))
	jr	NZ, 00103$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 26))
	jr	NZ, 00103$
;src/states/game.c:129: fill_bkg_rect(0, 0, 32, 32, 26);
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
;src/states/game.c:131: set_bkg_tiles(0, 0, m->w, m->h, m->tiles);
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	inc	de
	inc	de
	inc	de
	ld	a, (de)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	inc	de
	inc	de
	push	af
	ld	a, (de)
	ld	h, a
	pop	af
	push	de
	push	bc
	push	af
	inc	sp
	push	hl
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
;src/states/game.c:134: if (m == &maps[2]) {
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, #<((_maps + 52))
	jr	NZ, 00108$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 52))
	jr	NZ, 00108$
;src/states/game.c:137: if (DIV_REG & 0x01) {
	ldh	a, (_DIV_REG + 0)
	rrca
	jr	NC, 00105$
;src/states/game.c:138: rx = 2; // Top-left
	ld	bc, #0x0002
	jr	00106$
00105$:
;src/states/game.c:140: rx = m->w - 4; // Top-right
	ld	a, (de)
	ld	c, a
	ld	b, #0x00
	ld	a, c
	add	a, #0xfc
	ld	c, a
	ld	a, b
	adc	a, #0xff
	ld	b, a
00106$:
;src/states/game.c:143: level2_door_x = rx * 8;
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a, l
	ld	e, h
	ld	hl, #_level2_door_x
	ld	(hl+), a
	ld	(hl), e
;src/states/game.c:144: level2_door_y = ry * 8;
	ld	hl, #_level2_door_y
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:147: set_bkg_tile_xy(rx, ry, 31);
	push	bc
	ld	a, #0x1f
	push	af
	inc	sp
	ld	e, #0x02
	ld	a, c
	call	_set_bkg_tile_xy
	pop	bc
;src/states/game.c:148: set_bkg_tile_xy(rx + 1, ry, 31);
	ld	b, c
	inc	b
	push	bc
	ld	a, #0x1f
	push	af
	inc	sp
	ld	e, #0x02
	ld	a, b
	call	_set_bkg_tile_xy
	pop	bc
;src/states/game.c:149: set_bkg_tile_xy(rx, ry + 1, 31);
	push	bc
	ld	a, #0x1f
	push	af
	inc	sp
	ld	e, #0x03
	ld	a, c
	call	_set_bkg_tile_xy
	pop	bc
;src/states/game.c:150: set_bkg_tile_xy(rx + 1, ry + 1, 31);
	ld	a, #0x1f
	push	af
	inc	sp
	ld	e, #0x03
	ld	a, b
	call	_set_bkg_tile_xy
00108$:
;src/states/game.c:153: update_camera();
	call	_update_camera
;src/states/game.c:156: uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
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
;src/states/game.c:157: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00116$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00109$
;src/states/game.c:158: move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));
	ldhl	sp,	#1
	ld	e, (hl)
	ld	a, c
	sub	a, #0x02
	jr	C, 00120$
	ld	a, #0x08
	jr	00121$
00120$:
	xor	a, a
00121$:
	add	a, e
	ldhl	sp,	#2
	ld	(hl-), a
	dec	hl
	ld	e, (hl)
	ld	b, c
	ld	a, b
	and	a, #0x01
	ld	a, #0x08
	jr	NZ, 00123$
	xor	a, a
00123$:
	add	a, e
	ldhl	sp,	#3
	ld	(hl), a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	xor	a, a
	ld	l, b
	ld	h, a
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	e, l
	ld	d, h
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/states/game.c:157: for (int i = 0; i < 4; i++)
	inc	c
	jr	00116$
00109$:
;src/states/game.c:160: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:161: }
	add	sp, #6
	pop	hl
	pop	af
	jp	(hl)
;src/states/game.c:163: void switch_map(map_t *new_map, uint16_t new_x, uint16_t new_y) {
;	---------------------------------
; Function switch_map
; ---------------------------------
_switch_map::
;src/states/game.c:164: fade_out();
	push	bc
	push	de
	call	_fade_out
	pop	de
	pop	bc
;src/states/game.c:165: enter_x = new_x; // Remember map entrance
	ld	hl, #_enter_x
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:166: enter_y = new_y;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(#_enter_y),a
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_enter_y + 1),a
;src/states/game.c:167: load_map(new_map, new_x, new_y);
	ldhl	sp,	#2
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	push	hl
	call	_load_map
;src/states/game.c:168: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:169: fade_in();
	call	_fade_in
;src/states/game.c:170: }
	pop	hl
	pop	af
	jp	(hl)
;src/states/game.c:172: uint8_t is_solid(uint16_t x, uint16_t y) { return map_is_solid(x, y); }
;	---------------------------------
; Function is_solid
; ---------------------------------
_is_solid::
	jp	_map_is_solid
;src/states/game.c:174: uint8_t can_move(uint16_t nx, uint16_t ny) {
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
;src/states/game.c:175: if (nx < 4 || ny < 4 || nx > (current_map->w * 8 - 12) ||
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
;src/states/game.c:176: ny > (current_map->h * 8 - 12))
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
;src/states/game.c:177: return 0;
	xor	a, a
	jp	00124$
00102$:
;src/states/game.c:179: if (is_solid(nx + 4, ny + 8) || is_solid(nx + 12, ny + 8) ||
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
;src/states/game.c:180: is_solid(nx + 4, ny + 15) || is_solid(nx + 12, ny + 15)) {
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
;src/states/game.c:181: return 0;
	xor	a, a
	jp	00124$
;src/states/game.c:184: for (int i = 0; i < current_map->num_entities; i++) {
00138$:
	xor	a, a
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), a
00123$:
;src/states/game.c:175: if (nx < 4 || ny < 4 || nx > (current_map->w * 8 - 12) ||
	ld	a, (_current_map)
	ld	c, a
	ld	hl, #_current_map + 1
	ld	b, (hl)
;src/states/game.c:184: for (int i = 0; i < current_map->num_entities; i++) {
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
;src/states/game.c:185: entity_t *e = &current_map->entities[i];
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#8
	ld	a, (hl+)
	ld	e, (hl)
	add	a, a
	rl	e
	add	a, a
	rl	e
	add	a, a
	rl	e
	add	a, a
	rl	e
	ld	l, a
	ld	h, e
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#4
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#3
;src/states/game.c:186: if (!e->active)
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
;src/states/game.c:188: int16_t dx = (int16_t)nx - e->x, dy = (int16_t)ny - e->y;
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
;src/states/game.c:189: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00114$
;src/states/game.c:190: dx = -dx;
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
;src/states/game.c:191: if (dy < 0)
	ldhl	sp,	#12
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00116$
;src/states/game.c:192: dy = -dy;
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
;src/states/game.c:193: if (dx < 12 && dy < 12)
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
;src/states/game.c:194: return 0; // Collide if too close
	xor	a, a
	jr	00124$
00120$:
;src/states/game.c:184: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#8
	inc	(hl)
	jp	NZ, 00123$
	inc	hl
	inc	(hl)
	jp	00123$
00121$:
;src/states/game.c:196: return 1;
	ld	a, #0x01
00124$:
;src/states/game.c:197: }
	add	sp, #14
	ret
;src/states/game.c:203: void game_init(void) {
;	---------------------------------
; Function game_init
; ---------------------------------
_game_init::
;src/states/game.c:204: DISPLAY_OFF;
	call	_display_off
;src/states/game.c:205: set_bkg_data(0, 60, tiles_data); // All tiles (now includes portal)
	ld	de, #_tiles_data
	push	de
	ld	hl, #0x3c00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:207: if (game_ready) {
	ld	a, (#_game_ready)
	or	a, a
	jr	Z, 00102$
;src/states/game.c:208: map_init_data();
	call	_map_init_data
;src/states/game.c:209: load_map(current_map, player_x, player_y);
	ld	a, (_player_y)
	ld	e, a
	ld	hl, #_player_y + 1
	ld	d, (hl)
	push	de
	ld	a, (_player_x)
	ld	c, a
	ld	hl, #_player_x + 1
	ld	b, (hl)
	ld	a, (_current_map)
	ld	e, a
	ld	hl, #_current_map + 1
	ld	d, (hl)
	call	_load_map
;src/states/game.c:210: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:211: BGP_REG = OBP0_REG = OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/states/game.c:212: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:213: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:214: return;
	ret
00102$:
;src/states/game.c:217: map_init_data();
	call	_map_init_data
;src/states/game.c:218: enter_x = 128;
	ld	hl, #_enter_x
	ld	a, #0x80
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:219: enter_y = 128;
	ld	hl, #_enter_y
	ld	a, #0x80
	ld	(hl+), a
;src/states/game.c:221: load_map(&maps[0], 128, 128); // WORLD_MAP
	xor	a, a
	ld	(hl), a
	push	af
	ld	bc, #0x0080
	ld	de, #_maps
	call	_load_map
;src/states/game.c:224: BGP_REG = OBP0_REG = OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/states/game.c:225: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:226: set_sprite_data(0, 24, player_sprites);
	ld	de, #_player_sprites
	push	de
	ld	hl, #0x1800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:227: set_sprite_data(24, 4, npc_child_sprite);
	ld	de, #_npc_child_sprite
	push	de
	ld	hl, #0x418
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:228: set_sprite_data(28, 8, guard_sprite_data);
	ld	de, #_guard_sprite_data
	push	de
	ld	hl, #0x81c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:229: set_sprite_data(36, 4, npc_woman_sprite);
	ld	de, #_npc_woman_sprite
	push	de
	ld	hl, #0x424
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:230: set_sprite_data(40, 1, projectile_sprite);
	ld	de, #_projectile_sprite
	push	de
	ld	hl, #0x128
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:231: set_sprite_data(41, 1, flower_sprite);
	ld	de, #_flower_sprite
	push	de
	ld	hl, #0x129
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:232: set_sprite_data(42, 4, portal_sprite);
	ld	de, #_portal_sprite
	push	de
	ld	hl, #0x42a
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:233: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:234: text_init();
	call	_text_init
;src/states/game.c:235: music_init();
	call	_music_init
;src/states/game.c:236: projectile_init();
	call	_projectile_init
;src/states/game.c:237: enter_x = player_x;
	ld	a, (#_player_x)
	ld	(#_enter_x),a
	ld	a, (#_player_x + 1)
	ld	(#_enter_x + 1),a
;src/states/game.c:238: enter_y = player_y;
	ld	a, (#_player_y)
	ld	(#_enter_y),a
	ld	a, (#_player_y + 1)
	ld	(#_enter_y + 1),a
;src/states/game.c:239: hud_update();
	call	_hud_update
;./gbdk/include/gb/gb.h:1739: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x88
	ldh	(_WY_REG + 0), a
;src/states/game.c:241: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:242: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:243: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:244: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:245: game_ready = 1;
	ld	hl, #_game_ready
	ld	(hl), #0x01
;src/states/game.c:246: }
	ret
;src/states/game.c:248: void player_hit(void) {
;	---------------------------------
; Function player_hit
; ---------------------------------
_player_hit::
;src/states/game.c:249: if (player_lives > 0)
	ld	hl, #_player_lives
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;src/states/game.c:250: player_lives--;
	dec	(hl)
00102$:
;src/states/game.c:252: fade_out();
	call	_fade_out
;src/states/game.c:253: delay(1000);
	ld	de, #0x03e8
	call	_delay
;src/states/game.c:255: if (player_lives == 0) {
	ld	a, (#_player_lives)
	or	a, a
	jr	NZ, 00104$
;src/states/game.c:256: game_state = STATE_GAMEOVER;
	ld	hl, #_game_state
	ld	(hl), #0x04
;src/states/game.c:257: return;
	ret
00104$:
;src/states/game.c:261: map_init_data();
	call	_map_init_data
;src/states/game.c:262: projectile_init();
	call	_projectile_init
;src/states/game.c:265: load_map(current_map, enter_x, enter_y);
	ld	a, (_enter_y)
	ld	e, a
	ld	hl, #_enter_y + 1
	ld	d, (hl)
	push	de
	ld	a, (_enter_x)
	ld	c, a
	ld	hl, #_enter_x + 1
	ld	b, (hl)
	ld	a, (_current_map)
	ld	e, a
	ld	hl, #_current_map + 1
	ld	d, (hl)
	call	_load_map
;src/states/game.c:266: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:268: hud_update();
	call	_hud_update
;./gbdk/include/gb/gb.h:1739: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x88
	ldh	(_WY_REG + 0), a
;src/states/game.c:270: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:272: fade_in();
;src/states/game.c:273: }
	jp	_fade_in
;src/states/game.c:275: void game_update(void) {
;	---------------------------------
; Function game_update
; ---------------------------------
_game_update::
	add	sp, #-15
;src/states/game.c:276: music_update();
	call	_music_update
;src/states/game.c:277: uint8_t moved = 0;
	ldhl	sp,	#10
	ld	(hl), #0x00
;src/states/game.c:278: uint16_t nx = player_x, ny = player_y;
	ld	a, (#_player_x)
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#12
	ld	(hl), a
	ld	a, (#_player_y)
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#14
	ld	(hl), a
;src/states/game.c:280: if (input_held(J_UP)) {
	ld	a, #0x04
	call	_input_held
	or	a, a
	jr	Z, 00110$
;src/states/game.c:281: ny--;
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:282: player_dir = 1;
	ld	hl, #_player_dir
	ld	(hl), #0x01
;src/states/game.c:283: moved = 1;
	ldhl	sp,	#10
	ld	(hl), #0x01
	jr	00111$
00110$:
;src/states/game.c:284: } else if (input_held(J_DOWN)) {
	ld	a, #0x08
	call	_input_held
	or	a, a
	jr	Z, 00107$
;src/states/game.c:285: ny++;
	ldhl	sp,	#13
	inc	(hl)
	jr	NZ, 01002$
	inc	hl
	inc	(hl)
01002$:
;src/states/game.c:286: player_dir = 0;
	xor	a, a
	ld	(#_player_dir),a
;src/states/game.c:287: moved = 1;
	ldhl	sp,	#10
	ld	(hl), #0x01
	jr	00111$
00107$:
;src/states/game.c:288: } else if (input_held(J_LEFT)) {
	ld	a, #0x02
	call	_input_held
	or	a, a
	jr	Z, 00104$
;src/states/game.c:289: nx--;
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:290: player_dir = 2;
	ld	hl, #_player_dir
	ld	(hl), #0x02
;src/states/game.c:291: moved = 1;
	ldhl	sp,	#10
	ld	(hl), #0x01
	jr	00111$
00104$:
;src/states/game.c:292: } else if (input_held(J_RIGHT)) {
	ld	a, #0x01
	call	_input_held
	or	a, a
	jr	Z, 00111$
;src/states/game.c:293: nx++;
	ldhl	sp,	#11
	inc	(hl)
	jr	NZ, 01003$
	inc	hl
	inc	(hl)
01003$:
;src/states/game.c:294: player_dir = 3;
	ld	hl, #_player_dir
	ld	(hl), #0x03
;src/states/game.c:295: moved = 1;
	ldhl	sp,	#10
	ld	(hl), #0x01
00111$:
;src/states/game.c:298: if (moved) {
	ldhl	sp,	#10
	ld	a, (hl)
	or	a, a
	jr	Z, 00156$
;src/states/game.c:299: if (can_move(nx, ny)) {
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_can_move
	or	a, a
	jp	Z, 00157$
;src/states/game.c:300: player_x = nx;
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(#_player_x),a
	ldhl	sp,	#12
	ld	a, (hl)
	ld	(#_player_x + 1),a
;src/states/game.c:301: player_y = ny;
	ldhl	sp,	#13
	ld	a, (hl)
	ld	(#_player_y),a
	ldhl	sp,	#14
	ld	a, (hl)
	ld	(#_player_y + 1),a
;src/states/game.c:302: update_camera();
	call	_update_camera
;src/states/game.c:304: if (++anim_timer > 6) {
	ld	hl, #_anim_timer
	inc	(hl)
	ld	a, #0x06
	sub	a, (hl)
	jp	NC, 00157$
;src/states/game.c:305: anim_frame = !anim_frame;
	ld	hl, #_anim_frame
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/states/game.c:306: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
;src/states/game.c:307: update_player_sprite();
	call	_update_player_sprite
	jp	00157$
00156$:
;src/states/game.c:311: if (anim_frame != 0) {
	ld	hl, #_anim_frame
	ld	a, (hl)
	or	a, a
	jr	Z, 00117$
;src/states/game.c:312: anim_frame = 0;
	ld	(hl), #0x00
;src/states/game.c:313: update_player_sprite();
	call	_update_player_sprite
00117$:
;src/states/game.c:315: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
;src/states/game.c:318: if (input_pressed(J_SELECT)) {
	ld	a, #0x40
	call	_input_pressed
	or	a, a
	jr	Z, 00119$
;src/states/game.c:319: game_state = 3; // STATE_INVENTORY
	ld	hl, #_game_state
	ld	(hl), #0x03
;src/states/game.c:320: return;
	jp	00289$
00119$:
;src/states/game.c:324: uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
	ld	a, (#_player_y)
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, (#_player_x)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_get_tile_at
	ldhl	sp,	#14
	ld	(hl), a
;src/states/game.c:325: if (current_map == &maps[0] && // WORLD_MAP
;src/states/game.c:324: uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
	ld	a, (#_player_y)
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#12
	ld	(hl), a
	ld	a, (#_player_x)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#10
	ld	(hl), a
;src/states/game.c:330: switch_map(&maps[1], 76, 112); // HOUSE_MAP
;src/states/game.c:325: if (current_map == &maps[0] && // WORLD_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_maps)
	jr	NZ, 00124$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_maps)
	jr	NZ, 00124$
;src/states/game.c:326: (tid == 21 || tid == 22)) {
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x15
	jr	Z, 00123$
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x16
	jr	NZ, 00124$
00123$:
;src/states/game.c:327: if (player_x > 160 && player_y > 160) {
	ldhl	sp,	#9
	ld	a, #0xa0
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00124$
	ldhl	sp,	#11
	ld	a, #0xa0
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00124$
;src/states/game.c:328: saved_world_x = player_x;
	ld	a, (#_player_x)
	ld	(#_saved_world_x),a
	ld	a, (#_player_x + 1)
	ld	(#_saved_world_x + 1),a
;src/states/game.c:329: saved_world_y = player_y + 16;
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	ld	c, l
	ld	a, h
	ld	hl, #_saved_world_y
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/states/game.c:330: switch_map(&maps[1], 76, 112); // HOUSE_MAP
	ld	de, #0x0070
	push	de
	ld	bc, #0x004c
	ld	de, #(_maps + 26)
	call	_switch_map
;src/states/game.c:331: return;
	jp	00289$
00124$:
;src/states/game.c:334: tid = get_tile_at(player_x + 8, player_y + 12);
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_get_tile_at
	ldhl	sp,	#3
	ld	(hl), a
;src/states/game.c:335: if (current_map == &maps[1] && tid == 35) { // HOUSE_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 26))
	jr	NZ, 00128$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 26))
	jr	NZ, 00128$
	ldhl	sp,	#3
	ld	a, (hl)
	sub	a, #0x23
	jr	NZ, 00128$
;src/states/game.c:336: uint16_t wx = saved_world_x;
	ld	a, (#_saved_world_x)
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (#_saved_world_x + 1)
	ldhl	sp,	#12
	ld	(hl), a
;src/states/game.c:337: uint16_t wy = saved_world_y;
	ld	a, (#_saved_world_y)
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (#_saved_world_y + 1)
	ldhl	sp,	#14
;src/states/game.c:338: switch_map(&maps[0], wx, wy); // WORLD_MAP
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #_maps
	call	_switch_map
;src/states/game.c:339: return;
	jp	00289$
00128$:
;src/states/game.c:341: if (current_map == &maps[2] && tid == 0 && player_y > 240) { // LEVEL2_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 52))
	jr	NZ, 01013$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 52))
	ld	a, #0x01
	jr	Z, 01014$
01013$:
	xor	a, a
01014$:
	ldhl	sp,	#14
	ld	(hl), a
;src/states/game.c:324: uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
	ld	a, (#_player_y)
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#5
;src/states/game.c:341: if (current_map == &maps[2] && tid == 0 && player_y > 240) { // LEVEL2_MAP
	ld	(hl-), a
	ld	a, #0xf0
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	rla
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	or	a, a
	jr	Z, 00131$
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, a
	jr	NZ, 00131$
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	Z, 00131$
;src/states/game.c:342: switch_map(&maps[0], 124, 48);                             // WORLD_MAP
	ld	de, #0x0030
	push	de
	ld	bc, #0x007c
	ld	de, #_maps
	call	_switch_map
;src/states/game.c:343: return;
	jp	00289$
00131$:
;src/states/game.c:356: switch_map(&maps[3], 124, 240); // To Level 3 (bottom-middle path)
;src/states/game.c:347: if (current_map == &maps[2]) {
	ldhl	sp,	#14
	ld	a, (hl)
	or	a, a
	jp	Z, 00142$
;src/states/game.c:348: int16_t dx = (int16_t)player_x - (int16_t)level2_door_x;
	ld	a, (#_player_x)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (#_level2_door_x)
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (#_level2_door_x + 1)
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#13
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
	ld	(hl), e
;src/states/game.c:349: int16_t dy = (int16_t)player_y - (int16_t)level2_door_y;
	ld	a, (#_player_y)
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (#_level2_door_y)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (#_level2_door_y + 1)
	ldhl	sp,	#10
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#14
	ld	(hl-), a
;src/states/game.c:350: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#12
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00135$
;src/states/game.c:351: dx = -dx;
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
	ldhl	sp,	#12
	ld	(hl-), a
	ld	(hl), e
00135$:
;src/states/game.c:352: if (dy < 0)
	ldhl	sp,	#13
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00137$
;src/states/game.c:353: dy = -dy;
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	(hl), e
00137$:
;src/states/game.c:355: if (dx < 16 && dy < 16) {
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x10
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00142$
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x10
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00142$
;src/states/game.c:356: switch_map(&maps[3], 124, 240); // To Level 3 (bottom-middle path)
	ld	de, #0x00f0
	push	de
	ld	bc, #0x007c
	ld	de, #(_maps + 78)
	call	_switch_map
;src/states/game.c:357: return;
	jp	00289$
00142$:
;src/states/game.c:363: switch_map(&maps[4], 8, 8); // To Maze
	ld	de, #_maps + 104
;src/states/game.c:361: if (current_map == &maps[3]) { // LEVEL3_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 78))
	jr	NZ, 00149$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 78))
	jr	NZ, 00149$
;src/states/game.c:362: if (player_y < 8) {
	ldhl	sp,	#4
	ld	a, (hl+)
	sub	a, #0x08
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00144$
;src/states/game.c:363: switch_map(&maps[4], 8, 8); // To Maze
	ld	bc, #0x0008
	push	bc
	call	_switch_map
;src/states/game.c:364: return;
	jp	00289$
00144$:
;src/states/game.c:366: if (tid == 0 && player_y > 240) {
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, a
	jr	NZ, 00149$
	ldhl	sp,	#6
	ld	a, (hl)
	or	a, a
	jr	Z, 00149$
;src/states/game.c:367: switch_map(&maps[2], 128, 224); // Return to Level 2
	ld	de, #0x00e0
	push	de
	ld	bc, #0x0080
	ld	de, #(_maps + 52)
	call	_switch_map
;src/states/game.c:368: return;
	jp	00289$
00149$:
;src/states/game.c:372: if (current_map == &maps[4]) { // MAZE_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, e
	jr	NZ, 00157$
	inc	hl
	ld	a, (hl)
	sub	a, d
	jr	NZ, 00157$
;src/states/game.c:374: if (tid >= 41 && tid <= 44) {
	ldhl	sp,	#3
	ld	a, (hl)
	sub	a, #0x29
	jr	C, 00157$
	ld	a, #0x2c
	sub	a, (hl)
	jr	C, 00157$
;src/states/game.c:375: switch_map(&maps[0], 128, 128); // To World Map
	xor	a, a
	push	af
	ld	bc, #0x0080
	ld	de, #_maps
	call	_switch_map
;src/states/game.c:376: return;
	jp	00289$
00157$:
;src/states/game.c:383: uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
	ld	a, (_player_x)
	ld	hl, #_camera_x
	ld	c, (hl)
	sub	a, c
	ldhl	sp,	#14
	ld	(hl), a
	ld	a, (hl)
	add	a, #0x08
	ldhl	sp,	#6
	ld	(hl), a
	ld	hl, #_player_y
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
	ldhl	sp,	#14
	ld	(hl-), a
	ld	(hl), e
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl-)
	dec	hl
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0010
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl), a
;src/states/game.c:384: uint8_t use_clipping = (current_map == &maps[2] || current_map == &maps[4]);
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 52))
	jr	NZ, 01019$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 52))
	jr	Z, 00292$
01019$:
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 104))
	jr	NZ, 01020$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 104))
	jr	Z, 00292$
01020$:
	xor	a, a
	jr	00293$
00292$:
	ld	a, #0x01
00293$:
	ldhl	sp,	#9
	ld	(hl), a
;src/states/game.c:386: for (int i = 0; i < 4; i++) {
	ldhl	sp,	#14
	ld	(hl), #0x00
00282$:
	ldhl	sp,	#14
	ld	a, (hl)
	sub	a, #0x04
	jp	NC, 00162$
;src/states/game.c:387: uint16_t ty = sy + (i >= 2 ? 8 : 0);
	ld	a, (hl)
	sub	a, #0x02
	jr	C, 00294$
	dec	hl
	ld	(hl), #0x08
	jr	00295$
00294$:
	ldhl	sp,	#13
	ld	(hl), #0x00
00295$:
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#8
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#14
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#13
;src/states/game.c:389: move_sprite(i, sx + (i % 2 ? 8 : 0), ty);
	ld	(hl+), a
	ld	a, (hl)
	ldhl	sp,	#10
;src/states/game.c:388: if (!use_clipping || ty < 140) {
	ld	(hl-), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00158$
	ldhl	sp,	#12
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x8c
	ld	a, (hl)
	sbc	a, #0x00
	jr	NC, 00159$
00158$:
;src/states/game.c:389: move_sprite(i, sx + (i % 2 ? 8 : 0), ty);
	ldhl	sp,	#12
	ld	a, (hl-)
	ld	(hl), a
	ldhl	sp,	#6
	ld	a, (hl)
	ldhl	sp,	#12
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	and	a, #0x01
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00296$
	ld	(hl), #0x08
	jr	00297$
00296$:
	ldhl	sp,	#13
	ld	(hl), #0x00
00297$:
	ldhl	sp,	#13
	ld	a, (hl-)
	ld	c, (hl)
	dec	hl
	dec	hl
	add	a, c
	ld	c, a
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, (hl)
	xor	a, a
	ld	h, a
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;./gbdk/include/gb/gb.h:1974: itm->y=y, itm->x=x;
	push	hl
	ldhl	sp,	#13
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	ld	(hl), c
;src/states/game.c:389: move_sprite(i, sx + (i % 2 ? 8 : 0), ty);
	jr	00283$
00159$:
;src/states/game.c:391: move_sprite(i, 0, 0);
	ldhl	sp,	#10
	ld	e, (hl)
;./gbdk/include/gb/gb.h:1973: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
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
;src/states/game.c:391: move_sprite(i, 0, 0);
00283$:
;src/states/game.c:386: for (int i = 0; i < 4; i++) {
	ldhl	sp,	#14
	inc	(hl)
	jp	00282$
00162$:
;src/states/game.c:396: entity_update_all(current_map->entities, current_map->num_entities);
	ld	a, (#_current_map)
	ldhl	sp,	#10
	ld	(hl), a
	ld	a, (#_current_map + 1)
	ldhl	sp,	#11
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	dec	hl
	ld	d, a
	ld	a, (de)
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_entity_update_all
;src/states/game.c:399: projectile_update_all();
	call	_projectile_update_all
;src/states/game.c:400: projectile_render_all(camera_x, camera_y);
	ld	a, (_camera_y)
	ld	c, a
	ld	hl, #_camera_y + 1
	ld	b, (hl)
	ld	a, (_camera_x)
	ld	e, a
	ld	hl, #_camera_x + 1
	ld	d, (hl)
	call	_projectile_render_all
;src/states/game.c:403: if (projectile_check_collision(player_x + 8, player_y + 8)) {
	ld	a, (#_player_y)
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, (#_player_x)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_projectile_check_collision
	or	a, a
	jr	Z, 00345$
;src/states/game.c:404: player_hit();
	call	_player_hit
;src/states/game.c:405: return;
	jp	00289$
;src/states/game.c:409: for (int i = 0; i < current_map->num_entities; i++) {
00345$:
	xor	a, a
	ldhl	sp,	#9
	ld	(hl+), a
	ld	(hl), a
00285$:
;src/states/game.c:396: entity_update_all(current_map->entities, current_map->num_entities);
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
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
;src/states/game.c:409: for (int i = 0; i < current_map->num_entities; i++) {
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (hl)
	ldhl	sp,	#11
	ld	(hl+), a
	ld	(hl), #0x00
;src/states/game.c:396: entity_update_all(current_map->entities, current_map->num_entities);
	ldhl	sp,#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
;src/states/game.c:410: entity_t *e = &current_map->entities[i];
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
;src/states/game.c:409: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#9
	ld	e, l
	ld	d, h
	ldhl	sp,	#11
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 01021$
	bit	7, d
	jr	NZ, 01022$
	cp	a, a
	jr	01022$
01021$:
	bit	7, d
	jr	Z, 01022$
	scf
01022$:
	jp	NC, 00175$
;src/states/game.c:410: entity_t *e = &current_map->entities[i];
	ldhl	sp,	#9
	ld	a, (hl+)
	inc	hl
	ld	(hl-), a
	ld	a, (hl+)
	inc	hl
	ld	(hl), a
	ld	a, #0x04
01023$:
	ldhl	sp,	#11
	sla	(hl)
	inc	hl
	rl	(hl)
	dec	a
	jr	NZ, 01023$
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
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
;src/states/game.c:411: if (e->active && e->type == ENT_ENEMY) {
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	Z, 00286$
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x03
	jp	NZ, 00286$
;src/states/game.c:412: int16_t dx = (int16_t)player_x - (int16_t)e->x;
	ld	a, (#_player_x)
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#6
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#13
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#13
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
	ld	(hl), e
;src/states/game.c:413: int16_t dy = (int16_t)player_y - (int16_t)e->y;
	ld	a, (#_player_y)
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#6
	ld	(hl+), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0002
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#14
	ld	(hl-), a
;src/states/game.c:414: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00166$
;src/states/game.c:415: dx = -dx;
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
00166$:
;src/states/game.c:416: if (dy < 0)
	ldhl	sp,	#13
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00168$
;src/states/game.c:417: dy = -dy;
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	(hl), e
00168$:
;src/states/game.c:418: if (dx < 10 && dy < 10) {
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x0a
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00286$
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x0a
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00286$
;src/states/game.c:419: player_hit();
	call	_player_hit
;src/states/game.c:420: return;
	jp	00289$
00286$:
;src/states/game.c:409: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#9
	inc	(hl)
	jp	NZ, 00285$
	inc	hl
	inc	(hl)
	jp	00285$
00175$:
;src/states/game.c:425: entity_render_all(current_map->entities, current_map->num_entities, camera_x,
	ld	a, #0x04
	push	af
	inc	sp
	ld	a, (_camera_y)
	ld	e, a
	ld	hl, #_camera_y + 1
	ld	d, (hl)
	push	de
	ld	a, (_camera_x)
	ld	e, a
	ld	hl, #_camera_x + 1
	ld	d, (hl)
	push	de
	ldhl	sp,	#13
	ld	a, (hl)
	ldhl	sp,	#18
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	call	_entity_render_all
;src/states/game.c:428: if (input_pressed(J_A | J_B)) {
	ld	a, #0x30
	call	_input_pressed
	or	a, a
	jp	Z, 00225$
;src/states/game.c:429: uint8_t interacted = 0;
	ldhl	sp,	#0
	ld	(hl), #0x00
;src/states/game.c:430: for (int i = 0; i < current_map->num_entities; i++) {
	xor	a, a
	ldhl	sp,	#9
	ld	(hl+), a
	ld	(hl), a
00288$:
;src/states/game.c:396: entity_update_all(current_map->entities, current_map->num_entities);
	ld	a, (#_current_map)
	ldhl	sp,	#13
	ld	(hl), a
	ld	a, (#_current_map + 1)
	ldhl	sp,	#14
;src/states/game.c:430: for (int i = 0; i < current_map->num_entities; i++) {
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
;src/states/game.c:457: if (e->dialogue && strcmp(e->dialogue, "ARMA") == 0) {
;src/states/game.c:430: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#9
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 01027$
	bit	7, d
	jr	NZ, 01028$
	cp	a, a
	jr	01028$
01027$:
	bit	7, d
	jr	Z, 01028$
	scf
01028$:
	jp	NC, 00204$
;src/states/game.c:431: entity_t *e = &current_map->entities[i];
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, (hl)
	add	a, a
	rl	e
	add	a, a
	rl	e
	add	a, a
	rl	e
	add	a, a
	rl	e
	ld	l, a
	ld	h, e
	add	hl, bc
	push	hl
	ld	a, l
	ldhl	sp,	#3
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#2
;src/states/game.c:432: if (!e->active)
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
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
	ldhl	sp,	#14
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jp	Z, 00203$
;src/states/game.c:435: int16_t dx = (int16_t)player_x - (int16_t)e->x,
	ld	a, (#_player_x)
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#8
	ld	(hl), a
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ldhl	sp,	#13
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#13
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
	ld	(hl), e
;src/states/game.c:436: dy = (int16_t)player_y - (int16_t)e->y;
	ld	a, (#_player_y)
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#6
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#13
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#7
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl-), a
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl+)
	ld	d, a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#14
	ld	(hl-), a
;src/states/game.c:437: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00179$
;src/states/game.c:438: dx = -dx;
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
00179$:
;src/states/game.c:439: if (dy < 0)
	ldhl	sp,	#13
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00181$
;src/states/game.c:440: dy = -dy;
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	(hl), e
00181$:
;src/states/game.c:442: if (dx < 28 && dy < 28) {
	ldhl	sp,	#11
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x1c
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jp	NC, 00203$
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x1c
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jp	NC, 00203$
;src/states/game.c:443: if (input_pressed(J_A)) {
	ld	a, #0x10
	call	_input_pressed
	ld	c, a
;src/states/game.c:444: if (e->type == ENT_NPC) {
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#9
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#8
	ld	(hl), a
;src/states/game.c:446: if (e->sprite_base == 36 && inventory_has_item("FLOR")) {
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#13
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#12
	ld	(hl), a
;src/states/game.c:449: text_dialogue(e->dialogue);
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
;src/states/game.c:443: if (input_pressed(J_A)) {
	ld	a, c
	or	a, a
	jr	Z, 00189$
;src/states/game.c:444: if (e->type == ENT_NPC) {
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00189$
;src/states/game.c:445: interacted = 1;
	ldhl	sp,	#0
	ld	(hl), #0x01
;src/states/game.c:446: if (e->sprite_base == 36 && inventory_has_item("FLOR")) {
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	sub	a, #0x24
	jr	NZ, 00183$
	ld	de, #___str_1
	call	_inventory_has_item
	or	a, a
	jr	Z, 00183$
;src/states/game.c:447: text_dialogue(DIALOGUE_FLOWER_THANKS);
	ld	de, #___str_2
	call	_text_dialogue
	jr	00189$
00183$:
;src/states/game.c:449: text_dialogue(e->dialogue);
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	inc	de
	ld	a, (de)
	ld	e, c
	ld	d, a
	call	_text_dialogue
00189$:
;src/states/game.c:453: if (input_pressed(J_B)) {
	ld	a, #0x20
	call	_input_pressed
	or	a, a
	jr	Z, 00203$
;src/states/game.c:454: if (e->type == ENT_ITEM) {
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl)
	dec	a
	jr	NZ, 00203$
;src/states/game.c:455: interacted = 1;
	ldhl	sp,	#0
	ld	(hl), #0x01
;src/states/game.c:456: if (e->sprite_base == 41) {
	ldhl	sp,#11
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl)
	sub	a, #0x29
	jr	NZ, 00203$
;src/states/game.c:457: if (e->dialogue && strcmp(e->dialogue, "ARMA") == 0) {
	ldhl	sp,#13
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	ld	a, (de)
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00191$
	ld	de, #___str_3
	push	de
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	_strcmp
	add	sp, #4
	ldhl	sp,	#13
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
	ldhl	sp,	#14
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00191$
;src/states/game.c:458: inventory_add_item("ARMA", "Un arma cargada", 41);
	ld	a, #0x29
	push	af
	inc	sp
	ld	bc, #___str_4
	ld	de, #___str_3
	call	_inventory_add_item
;src/states/game.c:459: player_ammo = 10;
	ld	hl, #_player_ammo
	ld	(hl), #0x0a
	jr	00192$
00191$:
;src/states/game.c:461: inventory_add_item("FLOR", "Una hermosa\nflor silvestre", 41);
	ld	bc, #___str_5
	ld	a, #0x29
	push	af
	inc	sp
	ld	de, #___str_1
	call	_inventory_add_item
00192$:
;src/states/game.c:463: hud_update();
	call	_hud_update
;src/states/game.c:464: sfx_pickup();
	call	_sfx_pickup
;src/states/game.c:465: e->active = 0;
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x00
00203$:
;src/states/game.c:430: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#9
	inc	(hl)
	jp	NZ, 00288$
	inc	hl
	inc	(hl)
	jp	00288$
00204$:
;src/states/game.c:472: if (!interacted && input_pressed(J_B)) {
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
	jp	NZ, 00220$
	ld	a, #0x20
	call	_input_pressed
	or	a, a
	jp	Z, 00220$
;src/states/game.c:473: if (inventory_has_item("ARMA") && player_ammo > 0) {
	ld	de, #___str_3
	call	_inventory_has_item
	or	a, a
	jp	Z, 00220$
	ld	a, (#_player_ammo)
	or	a, a
	jp	Z, 00220$
;src/states/game.c:474: int8_t vx = 0, vy = 0;
	ldhl	sp,	#9
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/states/game.c:475: if (player_dir == 0)
	ld	a, (#_player_dir)
	or	a, a
	jr	NZ, 00214$
;src/states/game.c:476: vy = 2; // DOWN
	ldhl	sp,	#10
	ld	(hl), #0x02
	jr	00215$
00214$:
;src/states/game.c:477: else if (player_dir == 1)
	ld	a, (#_player_dir)
	dec	a
	jr	NZ, 00211$
;src/states/game.c:478: vy = -2; // UP
	ldhl	sp,	#10
	ld	(hl), #0xfe
	jr	00215$
00211$:
;src/states/game.c:479: else if (player_dir == 2)
	ld	a, (#_player_dir)
	sub	a, #0x02
	jr	NZ, 00208$
;src/states/game.c:480: vx = -2; // LEFT
	ldhl	sp,	#9
	ld	(hl), #0xfe
	jr	00215$
00208$:
;src/states/game.c:481: else if (player_dir == 3)
	ld	a, (#_player_dir)
	sub	a, #0x03
	jr	NZ, 00215$
;src/states/game.c:482: vx = 2; // RIGHT
	ldhl	sp,	#9
	ld	(hl), #0x02
00215$:
;src/states/game.c:484: projectile_spawn(player_x + 4, player_y + 4, vx, vy, 1);
	ld	a, (#_player_y)
	ldhl	sp,	#11
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#12
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl-), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#14
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, (#_player_x)
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#8
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#15
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#14
	ld	(hl), a
	ld	a, #0x01
	push	af
	inc	sp
	ldhl	sp,	#11
	ld	a, (hl-)
	ld	d, a
	ld	a, (hl+)
	inc	hl
	ld	e, a
	push	de
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl+)
	ld	b, a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_projectile_spawn
;src/states/game.c:485: player_ammo--;
	ld	hl, #_player_ammo
	dec	(hl)
;src/states/game.c:486: sfx_pickup(); // Reuse pickup sound as temporary fire sound
	call	_sfx_pickup
;src/states/game.c:487: hud_update();
	call	_hud_update
;src/states/game.c:488: interacted = 1;
	ldhl	sp,	#0
	ld	(hl), #0x01
00220$:
;src/states/game.c:492: if (interacted)
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
;src/states/game.c:493: return;
	jp	NZ, 00289$
00225$:
;src/states/game.c:497: uint16_t ix = player_x + 8;
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	c, (hl)
	add	a, #0x08
	ld	b, a
	ld	a, c
	adc	a, #0x00
	ldhl	sp,	#13
	ld	(hl), b
	inc	hl
	ld	(hl), a
;src/states/game.c:498: uint16_t iy = player_y + 8;
	ld	a, (_player_y)
	ld	hl, #_player_y + 1
	ld	b, (hl)
	add	a, #0x08
	ld	c, a
	jr	NC, 01043$
	inc	b
01043$:
;src/states/game.c:500: iy += 8;
	ld	e, c
	ld	d, b
;src/states/game.c:499: if (player_dir == 0) // DOWN
	ld	a, (#_player_dir)
	or	a, a
	jr	NZ, 00235$
;src/states/game.c:500: iy += 8;
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	jr	00236$
00235$:
;src/states/game.c:501: else if (player_dir == 1) // UP
	ld	a, (#_player_dir)
	dec	a
	jr	NZ, 00232$
;src/states/game.c:502: iy -= 8;
	ld	a, e
	add	a, #0xf8
	ld	c, a
	ld	a, d
	adc	a, #0xff
	ld	b, a
	jr	00236$
00232$:
;src/states/game.c:504: ix -= 8;
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/states/game.c:503: else if (player_dir == 2) // LEFT
	ld	a, (#_player_dir)
	sub	a, #0x02
	jr	NZ, 00229$
;src/states/game.c:504: ix -= 8;
	ld	a, e
	add	a, #0xf8
	ld	e, a
	ld	a, d
	adc	a, #0xff
	ldhl	sp,	#13
	ld	(hl), e
	inc	hl
	ld	(hl), a
	jr	00236$
00229$:
;src/states/game.c:505: else if (player_dir == 3) // RIGHT
	ld	a, (#_player_dir)
	sub	a, #0x03
	jr	NZ, 00236$
;src/states/game.c:506: ix += 8;
	ld	hl, #0x0008
	add	hl, de
	ld	e, l
	ld	a, h
	ldhl	sp,	#13
	ld	(hl), e
	inc	hl
	ld	(hl), a
00236$:
;src/states/game.c:508: uint8_t tid = get_tile_at(ix, iy);
	ldhl	sp,	#13
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_get_tile_at
	ldhl	sp,	#9
	ld	(hl), a
;src/states/game.c:511: if (current_map == &maps[0]) { // WORLD_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_maps)
	jr	NZ, 00248$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_maps)
	jr	NZ, 00248$
;src/states/game.c:512: if (tid >= 6 && tid <= 24) {
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x06
	jr	C, 00248$
	ld	a, #0x18
	sub	a, (hl)
	jr	C, 00248$
;src/states/game.c:514: if (!((tid == 21 || tid == 22) && player_x > 160 && player_y > 160)) {
	ld	a, (hl)
	sub	a, #0x15
	jr	Z, 00242$
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x16
	jr	NZ, 00239$
00242$:
	ld	a, (_player_x)
	ld	c, a
	ld	hl, #_player_x + 1
	ld	b, (hl)
	ld	a, #0xa0
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	NC, 00239$
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
	ld	a, #0xa0
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	C, 00248$
00239$:
;src/states/game.c:515: if (input_pressed(J_A)) {
	ld	a, #0x10
	call	_input_pressed
	or	a, a
	jr	Z, 00248$
;src/states/game.c:516: text_dialogue(DIALOGUE_HOUSE_CLOSED);
	ld	de, #___str_6
	call	_text_dialogue
;src/states/game.c:517: return;
	jp	00289$
00248$:
;src/states/game.c:523: if (current_map == &maps[1] && // HOUSE_MAP
;src/states/game.c:524: (tid == 31 || tid == 32 || tid == 33 || tid == 34)) {
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x1f
	ld	a, #0x01
	jr	Z, 01056$
	xor	a, a
01056$:
	ldhl	sp,	#10
	ld	(hl-), a
	ld	a, (hl)
	sub	a, #0x20
	ld	a, #0x01
	jr	Z, 01058$
	xor	a, a
01058$:
	ldhl	sp,	#11
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	sub	a, #0x21
	ld	a, #0x01
	jr	Z, 01060$
	xor	a, a
01060$:
	ldhl	sp,	#12
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x22
	ld	a, #0x01
	jr	Z, 01062$
	xor	a, a
01062$:
	ldhl	sp,	#13
	ld	(hl), a
;src/states/game.c:523: if (current_map == &maps[1] && // HOUSE_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 26))
	jr	NZ, 00255$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 26))
	jr	NZ, 00255$
;src/states/game.c:524: (tid == 31 || tid == 32 || tid == 33 || tid == 34)) {
	ldhl	sp,	#10
	ld	a, (hl)
	or	a, a
	jr	NZ, 00254$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00254$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00254$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00255$
00254$:
;src/states/game.c:525: if (input_pressed(J_B)) {
	ld	a, #0x20
	call	_input_pressed
	ldhl	sp,#14
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00255$
;src/states/game.c:526: if (!inventory_has_item("LLAVE")) {
	ld	de, #___str_7
	call	_inventory_has_item
	ldhl	sp,#14
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00250$
;src/states/game.c:527: text_dialogue(DIALOGUE_FOUND_KEY);
	ld	de, #___str_8
	call	_text_dialogue
;src/states/game.c:528: inventory_add_item("LLAVE", "Abre el porton norte", 41);
	ld	a, #0x29
	push	af
	inc	sp
	ld	bc, #___str_9
	ld	de, #___str_7
	call	_inventory_add_item
;src/states/game.c:529: sfx_pickup();
	call	_sfx_pickup
	jr	00255$
00250$:
;src/states/game.c:531: text_dialogue(DIALOGUE_EMPTY_CHEST);
	ld	de, #___str_10
	call	_text_dialogue
00255$:
;src/states/game.c:535: if (current_map == &maps[5] && // SANCTUARY_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 130))
	jr	NZ, 00263$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 130))
	jr	NZ, 00263$
;src/states/game.c:536: (tid == 31 || tid == 32 || tid == 33 || tid == 34)) {
	ldhl	sp,	#10
	ld	a, (hl)
	or	a, a
	jr	NZ, 00262$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00262$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00262$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00263$
00262$:
;src/states/game.c:537: if (input_pressed(J_A)) {
	ld	a, #0x10
	call	_input_pressed
	or	a, a
	jr	Z, 00263$
;src/states/game.c:538: text_dialogue("HAS COMPLETADO\nTU MISION...");
	ld	de, #___str_11
	call	_text_dialogue
;src/states/game.c:539: text_dialogue("VOLVIENDO AL\n PRINCIPIO");
	ld	de, #___str_12
	call	_text_dialogue
;src/states/game.c:540: game_init(); // Reset to World Map
	call	_game_init
;src/states/game.c:541: return;
	jr	00289$
00263$:
;src/states/game.c:545: if (current_map == &maps[0] && (tid >= 41 && tid <= 44)) { // WORLD_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_maps)
	jr	NZ, 00274$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_maps)
	jr	NZ, 00274$
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x29
	jr	C, 00274$
	ld	a, #0x2c
	sub	a, (hl)
	jr	C, 00274$
;src/states/game.c:546: if (input_pressed(J_A)) { // Assuming interaction with gate is J_A
	ld	a, #0x10
	call	_input_pressed
	or	a, a
	jr	Z, 00274$
;src/states/game.c:547: if (inventory_has_item("LLAVE")) {
	ld	de, #___str_7
	call	_inventory_has_item
	or	a, a
	jr	Z, 00269$
;src/states/game.c:548: text_dialogue(DIALOGUE_USE_KEY);
	ld	de, #___str_13
	call	_text_dialogue
;src/states/game.c:549: sfx_success();
	call	_sfx_success
;src/states/game.c:550: switch_map(&maps[2], 128, 224); // LEVEL2_MAP
	ld	de, #0x00e0
	push	de
	ld	bc, #0x0080
	ld	de, #(_maps + 52)
	call	_switch_map
;src/states/game.c:551: return;
	jr	00289$
00269$:
;src/states/game.c:553: text_dialogue(DIALOGUE_LOCKED_GATE);
	ld	de, #___str_14
	call	_text_dialogue
00274$:
;src/states/game.c:558: if ((env_anim_timer % 32) == 0) {
	ld	a, (_env_anim_timer)
	and	a, #0x1f
	jr	NZ, 00278$
;src/states/game.c:559: env_anim_frame = !env_anim_frame;
	ld	hl, #_env_anim_frame
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/states/game.c:563: set_bkg_data(2, 1, env_anim_frame ? &tiles_anim_data[0] : &tiles_data[32]);
	ld	a, (hl)
	or	a, a
	jr	Z, 00298$
	ld	bc, #_tiles_anim_data+0
	jr	00299$
00298$:
	ld	bc, #_tiles_data+32
00299$:
	push	bc
	ld	hl, #0x102
	push	hl
	call	_set_bkg_data
	add	sp, #4
00278$:
;src/states/game.c:565: hud_update();
	call	_hud_update
;src/states/game.c:566: env_anim_timer++;
	ld	hl, #_env_anim_timer
	inc	(hl)
00289$:
;src/states/game.c:567: }
	add	sp, #15
	ret
___str_1:
	.ascii "FLOR"
	.db 0x00
___str_2:
	.ascii "Gracias! Esta flor"
	.db 0x0a
	.ascii "me recuerda a mi"
	.db 0x0a
	.ascii "hogar."
	.db 0x0a
	.ascii "Te dire lo que se."
	.db 0x0a
	.ascii "Busca la cueva al"
	.db 0x0a
	.ascii "este del rio."
	.db 0x0a
	.ascii "Alli encontraras"
	.db 0x0a
	.ascii "lo que buscas."
	.db 0x0a
	.ascii "Sigue el camino"
	.db 0x0a
	.ascii "de piedras y no"
	.db 0x0a
	.ascii "te pierdas."
	.db 0x00
___str_3:
	.ascii "ARMA"
	.db 0x00
___str_4:
	.ascii "Un arma cargada"
	.db 0x00
___str_5:
	.ascii "Una hermosa"
	.db 0x0a
	.ascii "flor silvestre"
	.db 0x00
___str_6:
	.ascii "Esta casa esta"
	.db 0x0a
	.ascii "cerrada."
	.db 0x00
___str_7:
	.ascii "LLAVE"
	.db 0x00
___str_8:
	.ascii "Increible!"
	.db 0x0a
	.ascii "Has encontrado la"
	.db 0x0a
	.ascii "llave del porton!"
	.db 0x0a
	.ascii "Esta llave abre"
	.db 0x0a
	.ascii "la puerta que"
	.db 0x0a
	.ascii "lleva al bosque."
	.db 0x0a
	.ascii "Ahora podras"
	.db 0x0a
	.ascii "continuar tu"
	.db 0x0a
	.ascii "aventura!"
	.db 0x00
___str_9:
	.ascii "Abre el porton norte"
	.db 0x00
___str_10:
	.ascii "Abres el ropero"
	.db 0x0a
	.ascii "con cuidado..."
	.db 0x0a
	.ascii "Pero esta"
	.db 0x0a
	.ascii "completamente"
	.db 0x0a
	.ascii "vacio."
	.db 0x0a
	.ascii "Alguien ya tomo"
	.db 0x0a
	.ascii "lo que habia"
	.db 0x0a
	.ascii "aqui."
	.db 0x00
___str_11:
	.ascii "HAS COMPLETADO"
	.db 0x0a
	.ascii "TU MISION..."
	.db 0x00
___str_12:
	.ascii "VOLVIENDO AL"
	.db 0x0a
	.ascii " PRINCIPIO"
	.db 0x00
___str_13:
	.ascii "Insertas la llave"
	.db 0x0a
	.ascii "en la cerradura"
	.db 0x0a
	.ascii "del porton..."
	.db 0x0a
	.ascii "Giras la llave"
	.db 0x0a
	.ascii "y escuchas un"
	.db 0x0a
	.ascii "clic!"
	.db 0x0a
	.ascii "El porton se abre"
	.db 0x0a
	.ascii "lentamente con un"
	.db 0x0a
	.ascii "chirrido."
	.db 0x0a
	.ascii "El camino esta"
	.db 0x0a
	.ascii "libre!"
	.db 0x00
___str_14:
	.ascii "El porton esta"
	.db 0x0a
	.ascii "firmemente"
	.db 0x0a
	.ascii "cerrado."
	.db 0x0a
	.ascii "Necesitas una"
	.db 0x0a
	.ascii "llave para poder"
	.db 0x0a
	.ascii "abrirlo."
	.db 0x0a
	.ascii "Quizas alguien"
	.db 0x0a
	.ascii "cerca sepa donde"
	.db 0x0a
	.ascii "encontrarla."
	.db 0x00
;src/states/game.c:569: void game_reset(void) {
;	---------------------------------
; Function game_reset
; ---------------------------------
_game_reset::
;src/states/game.c:570: player_x = 128;
	ld	hl, #_player_x
	ld	a, #0x80
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:571: player_y = 128;
	ld	hl, #_player_y
	ld	a, #0x80
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:572: enter_x = 128;
	ld	hl, #_enter_x
	ld	a, #0x80
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:573: enter_y = 128;
	ld	hl, #_enter_y
	ld	a, #0x80
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:574: player_lives = 3;
	ld	hl, #_player_lives
	ld	(hl), #0x03
;src/states/game.c:575: inventory_init();
	call	_inventory_init
;src/states/game.c:576: projectile_init();
	call	_projectile_init
;src/states/game.c:577: game_ready = 0;
	xor	a, a
	ld	(#_game_ready),a
;src/states/game.c:578: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__player_x:
	.dw #0x0080
__xinit__player_y:
	.dw #0x0080
__xinit__enter_x:
	.dw #0x0080
__xinit__enter_y:
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
__xinit__level2_door_x:
	.dw #0x0000
__xinit__level2_door_y:
	.dw #0x0000
__xinit__env_anim_timer:
	.db #0x00	; 0
__xinit__env_anim_frame:
	.db #0x00	; 0
__xinit__player_lives:
	.db #0x03	; 3
__xinit__player_ammo:
	.db #0x00	; 0
__xinit__game_ready:
	.db #0x00	; 0
	.area _CABS (ABS)
