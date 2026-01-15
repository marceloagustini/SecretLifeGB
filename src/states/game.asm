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
	.globl _update_camera
	.globl _get_tile_at
	.globl _map_init_data
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
	.globl _input_held
	.globl _input_pressed
	.globl _fade_in
	.globl _fade_out
	.globl _entity_render_all
	.globl _entity_update_all
	.globl _fill_bkg_rect
	.globl _set_sprite_data
	.globl _set_bkg_tile_xy
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _display_off
	.globl _delay
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
;src/states/game.c:43: uint8_t get_tile_at(uint16_t x, uint16_t y) {
;	---------------------------------
; Function get_tile_at
; ---------------------------------
_get_tile_at::
	add	sp, #-6
;src/states/game.c:44: uint16_t tx = x / 8, ty = y / 8;
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
;src/states/game.c:45: if (tx >= current_map->w || ty >= current_map->h)
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
;src/states/game.c:46: return 0;
	xor	a, a
	jr	00104$
00102$:
;src/states/game.c:47: return current_map->tiles[ty * current_map->w + tx];
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
;src/states/game.c:48: }
	add	sp, #6
	ret
;src/states/game.c:50: void update_camera() {
;	---------------------------------
; Function update_camera
; ---------------------------------
_update_camera::
	add	sp, #-4
;src/states/game.c:51: uint16_t w = current_map->w * 8, h = current_map->h * 8;
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
;src/states/game.c:55: camera_x = 0;
	xor	a, a
	ld	hl, #_camera_x
	ld	(hl+), a
	ld	(hl), a
00103$:
;src/states/game.c:56: if (player_y > SCREEN_HEIGHT / 2)
	ld	hl, #_player_y
	ld	a, #0x48
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	jr	NC, 00105$
;src/states/game.c:57: camera_y = player_y - SCREEN_HEIGHT / 2;
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
;src/states/game.c:59: camera_y = 0;
	xor	a, a
	ld	hl, #_camera_y
	ld	(hl+), a
	ld	(hl), a
00106$:
;src/states/game.c:60: if (camera_x > w - SCREEN_WIDTH)
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
;src/states/game.c:61: camera_x = (w > SCREEN_WIDTH) ? (w - SCREEN_WIDTH) : 0;
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
;src/states/game.c:62: if (camera_y > h - SCREEN_HEIGHT)
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
;src/states/game.c:63: camera_y = (h > SCREEN_HEIGHT) ? (h - SCREEN_HEIGHT) : 0;
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
;src/states/game.c:64: move_bkg(camera_x, camera_y);
	ld	a, (_camera_y)
	ld	c, a
	ld	a, (#_camera_x)
	ldh	(_SCX_REG + 0), a
;./gbdk/include/gb/gb.h:1461: SCX_REG=x, SCY_REG=y;
	ld	a, c
	ldh	(_SCY_REG + 0), a
;src/states/game.c:64: move_bkg(camera_x, camera_y);
;src/states/game.c:65: }
	add	sp, #4
	ret
;src/states/game.c:67: void update_player_sprite() {
;	---------------------------------
; Function update_player_sprite
; ---------------------------------
_update_player_sprite::
	dec	sp
;src/states/game.c:68: uint8_t base =
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
;src/states/game.c:72: uint8_t prop = (player_dir == 3) ? S_FLIPX : 0;
	ld	a, b
	or	a, a
	ld	e, #0x20
	jr	NZ, 00131$
	ld	e, #0x00
00131$:
;src/states/game.c:73: if (prop == 0) {
	ld	a, e
	or	a, a
	jr	NZ, 00104$
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), c
;src/states/game.c:75: set_sprite_tile(1, base + 1);
	ld	a, c
	inc	a
	ldhl	sp,	#0
	ld	(hl), a
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	de, #(_shadow_OAM + 6)
	ld	a, (hl)
	ld	(de), a
;src/states/game.c:76: set_sprite_tile(2, base + 2);
	ld	b, c
	inc	b
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), b
;src/states/game.c:77: set_sprite_tile(3, base + 3);
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), c
;src/states/game.c:78: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00117$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00122$
;src/states/game.c:79: set_sprite_prop(i, 0);
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
;src/states/game.c:78: for (int i = 0; i < 4; i++)
	inc	c
	jr	00117$
00104$:
;src/states/game.c:81: set_sprite_tile(0, base + 1);
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
;src/states/game.c:83: set_sprite_tile(2, base + 3);
	ld	c, b
	inc	c
	inc	c
	inc	c
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), c
;src/states/game.c:84: set_sprite_tile(3, base + 2);
	inc	b
	inc	b
;./gbdk/include/gb/gb.h:1887: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), b
;src/states/game.c:85: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00120$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00122$
;src/states/game.c:86: set_sprite_prop(i, S_FLIPX);
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
;src/states/game.c:85: for (int i = 0; i < 4; i++)
	inc	c
	jr	00120$
00122$:
;src/states/game.c:88: }
	inc	sp
	ret
;src/states/game.c:90: void load_map(map_t *m) {
;	---------------------------------
; Function load_map
; ---------------------------------
_load_map::
	add	sp, #-4
	ld	c, e
	ld	b, d
;src/states/game.c:91: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:92: current_map = m;
	ld	hl, #_current_map
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:93: for (int i = 4; i < 40; i++)
	ld	e, #0x04
00113$:
	ld	a, e
	sub	a, #0x28
	jr	NC, 00101$
;src/states/game.c:94: move_sprite(i, 0, 0); // Hide map sprites
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
;src/states/game.c:93: for (int i = 4; i < 40; i++)
	inc	e
	jr	00113$
00101$:
;src/states/game.c:96: if (m == &maps[1]) // HOUSE_MAP
	ld	a, #<((_maps + 26))
	sub	a, c
	jr	NZ, 00103$
	ld	a, #>((_maps + 26))
	sub	a, b
	jr	NZ, 00103$
;src/states/game.c:97: fill_bkg_rect(0, 0, 32, 32, 26);
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
;src/states/game.c:99: set_bkg_tiles(0, 0, m->w, m->h, m->tiles);
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
;src/states/game.c:102: if (m == &maps[2]) {
	ld	a, #<((_maps + 52))
	sub	a, c
	jr	NZ, 00108$
	ld	a, #>((_maps + 52))
	sub	a, b
	jr	NZ, 00108$
;src/states/game.c:105: if (DIV_REG & 0x01) {
	ldh	a, (_DIV_REG + 0)
	rrca
	jr	NC, 00105$
;src/states/game.c:106: rx = 2; // Top-left
	ld	bc, #0x0002
	jr	00106$
00105$:
;src/states/game.c:108: rx = m->w - 4; // Top-right
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
;src/states/game.c:111: level2_door_x = rx * 8;
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
;src/states/game.c:112: level2_door_y = ry * 8;
	ld	hl, #_level2_door_y
	ld	a, #0x10
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:115: set_bkg_tile_xy(rx, ry, 31);
	push	bc
	ld	a, #0x1f
	push	af
	inc	sp
	ld	e, #0x02
	ld	a, c
	call	_set_bkg_tile_xy
	pop	bc
;src/states/game.c:116: set_bkg_tile_xy(rx + 1, ry, 31);
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
;src/states/game.c:117: set_bkg_tile_xy(rx, ry + 1, 31);
	push	bc
	ld	a, #0x1f
	push	af
	inc	sp
	ld	e, #0x03
	ld	a, c
	call	_set_bkg_tile_xy
	pop	bc
;src/states/game.c:118: set_bkg_tile_xy(rx + 1, ry + 1, 31);
	ld	a, #0x1f
	push	af
	inc	sp
	ld	e, #0x03
	ld	a, b
	call	_set_bkg_tile_xy
00108$:
;src/states/game.c:121: update_camera();
	call	_update_camera
;src/states/game.c:124: uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
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
;src/states/game.c:125: for (int i = 0; i < 4; i++)
	ld	c, #0x00
00116$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00109$
;src/states/game.c:126: move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));
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
;src/states/game.c:125: for (int i = 0; i < 4; i++)
	inc	c
	jr	00116$
00109$:
;src/states/game.c:128: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:129: }
	add	sp, #4
	ret
;src/states/game.c:131: void switch_map(map_t *new_map, uint16_t new_x, uint16_t new_y) {
;	---------------------------------
; Function switch_map
; ---------------------------------
_switch_map::
;src/states/game.c:132: fade_out();
	push	bc
	push	de
	call	_fade_out
	pop	de
	pop	bc
;src/states/game.c:133: player_x = new_x;
	ld	hl, #_player_x
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:134: player_y = new_y;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(#_player_y),a
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_player_y + 1),a
;src/states/game.c:135: enter_x = new_x; // Remember map entrance
	ld	hl, #_enter_x
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;src/states/game.c:136: enter_y = new_y;
	ldhl	sp,	#2
	ld	a, (hl)
	ld	(#_enter_y),a
	ldhl	sp,	#3
	ld	a, (hl)
	ld	(#_enter_y + 1),a
;src/states/game.c:137: load_map(new_map);
	call	_load_map
;src/states/game.c:138: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:139: fade_in();
	call	_fade_in
;src/states/game.c:140: }
	pop	hl
	pop	af
	jp	(hl)
;src/states/game.c:142: uint8_t is_solid(uint16_t x, uint16_t y) { return map_is_solid(x, y); }
;	---------------------------------
; Function is_solid
; ---------------------------------
_is_solid::
	jp	_map_is_solid
;src/states/game.c:144: uint8_t can_move(uint16_t nx, uint16_t ny) {
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
;src/states/game.c:145: if (nx < 4 || ny < 4 || nx > (current_map->w * 8 - 12) ||
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
;src/states/game.c:146: ny > (current_map->h * 8 - 12))
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
;src/states/game.c:147: return 0;
	xor	a, a
	jp	00124$
00102$:
;src/states/game.c:149: if (is_solid(nx + 4, ny + 8) || is_solid(nx + 12, ny + 8) ||
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
;src/states/game.c:150: is_solid(nx + 4, ny + 15) || is_solid(nx + 12, ny + 15)) {
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
;src/states/game.c:151: return 0;
	xor	a, a
	jp	00124$
;src/states/game.c:154: for (int i = 0; i < current_map->num_entities; i++) {
00138$:
	xor	a, a
	ldhl	sp,	#8
	ld	(hl+), a
	ld	(hl), a
00123$:
;src/states/game.c:145: if (nx < 4 || ny < 4 || nx > (current_map->w * 8 - 12) ||
	ld	a, (_current_map)
	ld	c, a
	ld	hl, #_current_map + 1
	ld	b, (hl)
;src/states/game.c:154: for (int i = 0; i < current_map->num_entities; i++) {
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
;src/states/game.c:155: entity_t *e = &current_map->entities[i];
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
;src/states/game.c:156: if (!e->active)
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
;src/states/game.c:158: int16_t dx = (int16_t)nx - e->x, dy = (int16_t)ny - e->y;
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
;src/states/game.c:159: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00114$
;src/states/game.c:160: dx = -dx;
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
;src/states/game.c:161: if (dy < 0)
	ldhl	sp,	#12
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00116$
;src/states/game.c:162: dy = -dy;
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
;src/states/game.c:163: if (dx < 12 && dy < 12)
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
;src/states/game.c:164: return 0; // Collide if too close
	xor	a, a
	jr	00124$
00120$:
;src/states/game.c:154: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#8
	inc	(hl)
	jp	NZ, 00123$
	inc	hl
	inc	(hl)
	jp	00123$
00121$:
;src/states/game.c:166: return 1;
	ld	a, #0x01
00124$:
;src/states/game.c:167: }
	add	sp, #14
	ret
;src/states/game.c:173: void game_init(void) {
;	---------------------------------
; Function game_init
; ---------------------------------
_game_init::
;src/states/game.c:174: DISPLAY_OFF;
	call	_display_off
;src/states/game.c:175: set_bkg_data(0, 40, tiles_data); // All tiles (now 40)
	ld	de, #_tiles_data
	push	de
	ld	hl, #0x2800
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/states/game.c:177: if (game_ready) {
	ld	a, (#_game_ready)
	or	a, a
	jr	Z, 00102$
;src/states/game.c:178: player_x = 128;
	ld	hl, #_player_x
	ld	a, #0x80
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:179: player_y = 128;
	ld	hl, #_player_y
	ld	a, #0x80
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:180: enter_x = 128;
	ld	hl, #_enter_x
	ld	a, #0x80
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:181: enter_y = 128;
	ld	hl, #_enter_y
	ld	a, #0x80
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;src/states/game.c:182: map_init_data();
	call	_map_init_data
;src/states/game.c:183: load_map(current_map);
	ld	a, (_current_map)
	ld	e, a
	ld	hl, #_current_map + 1
	ld	d, (hl)
	call	_load_map
;src/states/game.c:184: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:185: BGP_REG = OBP0_REG = OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/states/game.c:186: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:187: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:188: return;
	ret
00102$:
;src/states/game.c:191: map_init_data();
	call	_map_init_data
;src/states/game.c:192: load_map(&maps[0]); // WORLD_MAP
	ld	de, #_maps
	call	_load_map
;src/states/game.c:194: BGP_REG = OBP0_REG = OBP1_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_OBP1_REG + 0), a
	ld	a, #0xe4
	ldh	(_OBP0_REG + 0), a
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/states/game.c:195: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:196: set_sprite_data(0, 24, player_sprites);
	ld	de, #_player_sprites
	push	de
	ld	hl, #0x1800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:197: set_sprite_data(24, 4, npc_child_sprite);
	ld	de, #_npc_child_sprite
	push	de
	ld	hl, #0x418
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:198: set_sprite_data(28, 8, guard_sprite_data);
	ld	de, #_guard_sprite_data
	push	de
	ld	hl, #0x81c
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:199: set_sprite_data(36, 4, npc_woman_sprite);
	ld	de, #_npc_woman_sprite
	push	de
	ld	hl, #0x424
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:200: set_sprite_data(40, 1, projectile_sprite);
	ld	de, #_projectile_sprite
	push	de
	ld	hl, #0x128
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:201: set_sprite_data(41, 2, flower_sprite);
	ld	de, #_flower_sprite
	push	de
	ld	hl, #0x229
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/states/game.c:202: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:203: text_init();
	call	_text_init
;src/states/game.c:204: music_init();
	call	_music_init
;src/states/game.c:205: projectile_init();
	call	_projectile_init
;src/states/game.c:206: enter_x = player_x;
	ld	a, (#_player_x)
	ld	(#_enter_x),a
	ld	a, (#_player_x + 1)
	ld	(#_enter_x + 1),a
;src/states/game.c:207: enter_y = player_y;
	ld	a, (#_player_y)
	ld	(#_enter_y),a
	ld	a, (#_player_y + 1)
	ld	(#_enter_y + 1),a
;src/states/game.c:208: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:209: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:210: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/game.c:211: game_ready = 1;
	ld	hl, #_game_ready
	ld	(hl), #0x01
;src/states/game.c:212: }
	ret
;src/states/game.c:214: void player_hit() {
;	---------------------------------
; Function player_hit
; ---------------------------------
_player_hit::
;src/states/game.c:215: fade_out();
	call	_fade_out
;src/states/game.c:216: delay(1000);
	ld	de, #0x03e8
	call	_delay
;src/states/game.c:219: map_init_data();
	call	_map_init_data
;src/states/game.c:220: projectile_init();
	call	_projectile_init
;src/states/game.c:223: player_x = enter_x;
	ld	a, (#_enter_x)
	ld	(#_player_x),a
	ld	a, (#_enter_x + 1)
	ld	(#_player_x + 1),a
;src/states/game.c:224: player_y = enter_y;
	ld	a, (#_enter_y)
	ld	(#_player_y),a
	ld	a, (#_enter_y + 1)
	ld	(#_player_y + 1),a
;src/states/game.c:227: load_map(current_map);
	ld	a, (_current_map)
	ld	e, a
	ld	hl, #_current_map + 1
	ld	d, (hl)
	call	_load_map
;src/states/game.c:228: update_player_sprite();
	call	_update_player_sprite
;src/states/game.c:230: fade_in();
;src/states/game.c:231: }
	jp	_fade_in
;src/states/game.c:233: void game_update(void) {
;	---------------------------------
; Function game_update
; ---------------------------------
_game_update::
	add	sp, #-12
;src/states/game.c:234: music_update();
	call	_music_update
;src/states/game.c:235: uint8_t moved = 0;
	ld	c, #0x00
;src/states/game.c:236: uint16_t nx = player_x, ny = player_y;
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
;src/states/game.c:238: if (input_held(J_UP)) {
	push	bc
	ld	a, #0x04
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00110$
;src/states/game.c:239: ny--;
	ldhl	sp,#10
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:240: player_dir = 1;
	ld	hl, #_player_dir
	ld	(hl), #0x01
;src/states/game.c:241: moved = 1;
	ld	c, #0x01
	jr	00111$
00110$:
;src/states/game.c:242: } else if (input_held(J_DOWN)) {
	push	bc
	ld	a, #0x08
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00107$
;src/states/game.c:243: ny++;
	ldhl	sp,	#10
	inc	(hl)
	jr	NZ, 00694$
	inc	hl
	inc	(hl)
00694$:
;src/states/game.c:244: player_dir = 0;
	xor	a, a
	ld	(#_player_dir),a
;src/states/game.c:245: moved = 1;
	ld	c, #0x01
	jr	00111$
00107$:
;src/states/game.c:246: } else if (input_held(J_LEFT)) {
	push	bc
	ld	a, #0x02
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00104$
;src/states/game.c:247: nx--;
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	a, (hl-)
	ld	d, a
	dec	de
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;src/states/game.c:248: player_dir = 2;
	ld	hl, #_player_dir
	ld	(hl), #0x02
;src/states/game.c:249: moved = 1;
	ld	c, #0x01
	jr	00111$
00104$:
;src/states/game.c:250: } else if (input_held(J_RIGHT)) {
	push	bc
	ld	a, #0x01
	call	_input_held
	pop	bc
	or	a, a
	jr	Z, 00111$
;src/states/game.c:251: nx++;
	ldhl	sp,	#8
	inc	(hl)
	jr	NZ, 00695$
	inc	hl
	inc	(hl)
00695$:
;src/states/game.c:252: player_dir = 3;
	ld	hl, #_player_dir
	ld	(hl), #0x03
;src/states/game.c:253: moved = 1;
	ld	c, #0x01
00111$:
;src/states/game.c:256: if (moved) {
	ld	a, c
	or	a, a
	jr	Z, 00148$
;src/states/game.c:257: if (can_move(nx, ny)) {
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
	jp	Z, 00149$
;src/states/game.c:258: player_x = nx;
	ldhl	sp,	#8
	ld	a, (hl)
	ld	(#_player_x),a
	ldhl	sp,	#9
	ld	a, (hl)
	ld	(#_player_x + 1),a
;src/states/game.c:259: player_y = ny;
	ldhl	sp,	#10
	ld	a, (hl)
	ld	(#_player_y),a
	ldhl	sp,	#11
	ld	a, (hl)
	ld	(#_player_y + 1),a
;src/states/game.c:260: update_camera();
	call	_update_camera
;src/states/game.c:262: if (++anim_timer > 6) {
	ld	hl, #_anim_timer
	inc	(hl)
	ld	a, #0x06
	sub	a, (hl)
	jp	NC, 00149$
;src/states/game.c:263: anim_frame = !anim_frame;
	ld	hl, #_anim_frame
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/states/game.c:264: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
;src/states/game.c:265: update_player_sprite();
	call	_update_player_sprite
	jp	00149$
00148$:
;src/states/game.c:269: if (anim_frame != 0) {
	ld	hl, #_anim_frame
	ld	a, (hl)
	or	a, a
	jr	Z, 00117$
;src/states/game.c:270: anim_frame = 0;
	ld	(hl), #0x00
;src/states/game.c:271: update_player_sprite();
	call	_update_player_sprite
00117$:
;src/states/game.c:273: anim_timer = 0;
	xor	a, a
	ld	(#_anim_timer),a
;src/states/game.c:276: if (input_pressed(J_SELECT)) {
	ld	a, #0x40
	call	_input_pressed
	or	a, a
	jr	Z, 00119$
;src/states/game.c:277: game_state = 3; // STATE_INVENTORY
	ld	hl, #_game_state
	ld	(hl), #0x03
;src/states/game.c:278: return;
	jp	00222$
00119$:
;src/states/game.c:282: uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
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
	jr	NC, 00696$
	inc	d
00696$:
	call	_get_tile_at
	ldhl	sp,	#11
	ld	(hl), a
;src/states/game.c:283: if (current_map == &maps[0] && // WORLD_MAP
;src/states/game.c:282: uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
	ld	a, (_player_x)
	ld	e, a
	ld	hl, #_player_x + 1
	ld	d, (hl)
;src/states/game.c:288: switch_map(&maps[1], 76, 112); // HOUSE_MAP
;src/states/game.c:283: if (current_map == &maps[0] && // WORLD_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_maps)
	jr	NZ, 00124$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_maps)
	jr	NZ, 00124$
;src/states/game.c:284: (tid == 21 || tid == 22)) {
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x15
	jr	Z, 00123$
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x16
	jr	NZ, 00124$
00123$:
;src/states/game.c:285: if (player_x > 160 && player_y > 160) {
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
;src/states/game.c:286: saved_world_x = player_x;
	ld	a, (#_player_x)
	ld	(#_saved_world_x),a
	ld	a, (#_player_x + 1)
	ld	(#_saved_world_x + 1),a
;src/states/game.c:287: saved_world_y = player_y + 16;
	ld	hl, #0x0010
	add	hl, bc
	ld	c, l
	ld	a, h
	ld	hl, #_saved_world_y
	ld	(hl), c
	inc	hl
	ld	(hl), a
;src/states/game.c:288: switch_map(&maps[1], 76, 112); // HOUSE_MAP
	ld	de, #0x0070
	push	de
	ld	bc, #0x004c
	ld	de, #(_maps + 26)
	call	_switch_map
;src/states/game.c:289: return;
	jp	00222$
00124$:
;src/states/game.c:292: tid = get_tile_at(player_x + 8, player_y + 12);
	ld	hl, #0x000c
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #0x0008
	add	hl, de
	ld	e, l
	ld	d, h
	call	_get_tile_at
	ldhl	sp,	#4
	ld	(hl), a
;src/states/game.c:293: if (current_map == &maps[1] && tid == 35) { // HOUSE_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 26))
	jr	NZ, 00128$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 26))
	jr	NZ, 00128$
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, #0x23
	jr	NZ, 00128$
;src/states/game.c:294: uint16_t wx = saved_world_x;
	ld	a, (_saved_world_x)
	ld	hl, #_saved_world_x + 1
	ld	b, (hl)
;src/states/game.c:295: uint16_t wy = saved_world_y;
	ld	hl, #_saved_world_y
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
;src/states/game.c:296: switch_map(&maps[0], wx, wy); // WORLD_MAP
	push	de
	ld	c, a
	ld	de, #_maps
	call	_switch_map
;src/states/game.c:297: return;
	jp	00222$
00128$:
;src/states/game.c:299: if (current_map == &maps[2] && tid == 0 && player_y > 240) { // LEVEL2_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 52))
	jr	NZ, 00706$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 52))
	ld	a, #0x01
	jr	Z, 00707$
00706$:
	xor	a, a
00707$:
	ld	c, a
;src/states/game.c:282: uint8_t tid = get_tile_at(player_x + 8, player_y + 4);
	ld	a, (_player_y)
	ld	e, a
	ld	hl, #_player_y + 1
	ld	d, (hl)
;src/states/game.c:299: if (current_map == &maps[2] && tid == 0 && player_y > 240) { // LEVEL2_MAP
	ld	a, #0xf0
	cp	a, e
	ld	a, #0x00
	sbc	a, d
	ld	a, #0x00
	rla
	ldhl	sp,	#5
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
;src/states/game.c:300: switch_map(&maps[0], 124, 48);                             // WORLD_MAP
	ld	de, #0x0030
	push	de
	ld	bc, #0x007c
	ld	de, #_maps
	call	_switch_map
;src/states/game.c:301: return;
	jp	00222$
00131$:
;src/states/game.c:314: switch_map(&maps[3], 128, 224); // To Level 3 (on the path)
;src/states/game.c:305: if (current_map == &maps[2]) {
	ld	a, c
	or	a, a
	jp	Z, 00142$
;src/states/game.c:306: int16_t dx = (int16_t)player_x - (int16_t)level2_door_x;
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
;src/states/game.c:307: int16_t dy = (int16_t)player_y - (int16_t)level2_door_y;
	ld	a, (#_player_y)
	ldhl	sp,	#6
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#7
	ld	(hl), a
	ld	a, (#_level2_door_y)
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (#_level2_door_y + 1)
	ldhl	sp,	#9
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
	ldhl	sp,	#11
	ld	(hl-), a
	ld	(hl), e
;src/states/game.c:308: if (dx < 0)
	ld	h, b
	bit	7, h
	jr	Z, 00135$
;src/states/game.c:309: dx = -dx;
	xor	a, a
	sub	a, c
	ld	c, a
	sbc	a, a
	sub	a, b
	ld	b, a
00135$:
;src/states/game.c:310: if (dy < 0)
	ldhl	sp,	#10
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	bit	7, (hl)
	jr	Z, 00137$
;src/states/game.c:311: dy = -dy;
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
00137$:
;src/states/game.c:313: if (dx < 16 && dy < 16) {
	ld	a, c
	sub	a, #0x10
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00142$
	ldhl	sp,	#10
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
;src/states/game.c:314: switch_map(&maps[3], 128, 224); // To Level 3 (on the path)
	ld	de, #0x00e0
	push	de
	ld	bc, #0x0080
	ld	de, #(_maps + 78)
	call	_switch_map
;src/states/game.c:315: return;
	jp	00222$
00142$:
;src/states/game.c:319: if (current_map == &maps[3] && tid == 0 && player_y > 240) { // LEVEL3_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 78))
	jr	NZ, 00149$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 78))
	jr	NZ, 00149$
	ldhl	sp,	#4
	ld	a, (hl)
	or	a, a
	jr	NZ, 00149$
	inc	hl
	ld	a, (hl)
	or	a, a
	jr	Z, 00149$
;src/states/game.c:320: switch_map(&maps[2], 128, 224); // Return to Level 2 (entrance)
	ld	de, #0x00e0
	push	de
	ld	bc, #0x0080
	ld	de, #(_maps + 52)
	call	_switch_map
;src/states/game.c:321: return;
	jp	00222$
00149$:
;src/states/game.c:327: uint16_t sx = player_x - camera_x + 8, sy = player_y - camera_y + 16;
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
;src/states/game.c:328: for (int i = 0; i < 4; i++)
	ldhl	sp,	#11
	ld	(hl), #0x00
00214$:
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00150$
;src/states/game.c:329: move_sprite(i, sx + (i % 2 ? 8 : 0), sy + (i >= 2 ? 8 : 0));
	ldhl	sp,	#7
	ld	c, (hl)
	ldhl	sp,	#11
	ld	a, (hl)
	sub	a, #0x02
	jr	C, 00224$
	ld	a, #0x08
	jr	00225$
00224$:
	xor	a, a
00225$:
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
	jr	NZ, 00227$
	xor	a, a
00227$:
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
;src/states/game.c:328: for (int i = 0; i < 4; i++)
	ldhl	sp,	#11
	inc	(hl)
	jr	00214$
00150$:
;src/states/game.c:332: entity_update_all(current_map->entities, current_map->num_entities);
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
;src/states/game.c:345: projectile_update_all();
	call	_projectile_update_all
;src/states/game.c:346: projectile_render_all(camera_x, camera_y);
	ld	a, (_camera_y)
	ld	c, a
	ld	hl, #_camera_y + 1
	ld	b, (hl)
	ld	a, (_camera_x)
	ld	e, a
	ld	hl, #_camera_x + 1
	ld	d, (hl)
	call	_projectile_render_all
;src/states/game.c:349: if (projectile_check_collision(player_x + 8, player_y + 8)) {
	ld	a, (_player_y)
	ld	hl, #_player_y + 1
	ld	b, (hl)
	add	a, #0x08
	ld	c, a
	jr	NC, 00710$
	inc	b
00710$:
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	d, (hl)
	add	a, #0x08
	ld	e, a
	jr	NC, 00711$
	inc	d
00711$:
	call	_projectile_check_collision
	or	a, a
	jr	Z, 00268$
;src/states/game.c:350: player_hit();
	call	_player_hit
;src/states/game.c:351: return;
	jp	00222$
;src/states/game.c:355: for (int i = 0; i < current_map->num_entities; i++) {
00268$:
	xor	a, a
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), a
00217$:
;src/states/game.c:332: entity_update_all(current_map->entities, current_map->num_entities);
	ld	a, (_current_map)
	ld	c, a
	ld	hl, #_current_map + 1
	ld	b, (hl)
	ld	hl, #0x0006
	add	hl, bc
;src/states/game.c:355: for (int i = 0; i < current_map->num_entities; i++) {
	ld	a, (hl)
	ldhl	sp,#9
	ld	(hl), a
	ld	a, (hl+)
	ld	(hl+), a
	ld	(hl), #0x00
;src/states/game.c:332: entity_update_all(current_map->entities, current_map->num_entities);
	ld	hl, #0x0004
	add	hl, bc
;src/states/game.c:356: entity_t *e = &current_map->entities[i];
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/states/game.c:355: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#6
	ld	e, l
	ld	d, h
	ldhl	sp,	#10
	ld	a, (de)
	inc	de
	sub	a, (hl)
	inc	hl
	ld	a, (de)
	sbc	a, (hl)
	ld	a, (de)
	ld	d, a
	bit	7, (hl)
	jr	Z, 00712$
	bit	7, d
	jr	NZ, 00713$
	cp	a, a
	jr	00713$
00712$:
	bit	7, d
	jr	Z, 00713$
	scf
00713$:
	jp	NC, 00163$
;src/states/game.c:356: entity_t *e = &current_map->entities[i];
	ldhl	sp,	#6
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
;src/states/game.c:357: if (e->active && e->type == ENT_ENEMY) {
	ld	hl, #0x0008
	add	hl, bc
	ld	a, (hl)
	or	a, a
	jp	Z, 00218$
	ld	hl, #0x0004
	add	hl, bc
	ld	a, (hl)
	sub	a, #0x03
	jp	NZ, 00218$
;src/states/game.c:358: int16_t dx = (int16_t)player_x - (int16_t)e->x;
	ld	a, (#_player_x)
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#5
	ld	(hl), a
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#10
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
;src/states/game.c:359: int16_t dy = (int16_t)player_y - (int16_t)e->y;
	ld	a, (#_player_y)
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#5
	ld	(hl), a
	ld	l, c
	ld	h, b
	inc	hl
	inc	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, e
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ldhl	sp,	#11
	ld	(hl-), a
;src/states/game.c:360: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00154$
;src/states/game.c:361: dx = -dx;
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
00154$:
;src/states/game.c:362: if (dy < 0)
	ldhl	sp,	#10
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00156$
;src/states/game.c:363: dy = -dy;
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
00156$:
;src/states/game.c:364: if (dx < 10 && dy < 10) {
	ldhl	sp,	#8
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
	jr	NC, 00218$
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
	jr	NC, 00218$
;src/states/game.c:365: player_hit();
	call	_player_hit
;src/states/game.c:366: return;
	jp	00222$
00218$:
;src/states/game.c:355: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#6
	inc	(hl)
	jp	NZ, 00217$
	inc	hl
	inc	(hl)
	jp	00217$
00163$:
;src/states/game.c:371: entity_render_all(current_map->entities, current_map->num_entities, camera_x,
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
	ldhl	sp,	#14
	ld	a, (hl)
	ld	e, c
	ld	d, b
	call	_entity_render_all
;src/states/game.c:374: if (input_pressed(J_A | J_B)) {
	ld	a, #0x30
	call	_input_pressed
	or	a, a
	jp	Z, 00209$
;src/states/game.c:375: for (int i = 0; i < current_map->num_entities; i++) {
	xor	a, a
	ldhl	sp,	#6
	ld	(hl+), a
	ld	(hl), a
00220$:
;src/states/game.c:332: entity_update_all(current_map->entities, current_map->num_entities);
	ld	a, (#_current_map)
	ldhl	sp,	#8
	ld	(hl), a
	ld	a, (#_current_map + 1)
	ldhl	sp,	#9
;src/states/game.c:375: for (int i = 0; i < current_map->num_entities; i++) {
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
	jr	Z, 00718$
	bit	7, d
	jr	NZ, 00719$
	cp	a, a
	jr	00719$
00718$:
	bit	7, d
	jr	Z, 00719$
	scf
00719$:
	jp	NC, 00187$
;src/states/game.c:376: entity_t *e = &current_map->entities[i];
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
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	d, (hl)
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	add	a, a
	rl	d
	ld	e, a
	ldhl	sp,	#10
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, de
	inc	sp
	inc	sp
	push	hl
;src/states/game.c:377: int16_t dx = (int16_t)player_x - (int16_t)e->x,
	ld	a, (#_player_x)
	ldhl	sp,	#4
	ld	(hl), a
	ld	a, (#_player_x + 1)
	ldhl	sp,	#5
	ld	(hl), a
	pop	de
	push	de
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl), a
	ldhl	sp,#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ldhl	sp,	#10
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
;src/states/game.c:378: dy = (int16_t)player_y - (int16_t)e->y;
	ld	a, (#_player_y)
	ldhl	sp,	#2
	ld	(hl), a
	ld	a, (#_player_y + 1)
	ldhl	sp,	#3
	ld	(hl), a
	pop	bc
	push	bc
	inc	bc
	inc	bc
	ld	e, c
	ld	d, b
	ld	a, (de)
	ldhl	sp,	#10
	ld	(hl+), a
	inc	de
	ld	a, (de)
	ld	(hl-), a
	ld	a, (hl)
	ldhl	sp,	#4
	ld	(hl), a
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#5
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
	ldhl	sp,	#11
	ld	(hl-), a
;src/states/game.c:379: if (dx < 0)
	ld	a, e
	ld	(hl-), a
	dec	hl
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00165$
;src/states/game.c:380: dx = -dx;
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
00165$:
;src/states/game.c:381: if (dy < 0)
	ldhl	sp,	#10
	ld	a, (hl+)
	bit	7, (hl)
	jr	Z, 00167$
;src/states/game.c:382: dy = -dy;
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
00167$:
;src/states/game.c:383: if (dx < 24 && dy < 24) {
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
	jp	NC, 00221$
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
	jp	NC, 00221$
;src/states/game.c:384: if (input_pressed(J_A)) {
	ld	a, #0x10
	call	_input_pressed
	ldhl	sp,	#11
	ld	(hl), a
;src/states/game.c:385: if (e->type == ENT_NPC) {
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
;src/states/game.c:387: if (e->sprite_base == 36 && inventory_has_item("FLOR")) {
	pop	de
	push	de
	ld	hl, #0x0007
	add	hl, de
	ld	c, l
	ld	b, h
;src/states/game.c:384: if (input_pressed(J_A)) {
	ldhl	sp,	#11
	ld	a, (hl)
	or	a, a
	jr	Z, 00176$
;src/states/game.c:385: if (e->type == ENT_NPC) {
	dec	hl
	dec	hl
	dec	hl
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	or	a, a
	jr	NZ, 00176$
;src/states/game.c:387: if (e->sprite_base == 36 && inventory_has_item("FLOR")) {
	ld	a, (bc)
	sub	a, #0x24
	jr	NZ, 00169$
	push	bc
	ld	de, #___str_0
	call	_inventory_has_item
	pop	bc
	or	a, a
	jr	Z, 00169$
;src/states/game.c:388: text_dialogue(DIALOGUE_FLOWER_THANKS);
	push	bc
	ld	de, #___str_1
	call	_text_dialogue
	pop	bc
	jr	00176$
00169$:
;src/states/game.c:390: text_dialogue(e->dialogue);
	pop	de
	push	de
	ld	hl, #0x0005
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
	ld	l, a
	inc	de
	ld	a, (de)
	push	bc
	ld	e, l
	ld	d, a
	call	_text_dialogue
	pop	bc
;src/states/game.c:392: } else if (e->type == ENT_ITEM) {
00176$:
;src/states/game.c:396: if (input_pressed(J_B)) {
	push	bc
	ld	a, #0x20
	call	_input_pressed
	pop	bc
	or	a, a
	jr	Z, 00221$
;src/states/game.c:397: if (e->type == ENT_ITEM && e->active) {
	ldhl	sp,#8
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	a, (de)
	dec	a
	jr	NZ, 00221$
	pop	de
	push	de
	ld	hl, #0x0008
	add	hl, de
	ld	e, l
	ld	d, h
	ld	a, (de)
	or	a, a
	jr	Z, 00221$
;src/states/game.c:400: if (e->sprite_base == 41) {
	ld	a, (bc)
	sub	a, #0x29
	jr	NZ, 00221$
;src/states/game.c:401: inventory_add_item("FLOR", "UNA HERMOSA\nFLOR SILVESTRE", 41);
	push	de
	ld	a, #0x29
	push	af
	inc	sp
	ld	bc, #___str_2
	ld	de, #___str_0
	call	_inventory_add_item
;src/states/game.c:402: sfx_pickup();
	call	_sfx_pickup
	pop	de
;src/states/game.c:403: e->active = 0; // Remove from map
	xor	a, a
	ld	(de), a
00221$:
;src/states/game.c:375: for (int i = 0; i < current_map->num_entities; i++) {
	ldhl	sp,	#6
	inc	(hl)
	jp	NZ, 00220$
	inc	hl
	inc	(hl)
	jp	00220$
00187$:
;src/states/game.c:411: uint8_t tid = get_tile_at(player_x + 8, player_y);
	ld	a, (_player_x)
	ld	hl, #_player_x + 1
	ld	d, (hl)
	add	a, #0x08
	ld	e, a
	jr	NC, 00728$
	inc	d
00728$:
	ld	a, (_player_y)
	ld	c, a
	ld	hl, #_player_y + 1
	ld	b, (hl)
	call	_get_tile_at
	ldhl	sp,	#10
	ld	(hl), a
;src/states/game.c:412: if (player_dir == 1)
	ld	a, (#_player_dir)
	dec	a
	jr	NZ, 00189$
;src/states/game.c:413: tid = get_tile_at(player_x + 8, player_y - 4);
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
	jr	NC, 00731$
	inc	d
00731$:
	call	_get_tile_at
	ldhl	sp,	#10
	ld	(hl), a
00189$:
;src/states/game.c:415: if (current_map == &maps[1] && // HOUSE_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<((_maps + 26))
	jr	NZ, 00196$
	inc	hl
	ld	a, (hl)
	sub	a, #>((_maps + 26))
	jr	NZ, 00196$
;src/states/game.c:416: (tid == 31 || tid == 32 || tid == 33 || tid == 34)) {
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x1f
	jr	Z, 00195$
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x20
	jr	Z, 00195$
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x21
	jr	Z, 00195$
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x22
	jr	NZ, 00196$
00195$:
;src/states/game.c:417: if (input_pressed(J_B)) {
	ld	a, #0x20
	call	_input_pressed
	or	a, a
	jr	Z, 00196$
;src/states/game.c:418: if (!inventory_has_item("LLAVE")) {
	ld	de, #___str_3
	call	_inventory_has_item
	ldhl	sp,#11
	ld	(hl), a
	ld	a, (hl)
	or	a, a
	jr	NZ, 00191$
;src/states/game.c:419: text_dialogue(DIALOGUE_FOUND_KEY);
	ld	de, #___str_4
	call	_text_dialogue
;src/states/game.c:420: inventory_add_item("LLAVE", "ABRE EL PORTON NORTE", 41);
	ld	a, #0x29
	push	af
	inc	sp
	ld	bc, #___str_5
	ld	de, #___str_3
	call	_inventory_add_item
;src/states/game.c:421: sfx_pickup();
	call	_sfx_pickup
	jr	00196$
00191$:
;src/states/game.c:423: text_dialogue(DIALOGUE_EMPTY_CHEST);
	ld	de, #___str_6
	call	_text_dialogue
00196$:
;src/states/game.c:427: if (current_map == &maps[0] && (tid == 38 || tid == 39)) { // WORLD_MAP
	ld	hl, #_current_map
	ld	a, (hl)
	sub	a, #<(_maps)
	jr	NZ, 00209$
	inc	hl
	ld	a, (hl)
	sub	a, #>(_maps)
	jr	NZ, 00209$
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x26
	jr	Z, 00204$
	ldhl	sp,	#10
	ld	a, (hl)
	sub	a, #0x27
	jr	NZ, 00209$
00204$:
;src/states/game.c:428: if (inventory_has_item("LLAVE")) {
	ld	de, #___str_3
	call	_inventory_has_item
	or	a, a
	jr	Z, 00202$
;src/states/game.c:429: text_dialogue(DIALOGUE_USE_KEY);
	ld	de, #___str_7
	call	_text_dialogue
;src/states/game.c:430: sfx_success();
	call	_sfx_success
;src/states/game.c:431: switch_map(&maps[2], 128, 224); // LEVEL2_MAP
	ld	de, #0x00e0
	push	de
	ld	bc, #0x0080
	ld	de, #(_maps + 52)
	call	_switch_map
;src/states/game.c:432: return;
	jr	00222$
00202$:
;src/states/game.c:434: text_dialogue(DIALOGUE_LOCKED_GATE);
	ld	de, #___str_8
	call	_text_dialogue
00209$:
;src/states/game.c:439: if ((env_anim_timer % 32) == 0) {
	ld	a, (_env_anim_timer)
	and	a, #0x1f
	jr	NZ, 00211$
;src/states/game.c:440: env_anim_frame = !env_anim_frame;
	ld	hl, #_env_anim_frame
	ld	a, (hl)
	sub	a, #0x01
	ld	a, #0x00
	rla
	ld	(hl), a
;src/states/game.c:444: set_bkg_data(2, 1, env_anim_frame ? &tiles_anim_data[0] : &tiles_data[32]);
	ld	a, (hl)
	or	a, a
	jr	Z, 00228$
	ld	bc, #_tiles_anim_data+0
	jr	00229$
00228$:
	ld	bc, #_tiles_data+32
00229$:
	push	bc
	ld	hl, #0x102
	push	hl
	call	_set_bkg_data
	add	sp, #4
00211$:
;src/states/game.c:446: env_anim_timer++;
	ld	hl, #_env_anim_timer
	inc	(hl)
00222$:
;src/states/game.c:447: }
	add	sp, #12
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
	.ascii "UNA HERMOSA"
	.db 0x0a
	.ascii "FLOR SILVESTRE"
	.db 0x00
___str_3:
	.ascii "LLAVE"
	.db 0x00
___str_4:
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
___str_5:
	.ascii "ABRE EL PORTON NORTE"
	.db 0x00
___str_6:
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
___str_7:
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
___str_8:
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
__xinit__game_ready:
	.db #0x00	; 0
	.area _CABS (ABS)
