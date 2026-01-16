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
	.globl _get_tile_for_char
	.globl _text_dialogue
	.globl _text_init
	.globl _projectile_check_collision
	.globl _projectile_render_all
	.globl _projectile_update_all
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
;src/states/game.c:46: uint8_t get_tile_at(uint16_t x, uint16_t y) {
;	---------------------------------
; Function get_tile_at
; ---------------------------------
_get_tile_at::
	add	sp, #-6
;src/states/game.c:47: uint16_t tx = x / 8, ty = y / 8;
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
;src/states/game.c:48: if (tx >= current_map->w || ty >= current_map->h)
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
;src/states/game.c:49: return 0;
	xor	a, a
	jr	00104$
00102$:
;src/states/game.c:50: return current_map->tiles[ty * current_map->w + tx];
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
;src/states/game.c:51: }
	add	sp, #6
	ret
;src/states/game.c:53: void update_camera(void) {
;	---------------------------------
; Function update_camera
; ---------------------------------
_update_camera::
	add	sp, #-4
;src/states/game.c:54: uint16_t w = current_map->w * 8, h = current_map->h * 8;
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
;src/states/game.c:55: if (player_x > SCREEN_WIDTH / 2)
	ld	hl, #_player_x
	ld	a, #0x50
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00102$
;src/states/game.c:56: camera_x = player_x - SCREEN_WIDTH / 2;
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
;src/states/game.c:58: camera_x = 0;
	xor	a, a
	ld	hl, #_camera_x
	ld	(hl+), a
	ld	(hl), a
00103$:
;src/states/game.c:59: if (player_y > SCREEN_HEIGHT / 2)
	ld	hl, #_player_y
	ld	a, #0x48
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00105$
;src/states/game.c:60: camera_y = player_y - SCREEN_HEIGHT / 2;
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
;src/states/game.c:62: camera_y = 0;
	xor	a, a
	ld	hl, #_camera_y
	ld	(hl+), a
	ld	(hl), a
00106$:
;src/states/game.c:63: if (camera_x > w - SCREEN_WIDTH)
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
;src/states/game.c:64: camera_x = (w > SCREEN_WIDTH) ? (w - SCREEN_WIDTH) : 0;
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
;src/states/game.c:65: if (camera_y > h - SCREEN_HEIGHT)
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
;src/states/game.c:66: camera_y = (h > SCREEN_HEIGHT) ? (h - SCREEN_HEIGHT) : 0;
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
;src/states/game.c:70: void hud_update(void) {
;	---------------------------------
; Function hud_update
; ---------------------------------
_hud_update::
	add	sp, #-20
;src/states/game.c:72: for (int i = 0; i < 20; i++)
	ld	c, #0x00
00104$:
	ld	a, c
	sub	a, #0x14
	jr	NC, 00101$
;src/states/game.c:73: hud_tiles[i] = get_tile_for_char(' ');
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
;src/states/game.c:72: for (int i = 0; i < 20; i++)
	inc	c
	jr	00104$
00101$:
;src/states/game.c:75: hud_tiles[1] = get_tile_for_char('V');
	ld	a, #0x56
	call	_get_tile_for_char
	ldhl	sp,	#1
	ld	(hl), a
;src/states/game.c:76: hud_tiles[2] = get_tile_for_char('i');
	ld	a, #0x69
	call	_get_tile_for_char
	ldhl	sp,	#2
	ld	(hl), a
;src/states/game.c:77: hud_tiles[3] = get_tile_for_char('d');
	ld	a, #0x64
	call	_get_tile_for_char
	ldhl	sp,	#3
	ld	(hl), a
;src/states/game.c:78: hud_tiles[4] = get_tile_for_char('a');
	ld	a, #0x61
	call	_get_tile_for_char
	ldhl	sp,	#4
	ld	(hl), a
;src/states/game.c:79: hud_tiles[5] = get_tile_for_char('s');
	ld	a, #0x73
	call	_get_tile_for_char
	ldhl	sp,	#5
	ld	(hl), a
;src/states/game.c:80: hud_tiles[6] = get_tile_for_char(':');
	ld	a, #0x3a
	call	_get_tile_for_char
	ldhl	sp,	#6
	ld	(hl), a
;src/states/game.c:81: hud_tiles[8] = get_tile_for_char('0' + player_lives);
	ld	a, (_player_lives)
	add	a, #0x30
	call	_get_tile_for_char
	ldhl	sp,	#8
	ld	(hl), a
;src/states/game.c:83: set_win_tiles(0, 0, 20, 1, hud_tiles);
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
;src/states/game.c:85: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:86: }
	add	sp, #20
	ret
;src/states/game.c:88: void update_player_sprite(void) {
;	---------------------------------
; Function update_player_sprite
; ---------------------------------
_update_player_sprite::
	dec	sp
;src/states/game.c:89: uint8_t base =
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
;src/states/game.c:93: uint8_t prop = (player_dir == 3) ? S_FLIPX : 0;
	ld	a, b
	or	a, a
	ld	e, #0x20
	jr	NZ, 00131$
	ld	e, #0x00
00131$:
;src/states/game.c:94: if (prop == 0) {
	ld	a, e
	or	a, a
	jr	NZ, 00104$
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), c
;src/states/game.c:96: set_sprite_tile(1, base + 1);
	ld	a, c
	inc	a
	ldhl	sp,	#0
	ld	(hl), a
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	de, #(_shadow_OAM + 6)
	ld	a, (hl)
	ld	(de), a
;src/states/game.c:97: set_sprite_tile(2, base + 2);
	ld	b, c
	inc	b
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), b
;src/states/game.c:98: set_sprite_tile(3, base + 3);
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), c
;src/states/game.c:99: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00117$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00122$
;src/states/game.c:100: set_sprite_prop(i, 0);
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
;src/states/game.c:99: for (int i = 0; i < 4; i++)
	inc	c
	jr	00117$
00104$:
;src/states/game.c:102: set_sprite_tile(0, base + 1);
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
;src/states/game.c:104: set_sprite_tile(2, base + 3);
	ld	c, b
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), c
;src/states/game.c:105: set_sprite_tile(3, base + 2);
	inc	b
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), b
;src/states/game.c:106: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00120$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00122$
;src/states/game.c:107: set_sprite_prop(i, S_FLIPX);
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
;src/states/game.c:106: for (int i = 0; i < 4; i++)
	inc	c
	jr	00120$
00122$:
;src/states/game.c:109: }
	inc	sp
	ret
;src/states/game.c:111: void load_map(map_t *m) {
;	---------------------------------
; Function load_map
; ---------------------------------
_load_map::
	add	sp, #-4
	ld	c, e
	ld	b, d
;src/states/game.c:112: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:113: current_map = m;
	ld	hl, #_current_map
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:114: for (int i = 4; i < 40; i++)
	ld	e, #0x04
00113$:
	ld	a, e
	sub	a, #0x28
	jr	NC, 00101$
;src/states/game.c:115: move_sprite(i, 0, 0); // Hide map sprites
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
;src/states/game.c:114: for (int i = 4; i < 40; i++)
	inc	e
	jr	00113$
00101$:
;src/states/game.c:117: if (m == &maps[1]) // HOUSE_MAP
	ld	a, #<((_maps + 26))
	sub	a, c
	jr	NZ, 00103$
	ld	a, #>((_maps + 26))
	sub	a, b
	jr	NZ, 00103$
;src/states/game.c:118: fill_bkg_rect(0, 0, 32, 32, 26);
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
;src/states/game.c:120: set_bkg_tiles(0, 0, m->w, m->h, m->tiles);
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
	push	hl
	ldhl	sp,	#5
	ld	(hl), a
	pop	hl
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (de)
	push	de
	push	hl
	ldhl	sp,	#7
	ld	h, (hl)
	push	hl
	inc	sp
	push	af
	inc	sp
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
	pop	de
;src/states/game.c:123: if (m == &maps[2]) {
	ld	a, #<((_maps + 52))
	sub	a, c
	jr	NZ, 00108$
	ld	a, #>((_maps + 52))
	sub	a, b
	jr	NZ, 00108$
;src/states/game.c:126: if (DIV_REG & 0x01) {
	ldh	a, (_DIV_REG + 0)
	rrca
	jr	NC, 00105$
;src/states/game.c:127: rx = 2; // Top-left
	ld	bc, #0x0002
	jr	00106$
00105$:
;src/states/game.c:129: rx = m->w - 4; // Top-right
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
;src/states/game.c:132: level2_door_x = rx * 8;
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
;src/states/game.c:133: level2_door_y = ry * 8;
	ld	hl, #_level2_door_y
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:136: set_bkg_tile_xy(rx, ry, 31);
	push	bc
	ld	a, #0x1f
	push	af
	inc	sp
	ld	e, #0x02
	ld	a, c
	call	_set_bkg_tile_xy
	pop	bc
;src/states/game.c:137: set_bkg_tile_xy(rx + 1, ry, 31);
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
;src/states/game.c:138: set_bkg_tile_xy(rx, ry + 1, 31);
	push	bc
	ld	a, #0x1f
	push	af
	inc	sp
	ld	e, #0x03
	ld	a, c
	call	_set_bkg_tile_xy
	pop	bc
;src/states/game.c:139: set_bkg_tile_xy(rx + 1, ry + 1, 31);
	ld	a, #0x1f
	push	af
	inc	sp
	ld	e, #0x03
	ld	a, b
	call	_set_bkg_tile_xy
00108$:
;src/states/game.c:142: update_camera();
	call	_update_camera
;src/states/game.c:145: uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
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
;src/states/game.c:146: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00116$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00109$
;src/states/game.c:147: move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));
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
;src/states/game.c:146: for (int i = 0; i < 4; i++)
	inc	c
	jr	00116$
00109$:
;src/states/game.c:149: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:150: }
	add	sp, #4
	ret
;src/states/game.c:152: void switch_map(map_t *new_map, uint16_t new_x, uint16_t new_y) {
;	---------------------------------
; Function switch_map
; ---------------------------------
_switch_map::
;src/states/game.c:153: fade_out();
	push	bc
	push	de
	call	_fade_out
	pop	de
	pop	bc
;src/states/game.c:154: player_x = new_x;
	ld	hl, #_player_x
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:155: player_y = new_y;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(#_player_y),a
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_player_y + 1),a
;src/states/game.c:156: enter_x = new_x; // Remember map entrance
	ld	hl, #_enter_x
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:157: enter_y = new_y;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(#_enter_y),a
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_enter_y + 1),a
;src/states/game.c:158: load_map(new_map);
	call	_load_map
;src/states/game.c:159: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:160: fade_in();
	call	_fade_in
;src/states/game.c:161: }
	pop	hl
	pop	af
	jp	(hl)
;src/states/game.c:163: uint8_t is_solid(uint16_t x, uint16_t y) { return map_is_solid(x, y); }
;	---------------------------------
; Function is_solid
; ---------------------------------
_is_solid::
	jp	_map_is_solid
;src/states/game.c:165: uint8_t can_move(uint16_t nx, uint16_t ny) {
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
;src/states/game.c:166: if (nx < 4 || ny < 4 || nx > (current_map->w * 8 - 12) ||
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
;src/states/game.c:167: ny > (current_map->h * 8 - 12))
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
;src/states/game.c:168: return 0;
	xor	a, a
	jp	00124$
00102$:
;src/states/game.c:170: if (is_solid(nx + 4, ny + 8) || is_solid(nx + 12, ny + 8) ||
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
;src/states/game.c:171: is_solid(nx + 4, ny + 15) || is_solid(nx + 12, ny + 15)) {
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
;src/states/game.c:172: return 0;
	xor	a, a
	jp	00124$
;src/states/game.c:175: for (int i = 0; i < current_map->num_entities; i++) {
00138$:
	xor	a, a
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), a
00123$:
;src/states/game.c:166: if (nx < 4 || ny < 4 || nx > (current_map->w * 8 - 12) ||
	ld	a, (_current_map)
	ld	c, a
	ld	hl, #_current_map + 1
	ld	b, (hl)
;src/states/game.c:175: for (int i = 0; i < current_map->num_entities; i++) {
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
;src/states/game.c:176: entity_t *e = &current_map->entities[i];
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
;src/states/game.c:177: if (!e->active)
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
;src/states/game.c:179: int16_t dx = (int16_t)nx - e->x, dy = (int16_t)ny - e->y;
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
;src/states/game.c:180: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00114$
;src/states/game.c:181: dx = -dx;
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
;src/states/game.c:182: if (dy < 0)
	ldhl	sp,	#12
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00116$
;src/states/game.c:183: dy = -dy;
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
;src/states/game.c:184: if (dx < 12 && dy < 12)
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
;src/states/game.c:185: return 0; // Collide if too close
	xor	a, a
	jr	00124$
00120$:
;src/states/game.c:175: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#8
	inc	(hl)
	jp	NZ, 00123$
	inc	hl
	inc	(hl)
	jp	00123$
00121$:
;src/states/game.c:187: return 1;
	ld	a, #0x01
00124$:
;src/states/game.c:188: }
	add	sp, #14
	ret
;src/states/game.c:194: void game_init(void) {
;	---------------------------------
; Function game_init
; ---------------------------------
_game_init::
;src/states/game.c:195: DISPLAY_OFF;
	call	_display_off
;src/states/game.c:196: set_bkg_data(0, 40, tiles_data); // All tiles (now 40)
	ld	de, #_tiles_data
	push	de
	ld	hl, #0x2800
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:198: if (game_ready) {
	ld	a, (#_game_ready)
	or	a, a
	jr	Z, 00102$
;src/states/game.c:199: map_init_data();
	call	_map_init_data
;src/states/game.c:200: load_map(current_map);
	ld	a, (_current_map)
	ld	e, a
	ld	hl, #_current_map + 1
	ld	d, (hl)
	call	_load_map
;src/states/game.c:201: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:202: BGP_REG = OBP0_REG = OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/states/game.c:203: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:204: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:205: return;
	ret
00102$:
;src/states/game.c:208: map_init_data();
	call	_map_init_data
;src/states/game.c:209: load_map(&maps[0]); // WORLD_MAP
	ld	de, #_maps
	call	_load_map
;src/states/game.c:211: BGP_REG = OBP0_REG = OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/states/game.c:212: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:213: set_sprite_data(0, 24, player_sprites);
	ld	de, #_player_sprites
	push	de
	ld	hl, #0x1800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:214: set_sprite_data(24, 4, npc_child_sprite);
	ld	de, #_npc_child_sprite
	push	de
	ld	hl, #0x418
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:215: set_sprite_data(28, 8, guard_sprite_data);
	ld	de, #_guard_sprite_data
	push	de
	ld	hl, #0x81c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:216: set_sprite_data(36, 4, npc_woman_sprite);
	ld	de, #_npc_woman_sprite
	push	de
	ld	hl, #0x424
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:217: set_sprite_data(40, 1, projectile_sprite);
	ld	de, #_projectile_sprite
	push	de
	ld	hl, #0x128
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:218: set_sprite_data(41, 2, flower_sprite);
	ld	de, #_flower_sprite
	push	de
	ld	hl, #0x229
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:219: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:220: text_init();
	call	_text_init
;src/states/game.c:221: music_init();
	call	_music_init
;src/states/game.c:222: projectile_init();
	call	_projectile_init
;src/states/game.c:223: enter_x = player_x;
	ld	a, (#_player_x)
	ld	(#_enter_x),a
	ld	a, (#_player_x + 1)
	ld	(#_enter_x + 1),a
;src/states/game.c:224: enter_y = player_y;
	ld	a, (#_player_y)
	ld	(#_enter_y),a
	ld	a, (#_player_y + 1)
	ld	(#_enter_y + 1),a
;src/states/game.c:225: hud_update();
	call	_hud_update
;./gbdk/include/gb/gb.h:1739: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x88
	ldh	(_WY_REG + 0), a
;src/states/game.c:227: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:228: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:229: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:230: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:231: game_ready = 1;
	ld	hl, #_game_ready
	ld	(hl), #0x01
;src/states/game.c:232: }
	ret
;src/states/game.c:234: void player_hit(void) {
;	---------------------------------
; Function player_hit
; ---------------------------------
_player_hit::
;src/states/game.c:235: if (player_lives > 0)
	ld	hl, #_player_lives
	ld	a, (hl)
	or	a, a
	jr	Z, 00102$
;src/states/game.c:236: player_lives--;
	dec	(hl)
00102$:
;src/states/game.c:238: fade_out();
	call	_fade_out
;src/states/game.c:239: delay(1000);
	ld	de, #0x03e8
	call	_delay
;src/states/game.c:241: if (player_lives == 0) {
	ld	a, (#_player_lives)
	or	a, a
	jr	NZ, 00104$
;src/states/game.c:242: game_state = STATE_GAMEOVER;
	ld	hl, #_game_state
	ld	(hl), #0x04
;src/states/game.c:243: return;
	ret
00104$:
;src/states/game.c:247: map_init_data();
	call	_map_init_data
;src/states/game.c:248: projectile_init();
	call	_projectile_init
;src/states/game.c:251: player_x = enter_x;
	ld	a, (#_enter_x)
	ld	(#_player_x),a
	ld	a, (#_enter_x + 1)
	ld	(#_player_x + 1),a
;src/states/game.c:252: player_y = enter_y;
	ld	a, (#_enter_y)
	ld	(#_player_y),a
	ld	a, (#_enter_y + 1)
	ld	(#_player_y + 1),a
;src/states/game.c:255: load_map(current_map);
	ld	a, (_current_map)
	ld	e, a
	ld	hl, #_current_map + 1
	ld	d, (hl)
	call	_load_map
;src/states/game.c:256: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:258: hud_update();
	call	_hud_update
;./gbdk/include/gb/gb.h:1739: WX_REG=x, WY_REG=y;
	ld	a, #0x07
	ldh	(_WX_REG + 0), a
	ld	a, #0x88
	ldh	(_WY_REG + 0), a
;src/states/game.c:260: SHOW_WIN;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x20
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:262: fade_in();
;src/states/game.c:263: }
	jp	_fade_in
;src/states/game.c:265: void game_update(void) {
;	---------------------------------
; Function game_update
; ---------------------------------
_game_update::
	add	sp, #-11
;src/states/game.c:266: music_update();
	call	_music_update
;src/states/game.c:267: uint8_t moved = 0;
	ld	c, #0x00
;src/states/game.c:268: uint16_t nx = player_x, ny = player_y;
	ld	a, (#_player_x)
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (#_player_y)
	ldhl	sp,	#9
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#10
	ld	(hl), a
;src/states/game.c:270: if (input_held(J_UP)) {
	push	bc
	ld	a, #0x04
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00110$
;src/states/game.c:271: ny--;
	ldhl	sp,#9
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:272: player_dir = 1;
	ld	hl, #_player_dir
	ld	(hl), #0x01
;src/states/game.c:273: moved = 1;
	ld	c, #0x01
	jr	00111$
00110$:
;src/states/game.c:274: } else if (input_held(J_DOWN)) {
	push	bc
	ld	a, #0x08
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00107$
;src/states/game.c:275: ny++;
	ldhl	sp,	#9
	inc	(hl)
	jr	NZ, 00786$
	inc	hl
	inc	(hl)
00786$:
;src/states/game.c:276: player_dir = 0;
	xor	a, a
	ld	(#_player_dir),a
;src/states/game.c:277: moved = 1;
	ld	c, #0x01
	jr	00111$
00107$:
;src/states/game.c:278: } else if (input_held(J_LEFT)) {
	push	bc
	ld	a, #0x02
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00104$
;src/states/game.c:279: nx--;
	ldhl	sp,#7
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:280: player_dir = 2;
	ld	hl, #_player_dir
	ld	(hl), #0x02
;src/states/game.c:281: moved = 1;
	ld	c, #0x01
	jr	00111$
00104$:
;src/states/game.c:282: } else if (input_held(J_RIGHT)) {
	push	bc
	ld	a, #0x01
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00111$
;src/states/game.c:283: nx++;
	ldhl	sp,	#7
	inc	(hl)
	jr	NZ, 00787$
	inc	hl
	inc	(hl)
00787$:
;src/states/game.c:284: player_dir = 3;
	ld	hl, #_player_dir
	ld	(hl), #0x03
;src/states/game.c:285: moved = 1;
	ld	c, #0x01
00111$:
;src/states/game.c:288: if (moved) {
	ld	a, c
	or	a, a
	jr	Z, 00148$
;src/states/game.c:289: if (can_move(nx, ny)) {
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#7
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_can_move
	or	a, a
	jp	Z, 00149$
;src/states/game.c:290: player_x = nx;
	ldhl	sp,	#7
	ld	a, (hl)
	ld	(#_player_x),a
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(#_player_x + 1),a
;src/states/game.c:291: player_y = ny;
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(#_player_y),a
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(#_player_y + 1),a
;src/states/game.c:292: update_camera();
	call	_update_camera
;src/states/game.c:294: if (++anim_timer > 6) {
	ld	hl, #_anim_timer
	inc	(hl)
	ld	a, #0x06
	sub	a, (hl)
	jp	NC, 00149$
;src/states/game.c:295: anim_frame = !anim_frame;
	ld	hl, #_anim_frame
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/states/game.c:296: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
;src/states/game.c:297: update_player_sprite();
	call	_update_player_sprite
	jp	00149$
00148$:
;src/states/game.c:301: if (anim_frame != 0) {
	ld	hl, #_anim_frame
	ld	a, (hl)
	or	a, a
	jr	Z, 00117$
;src/states/game.c:302: anim_frame = 0;
	ld	(hl), #0x00
;src/states/game.c:303: update_player_sprite();
	call	_update_player_sprite
00117$:
;src/states/game.c:305: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
;src/states/game.c:308: if (input_pressed(J_SELECT)) {
	ld	a, #0x40
	call	_input_pressed
	or	a, a
	jr	Z, 00119$
;src/states/game.c:309: game_state = 3; // STATE_INVENTORY
	ld	hl, #_game_state
	ld	(hl), #0x03
;src/states/game.c:310: return;
	jp	00244$
00119$:
;src/states/game.c:314: uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
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
	jr	NC, 00788$
	inc	d
00788$:
	call	_get_tile_at
	ldhl	sp,	#10
	ld	(hl), a
;src/states/game.c:315: if (current_map == &maps[0] && // WORLD_MAP
;src/states/game.c:314: uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
	ld	a, (_player_x)
	ld	e, a
	ld	hl, #_player_x + 1
	ld	d, (hl)
;src/states/game.c:320: switch_map(&maps[1], 76, 112); // HOUSE_MAP
;src/states/game.c:315: if (current_map == &maps[0] && // WORLD_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_maps)
	jr	NZ, 00124$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_maps)
	jr	NZ, 00124$
;src/states/game.c:316: (tid == 21 || tid == 22)) {
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x15
	jr	Z, 00123$
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x16
	jr	NZ, 00124$
00123$:
;src/states/game.c:317: if (player_x > 160 && player_y > 160) {
	ld	a, #0xa0
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	jr	NC, 00124$
	ld	a, #0xa0
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	NC, 00124$
;src/states/game.c:318: saved_world_x = player_x;
	ld	a, (#_player_x)
	ld	(#_saved_world_x),a
	ld	a, (#_player_x + 1)
	ld	(#_saved_world_x + 1),a
;src/states/game.c:319: saved_world_y = player_y + 16;
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	a, h
	ld	hl, #_saved_world_y
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/states/game.c:320: switch_map(&maps[1], 76, 112); // HOUSE_MAP
	ld	de, #0x0070
	push	de
	ld	bc, #0x004c
	ld	de, #(_maps + 26)
	call	_switch_map
;src/states/game.c:321: return;
	jp	00244$
00124$:
;src/states/game.c:324: tid = get_tile_at(player_x + 8, player_y + 12);
	ld	hl, #0x000c
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #0x0008
	add	hl, de
	ld	e, l
	ld	d, h
	call	_get_tile_at
	ldhl	sp,	#3
	ld	(hl), a
;src/states/game.c:325: if (current_map == &maps[1] && tid == 35) { // HOUSE_MAP
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
;src/states/game.c:326: uint16_t wx = saved_world_x;
	ld	a, (_saved_world_x)
	ld	hl, #_saved_world_x + 1
	ld	b, (hl)
;src/states/game.c:327: uint16_t wy = saved_world_y;
	ld	hl, #_saved_world_y
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
;src/states/game.c:328: switch_map(&maps[0], wx, wy); // WORLD_MAP
	push	de
	ld	c, a
	ld	de, #_maps
	call	_switch_map
;src/states/game.c:329: return;
	jp	00244$
00128$:
;src/states/game.c:331: if (current_map == &maps[2] && tid == 0 && player_y > 240) { // LEVEL2_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 52))
	jr	NZ, 00798$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 52))
	ld	a, #0x01
	jr	Z, 00799$
00798$:
	xor	a, a
00799$:
	ld	c, a
;src/states/game.c:314: uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
	ld	a, (_player_y)
	ld	e, a
	ld	hl, #_player_y + 1
	ld	d, (hl)
;src/states/game.c:331: if (current_map == &maps[2] && tid == 0 && player_y > 240) { // LEVEL2_MAP
	ld	a, #0xf0
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	ld	a, #0x00
	rla
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, c
	or	a, a
	jr	Z, 00131$
	dec	hl
	ld	a, (hl)
	or	a, a
	jr	NZ, 00131$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00131$
;src/states/game.c:332: switch_map(&maps[0], 124, 48);                             // WORLD_MAP
	ld	de, #0x0030
	push	de
	ld	bc, #0x007c
	ld	de, #_maps
	call	_switch_map
;src/states/game.c:333: return;
	jp	00244$
00131$:
;src/states/game.c:346: switch_map(&maps[3], 128, 224); // To Level 3 (on the path)
;src/states/game.c:337: if (current_map == &maps[2]) {
	ld	a, c
	or	a, a
	jp	Z, 00142$
;src/states/game.c:338: int16_t dx = (int16_t)player_x - (int16_t)level2_door_x;
	ld	a, (_player_x)
	ld	c, a
	ld	hl, #_player_x + 1
	ld	b, (hl)
	ld	a, (_level2_door_x)
	ld	e, a
	ld	hl, #_level2_door_x + 1
	ld	d, (hl)
	ld	a, c
	sub	a, e
	ld	c, a
	ld	a, b
	sbc	a, d
	ld	b, a
;src/states/game.c:339: int16_t dy = (int16_t)player_y - (int16_t)level2_door_y;
	ld	a, (#_player_y)
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, (#_level2_door_y)
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (#_level2_door_y + 1)
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
	ldhl	sp,	#10
	ld	(hl-), a
	ld	(hl), e
;src/states/game.c:340: if (dx < 0)
	ld	h, b
	bit	7, h
	jr	Z, 00135$
;src/states/game.c:341: dx = -dx;
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
00135$:
;src/states/game.c:342: if (dy < 0)
	ldhl	sp,	#9
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00137$
;src/states/game.c:343: dy = -dy;
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
	ldhl	sp,	#10
	ld	(hl-), a
	ld	(hl), e
00137$:
;src/states/game.c:345: if (dx < 16 && dy < 16) {
	ld	a, c
	sub	a, #0x10
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00142$
	ldhl	sp,	#9
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
;src/states/game.c:346: switch_map(&maps[3], 128, 224); // To Level 3 (on the path)
	ld	de, #0x00e0
	push	de
	ld	bc, #0x0080
	ld	de, #(_maps + 78)
	call	_switch_map
;src/states/game.c:347: return;
	jp	00244$
00142$:
;src/states/game.c:351: if (current_map == &maps[3] && tid == 0 && player_y > 240) { // LEVEL3_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 78))
	jr	NZ, 00149$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 78))
	jr	NZ, 00149$
	ldhl	sp,	#3
	ld	a, (hl)
	or	a, a
	jr	NZ, 00149$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00149$
;src/states/game.c:352: switch_map(&maps[2], 128, 224); // Return to Level 2 (entrance)
	ld	de, #0x00e0
	push	de
	ld	bc, #0x0080
	ld	de, #(_maps + 52)
	call	_switch_map
;src/states/game.c:353: return;
	jp	00244$
00149$:
;src/states/game.c:359: uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
	ld	a, (_player_x)
	ld	hl, #_camera_x
	ld	c, (hl)
	sub	a, c
	add	a, #0x08
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (_player_y)
	ld	hl, #_camera_y
	ld	c, (hl)
	sub	a, c
	add	a, #0x10
	ldhl	sp,	#6
	ld	(hl), a
;src/states/game.c:360: for (int i = 0; i < 4; i++)
	ldhl	sp,	#10
	ld	(hl), #0x00
00236$:
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00150$
;src/states/game.c:361: move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));
	ldhl	sp,	#6
	ld	c, (hl)
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x02
	jr	C, 00246$
	ld	a, #0x08
	jr	00247$
00246$:
	xor	a, a
00247$:
	add	a, c
	ldhl	sp,	#7
	ld	(hl-), a
	dec	hl
	ld	a, (hl)
	ldhl	sp,	#8
	ld	(hl+), a
	inc	hl
	ld	a, (hl-)
	ld	(hl), a
	ld	a, (hl)
	and	a, #0x01
	ld	a, #0x08
	jr	NZ, 00249$
	xor	a, a
00249$:
	ldhl	sp,	#8
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
	ldhl	sp,	#9
	ld	a, (hl)
	pop	hl
	ld	(hl+), a
	ld	(hl), c
;src/states/game.c:360: for (int i = 0; i < 4; i++)
	ldhl	sp,	#10
	inc	(hl)
	jr	00236$
00150$:
;src/states/game.c:364: entity_update_all(current_map->entities, current_map->num_entities);
	ld	a, (_current_map)
	ld	e, a
	ld	hl, #_current_map + 1
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	ld	b, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	l, (hl)
	ld	a, b
	ld	e, c
	ld	d, l
	call	_entity_update_all
;src/states/game.c:377: projectile_update_all();
	call	_projectile_update_all
;src/states/game.c:378: projectile_render_all(camera_x, camera_y);
	ld	a, (_camera_y)
	ld	c, a
	ld	hl, #_camera_y + 1
	ld	b, (hl)
	ld	a, (_camera_x)
	ld	e, a
	ld	hl, #_camera_x + 1
	ld	d, (hl)
	call	_projectile_render_all
;src/states/game.c:381: if (projectile_check_collision(player_x + 8, player_y + 8)) {
	ld	a, (_player_y)
	ld	hl, #_player_y + 1
	ld	b, (hl)
	add	a, #0x08
	ld	c, a
	jr	NC, 00802$
	inc	b
00802$:
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	d, (hl)
	add	a, #0x08
	ld	e, a
	jr	NC, 00803$
	inc	d
00803$:
	call	_projectile_check_collision
	or	a, a
	jr	Z, 00290$
;src/states/game.c:382: player_hit();
	call	_player_hit
;src/states/game.c:383: return;
	jp	00244$
;src/states/game.c:387: for (int i = 0; i < current_map->num_entities; i++) {
00290$:
	xor	a, a
	ldhl	sp,	#5
	ld	(hl+), a
	ld	(hl), a
00239$:
;src/states/game.c:364: entity_update_all(current_map->entities, current_map->num_entities);
	ld	a, (_current_map)
	ld	c, a
	ld	hl, #_current_map + 1
	ld	b, (hl)
	ld	hl, #0x0006
	add	hl, bc
;src/states/game.c:387: for (int i = 0; i < current_map->num_entities; i++) {
	ld	a, (hl)
	ldhl	sp,#8
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl+), a
	ld	(hl), #0x00
;src/states/game.c:364: entity_update_all(current_map->entities, current_map->num_entities);
	ld	hl, #0x0004
	add	hl, bc
;src/states/game.c:388: entity_t *e = &current_map->entities[i];
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/states/game.c:387: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#5
	ld	e, l
	ld	d, h
	ldhl	sp,	#9
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00804$
	bit	7, d
	jr	NZ, 00805$
	cp	a, a
	jr	00805$
00804$:
	bit	7, d
	jr	Z, 00805$
	scf
00805$:
	jp	NC, 00163$
;src/states/game.c:388: entity_t *e = &current_map->entities[i];
	ldhl	sp,	#5
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
	add	a, c
	ld	c, a
	ld	a, e
	adc	a, b
	ld	b, a
;src/states/game.c:389: if (e->active && e->type == ENT_ENEMY) {
	ld	hl, #0x0008
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jp	Z, 00240$
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	sub	a, #0x03
	jp	NZ, 00240$
;src/states/game.c:390: int16_t dx = (int16_t)player_x - (int16_t)e->x;
	ld	a, (#_player_x)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#4
	ld	(hl), a
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#9
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#9
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#8
	ld	(hl-), a
	ld	(hl), e
;src/states/game.c:391: int16_t dy = (int16_t)player_y - (int16_t)e->y;
	ld	a, (#_player_y)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#4
	ld	(hl), a
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,#3
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ldhl	sp,	#10
	ld	(hl-), a
;src/states/game.c:392: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00154$
;src/states/game.c:393: dx = -dx;
	ld	de, #0x0000
	ld	a, (hl-)
	ld	l, (hl)
	ld	h, a
	ld	a, e
	sub	a, l
	ld	e, a
	ld	a, d
	sbc	a, h
	ldhl	sp,	#8
	ld	(hl-), a
	ld	(hl), e
00154$:
;src/states/game.c:394: if (dy < 0)
	ldhl	sp,	#9
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00156$
;src/states/game.c:395: dy = -dy;
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
00156$:
;src/states/game.c:396: if (dx < 10 && dy < 10) {
	ldhl	sp,	#7
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
	jr	NC, 00240$
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
	jr	NC, 00240$
;src/states/game.c:397: player_hit();
	call	_player_hit
;src/states/game.c:398: return;
	jp	00244$
00240$:
;src/states/game.c:387: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#5
	inc	(hl)
	jp	NZ, 00239$
	inc	hl
	inc	(hl)
	jp	00239$
00163$:
;src/states/game.c:403: entity_render_all(current_map->entities, current_map->num_entities, camera_x,
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
	ld	e, c
	ld	d, b
	call	_entity_render_all
;src/states/game.c:406: if (input_pressed(J_A | J_B)) {
	ld	a, #0x30
	call	_input_pressed
	or	a, a
	jp	Z, 00231$
;src/states/game.c:407: uint8_t interacted = 0;
	ldhl	sp,	#0
	ld	(hl), #0x00
;src/states/game.c:408: for (int i = 0; i < current_map->num_entities; i++) {
	xor	a, a
	ldhl	sp,	#7
	ld	(hl+), a
	ld	(hl), a
00242$:
;src/states/game.c:364: entity_update_all(current_map->entities, current_map->num_entities);
	ld	a, (#_current_map)
	ldhl	sp,	#5
	ld	(hl), a
	ld	a, (#_current_map + 1)
	ldhl	sp,	#6
;src/states/game.c:408: for (int i = 0; i < current_map->num_entities; i++) {
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
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
	ld	d, (hl)
	ld	a, (de)
	ld	c, a
	ld	b, #0x00
	ldhl	sp,	#7
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	ld	e, a
	bit	7, e
	jr	Z, 00810$
	bit	7, d
	jr	NZ, 00811$
	cp	a, a
	jr	00811$
00810$:
	bit	7, d
	jr	Z, 00811$
	scf
00811$:
	jp	NC, 00186$
;src/states/game.c:409: entity_t *e = &current_map->entities[i];
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,	#7
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
	ld	(hl), a
;src/states/game.c:410: int16_t dx = (int16_t)player_x - (int16_t)e->x,
	ld	a, (_player_x)
	ld	b, a
	ld	hl, #_player_x + 1
	ld	c, (hl)
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	ld	h, a
	ld	e, l
	ld	d, h
	ld	a, b
	sub	a, e
	ld	b, a
	ld	a, c
	sbc	a, d
	ld	c, a
;src/states/game.c:411: dy = (int16_t)player_y - (int16_t)e->y;
	ld	a, (#_player_y)
	ldhl	sp,	#3
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	h, (hl)
	ld	l, a
	inc	hl
	inc	hl
	ld	e, l
	ld	d, h
	ld	a, (de)
	ldhl	sp,	#9
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#6
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
	ldhl	sp,	#10
	ld	(hl-), a
	ld	(hl), e
;src/states/game.c:412: if (dx < 0)
	ld	h, c
	bit	7, h
	jr	Z, 00165$
;src/states/game.c:413: dx = -dx;
	xor	a, a
	sub	a, b
	ld	b, a
	sbc	a, a
	sub	a, c
	ld	c, a
00165$:
;src/states/game.c:414: if (dy < 0)
	ldhl	sp,	#9
	ld	a, (hl)
	ldhl	sp,	#5
	ld	(hl), a
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#6
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00167$
;src/states/game.c:415: dy = -dy;
	ld	de, #0x0000
	ldhl	sp,	#9
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
00167$:
;src/states/game.c:416: if (dx < 28 && dy < 28) {
	ld	a, b
	sub	a, #0x1c
	ld	a, c
	rla
	ccf
	rra
	sbc	a, #0x80
	jp	NC, 00243$
	ldhl	sp,	#9
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
	jp	NC, 00243$
;src/states/game.c:417: if (input_pressed(J_A)) {
	ld	a, #0x10
	call	_input_pressed
	ldhl	sp,	#10
	ld	(hl), a
;src/states/game.c:418: if (e->type == ENT_NPC) {
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0004
	add	hl, de
	push	hl
	ld	a, l
	ldhl	sp,	#7
	ld	(hl), a
	pop	hl
	ld	a, h
	ldhl	sp,	#6
	ld	(hl), a
;src/states/game.c:421: if (e->sprite_base == 36 && inventory_has_item("FLOR")) {
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
;src/states/game.c:417: if (input_pressed(J_A)) {
	ldhl	sp,	#10
	ld	a, (hl)
	or	a, a
	jr	Z, 00175$
;src/states/game.c:418: if (e->type == ENT_NPC) {
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00175$
;src/states/game.c:419: interacted = 1;
	ldhl	sp,	#0
	ld	(hl), #0x01
;src/states/game.c:421: if (e->sprite_base == 36 && inventory_has_item("FLOR")) {
	ld	a, (bc)
	sub	a, #0x24
	jr	NZ, 00169$
	push	bc
	ld	de, #___str_0
	call	_inventory_has_item
	pop	bc
	or	a, a
	jr	Z, 00169$
;src/states/game.c:422: text_dialogue(DIALOGUE_FLOWER_THANKS);
	push	bc
	ld	de, #___str_1
	call	_text_dialogue
	pop	bc
	jr	00175$
00169$:
;src/states/game.c:424: text_dialogue(e->dialogue);
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0005
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
	ld	d, (hl)
	ld	a, (de)
	ld	l, a
	inc	de
	ld	a, (de)
	push	bc
	ld	e, l
	ld	d, a
	call	_text_dialogue
	pop	bc
00175$:
;src/states/game.c:428: if (input_pressed(J_B)) {
	push	bc
	ld	a, #0x20
	call	_input_pressed
	pop	bc
	or	a, a
	jr	Z, 00243$
;src/states/game.c:429: if (e->type == ENT_ITEM && e->active) {
	ldhl	sp,#5
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00243$
	ldhl	sp,#1
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	or	a, a
	jr	Z, 00243$
;src/states/game.c:430: interacted = 1;
	ldhl	sp,	#0
	ld	(hl), #0x01
;src/states/game.c:431: if (e->sprite_base == 41) {
	ld	a, (bc)
	sub	a, #0x29
	jr	NZ, 00243$
;src/states/game.c:432: inventory_add_item("FLOR", "Una hermosa\nflor silvestre", 41);
	push	de
	ld	a, #0x29
	push	af
	inc	sp
	ld	bc, #___str_2
	ld	de, #___str_0
	call	_inventory_add_item
;src/states/game.c:433: sfx_pickup();
	call	_sfx_pickup
	pop	de
;src/states/game.c:434: e->active = 0;
	xor	a, a
	ld	(de), a
00243$:
;src/states/game.c:408: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#7
	inc	(hl)
	jp	NZ, 00242$
	inc	hl
	inc	(hl)
	jp	00242$
00186$:
;src/states/game.c:441: if (interacted)
	ldhl	sp,	#0
	ld	a, (hl)
	or	a, a
;src/states/game.c:442: return;
	jp	NZ, 00244$
;src/states/game.c:445: uint16_t ix = player_x + 8;
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	c, (hl)
	add	a, #0x08
	ld	b, a
	ld	a, c
	adc	a, #0x00
	ldhl	sp,	#9
	ld	(hl), b
	inc	hl
	ld	(hl), a
;src/states/game.c:446: uint16_t iy = player_y + 8;
	ld	a, (_player_y)
	ld	hl, #_player_y + 1
	ld	b, (hl)
	add	a, #0x08
	ld	c, a
	jr	NC, 00820$
	inc	b
00820$:
;src/states/game.c:448: iy += 8;
	ld	e, c
	ld	d, b
;src/states/game.c:447: if (player_dir == 0) // DOWN
	ld	a, (#_player_dir)
	or	a, a
	jr	NZ, 00198$
;src/states/game.c:448: iy += 8;
	ld	hl, #0x0008
	add	hl, de
	ld	c, l
	ld	b, h
	jr	00199$
00198$:
;src/states/game.c:449: else if (player_dir == 1) // UP
	ld	a, (#_player_dir)
	dec	a
	jr	NZ, 00195$
;src/states/game.c:450: iy -= 8;
	ld	a, e
	add	a, #0xf8
	ld	c, a
	ld	a, d
	adc	a, #0xff
	ld	b, a
	jr	00199$
00195$:
;src/states/game.c:452: ix -= 8;
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
;src/states/game.c:451: else if (player_dir == 2) // LEFT
	ld	a, (#_player_dir)
	sub	a, #0x02
	jr	NZ, 00192$
;src/states/game.c:452: ix -= 8;
	ld	a, e
	add	a, #0xf8
	ld	e, a
	ld	a, d
	adc	a, #0xff
	ldhl	sp,	#9
	ld	(hl), e
	inc	hl
	ld	(hl), a
	jr	00199$
00192$:
;src/states/game.c:453: else if (player_dir == 3) // RIGHT
	ld	a, (#_player_dir)
	sub	a, #0x03
	jr	NZ, 00199$
;src/states/game.c:454: ix += 8;
	ld	hl, #0x0008
	add	hl, de
	ld	e, l
	ld	a, h
	ldhl	sp,	#9
	ld	(hl), e
	inc	hl
	ld	(hl), a
00199$:
;src/states/game.c:456: uint8_t tid = get_tile_at(ix, iy);
	ldhl	sp,	#9
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	call	_get_tile_at
	ldhl	sp,	#9
	ld	(hl), a
;src/states/game.c:459: if (current_map == &maps[0]) { // WORLD_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_maps)
	jr	NZ, 00211$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_maps)
	jr	NZ, 00211$
;src/states/game.c:460: if (tid >= 6 && tid <= 24) {
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x06
	jr	C, 00211$
	ld	a, #0x18
	sub	a, (hl)
	jr	C, 00211$
;src/states/game.c:462: if (!((tid == 21 || tid == 22) && player_x > 160 && player_y > 160)) {
	ld	a, (hl)
	sub	a, #0x15
	jr	Z, 00205$
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x16
	jr	NZ, 00202$
00205$:
	ld	a, (_player_x)
	ld	c, a
	ld	hl, #_player_x + 1
	ld	b, (hl)
	ld	a, #0xa0
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	NC, 00202$
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
	ld	a, #0xa0
	cp	a, c
	ld	a, #0x00
	sbc	a, b
	jr	C, 00211$
00202$:
;src/states/game.c:463: if (input_pressed(J_A)) {
	ld	a, #0x10
	call	_input_pressed
	or	a, a
	jr	Z, 00211$
;src/states/game.c:464: text_dialogue(DIALOGUE_HOUSE_CLOSED);
	ld	de, #___str_3
	call	_text_dialogue
;src/states/game.c:465: return;
	jp	00244$
00211$:
;src/states/game.c:471: if (current_map == &maps[1] && // HOUSE_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 26))
	jr	NZ, 00218$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 26))
	jr	NZ, 00218$
;src/states/game.c:472: (tid == 31 || tid == 32 || tid == 33 || tid == 34)) {
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x1f
	jr	Z, 00217$
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x20
	jr	Z, 00217$
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x21
	jr	Z, 00217$
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x22
	jr	NZ, 00218$
00217$:
;src/states/game.c:473: if (input_pressed(J_B)) {
	ld	a, #0x20
	call	_input_pressed
	ldhl	sp,#10
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	Z, 00218$
;src/states/game.c:474: if (!inventory_has_item("LLAVE")) {
	ld	de, #___str_4
	call	_inventory_has_item
	ldhl	sp,#10
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00213$
;src/states/game.c:475: text_dialogue(DIALOGUE_FOUND_KEY);
	ld	de, #___str_5
	call	_text_dialogue
;src/states/game.c:476: inventory_add_item("LLAVE", "Abre el porton norte", 41);
	ld	a, #0x29
	push	af
	inc	sp
	ld	bc, #___str_6
	ld	de, #___str_4
	call	_inventory_add_item
;src/states/game.c:477: sfx_pickup();
	call	_sfx_pickup
	jr	00218$
00213$:
;src/states/game.c:479: text_dialogue(DIALOGUE_EMPTY_CHEST);
	ld	de, #___str_7
	call	_text_dialogue
00218$:
;src/states/game.c:483: if (current_map == &maps[0] && (tid == 38 || tid == 39)) { // WORLD_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_maps)
	jr	NZ, 00231$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_maps)
	jr	NZ, 00231$
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x26
	jr	Z, 00226$
	ldhl	sp,	#9
	ld	a, (hl)
	sub	a, #0x27
	jr	NZ, 00231$
00226$:
;src/states/game.c:484: if (inventory_has_item("LLAVE")) {
	ld	de, #___str_4
	call	_inventory_has_item
	or	a, a
	jr	Z, 00224$
;src/states/game.c:485: text_dialogue(DIALOGUE_USE_KEY);
	ld	de, #___str_8
	call	_text_dialogue
;src/states/game.c:486: sfx_success();
	call	_sfx_success
;src/states/game.c:487: switch_map(&maps[2], 128, 224); // LEVEL2_MAP
	ld	de, #0x00e0
	push	de
	ld	bc, #0x0080
	ld	de, #(_maps + 52)
	call	_switch_map
;src/states/game.c:488: return;
	jr	00244$
00224$:
;src/states/game.c:490: text_dialogue(DIALOGUE_LOCKED_GATE);
	ld	de, #___str_9
	call	_text_dialogue
00231$:
;src/states/game.c:495: if ((env_anim_timer % 32) == 0) {
	ld	a, (_env_anim_timer)
	and	a, #0x1f
	jr	NZ, 00233$
;src/states/game.c:496: env_anim_frame = !env_anim_frame;
	ld	hl, #_env_anim_frame
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/states/game.c:500: set_bkg_data(2, 1, env_anim_frame ? &tiles_anim_data[0] : &tiles_data[32]);
	ld	a, (hl)
	or	a, a
	jr	Z, 00250$
	ld	bc, #_tiles_anim_data+0
	jr	00251$
00250$:
	ld	bc, #_tiles_data+32
00251$:
	push	bc
	ld	hl, #0x102
	push	hl
	call	_set_bkg_data
	add	sp, #4
00233$:
;src/states/game.c:502: hud_update();
	call	_hud_update
;src/states/game.c:503: env_anim_timer++;
	ld	hl, #_env_anim_timer
	inc	(hl)
00244$:
;src/states/game.c:504: }
	add	sp, #11
	ret
___str_0:
	.ascii "FLOR"
	.db 0x00
___str_1:
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
___str_2:
	.ascii "Una hermosa"
	.db 0x0a
	.ascii "flor silvestre"
	.db 0x00
___str_3:
	.ascii "Esta casa esta"
	.db 0x0a
	.ascii "cerrada."
	.db 0x00
___str_4:
	.ascii "LLAVE"
	.db 0x00
___str_5:
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
___str_6:
	.ascii "Abre el porton norte"
	.db 0x00
___str_7:
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
___str_8:
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
___str_9:
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
;src/states/game.c:506: void game_reset(void) {
;	---------------------------------
; Function game_reset
; ---------------------------------
_game_reset::
;src/states/game.c:507: player_x = 128;
	ld	hl, #_player_x
	ld	a, #0x80
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:508: player_y = 128;
	ld	hl, #_player_y
	ld	a, #0x80
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:509: enter_x = 128;
	ld	hl, #_enter_x
	ld	a, #0x80
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:510: enter_y = 128;
	ld	hl, #_enter_y
	ld	a, #0x80
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:511: player_lives = 3;
	ld	hl, #_player_lives
	ld	(hl), #0x03
;src/states/game.c:512: inventory_init();
	call	_inventory_init
;src/states/game.c:513: projectile_init();
	call	_projectile_init
;src/states/game.c:514: game_ready = 0;
	xor	a, a
	ld	(#_game_ready),a
;src/states/game.c:515: }
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
__xinit__game_ready:
	.db #0x00	; 0
	.area _CABS (ABS)
