;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _inventory_init
	.globl _input_pressed
	.globl _input_update
	.globl _wait_vbl_done
	.globl _gameover_update
	.globl _gameover_init
	.globl _inventory_state_update
	.globl _inventory_state_init
	.globl _game_update
	.globl _game_init
	.globl _menu_update
	.globl _menu_init
	.globl _intro_update
	.globl _intro_init
	.globl _current_state
	.globl _game_state
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
_game_state::
	.ds 1
_current_state::
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
;src/main.c:11: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:13: inventory_init();
	call	_inventory_init
;src/main.c:16: while (1) {
00134$:
;src/main.c:18: input_update();
	call	_input_update
;src/main.c:21: if (game_state != current_state) {
	ld	a, (#_game_state)
	ld	hl, #_current_state
	sub	a, (hl)
	jr	Z, 00116$
;src/main.c:23: current_state = game_state;
	ld	a, (#_game_state)
	ld	(#_current_state),a
;src/main.c:24: if (game_state == STATE_INTRO) {
	ld	a, (#_game_state)
	or	a, a
	jr	NZ, 00113$
;src/main.c:25: intro_init();
	call	_intro_init
	jr	00116$
00113$:
;src/main.c:26: } else if (game_state == STATE_MENU) {
	ld	a, (#_game_state)
	dec	a
	jr	NZ, 00110$
;src/main.c:27: menu_init();
	call	_menu_init
	jr	00116$
00110$:
;src/main.c:28: } else if (game_state == STATE_GAME) {
	ld	a, (#_game_state)
	sub	a, #0x02
	jr	NZ, 00107$
;src/main.c:29: game_init();
	call	_game_init
	jr	00116$
00107$:
;src/main.c:30: } else if (game_state == STATE_INVENTORY) {
	ld	a, (#_game_state)
	sub	a, #0x03
	jr	NZ, 00104$
;src/main.c:31: inventory_state_init();
	call	_inventory_state_init
	jr	00116$
00104$:
;src/main.c:32: } else if (game_state == STATE_GAMEOVER) {
	ld	a, (#_game_state)
	sub	a, #0x04
	jr	NZ, 00116$
;src/main.c:33: gameover_init();
	call	_gameover_init
00116$:
;src/main.c:38: if (game_state == STATE_INTRO) {
	ld	a, (#_game_state)
	or	a, a
	jr	NZ, 00131$
;src/main.c:39: intro_update();
	call	_intro_update
	jr	00132$
00131$:
;src/main.c:40: } else if (game_state == STATE_MENU) {
	ld	a, (#_game_state)
	dec	a
	jr	NZ, 00128$
;src/main.c:41: menu_update();
	call	_menu_update
;src/main.c:42: if (input_pressed(J_START)) {
	ld	a, #0x80
	call	_input_pressed
	or	a, a
	jr	Z, 00132$
;src/main.c:43: game_state = STATE_GAME;
	ld	hl, #_game_state
	ld	(hl), #0x02
	jr	00132$
00128$:
;src/main.c:45: } else if (game_state == STATE_GAME) {
	ld	a, (#_game_state)
	sub	a, #0x02
	jr	NZ, 00125$
;src/main.c:46: game_update();
	call	_game_update
	jr	00132$
00125$:
;src/main.c:47: } else if (game_state == STATE_INVENTORY) {
	ld	a, (#_game_state)
	sub	a, #0x03
	jr	NZ, 00122$
;src/main.c:48: inventory_state_update();
	call	_inventory_state_update
	jr	00132$
00122$:
;src/main.c:49: } else if (game_state == STATE_GAMEOVER) {
	ld	a, (#_game_state)
	sub	a, #0x04
	jr	NZ, 00132$
;src/main.c:50: gameover_update();
	call	_gameover_update
00132$:
;src/main.c:54: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:56: }
	jp	00134$
	.area _CODE
	.area _INITIALIZER
__xinit__game_state:
	.db #0x00	; 0
__xinit__current_state:
	.db #0xff	; 255
	.area _CABS (ABS)
