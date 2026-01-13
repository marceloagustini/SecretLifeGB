;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module main
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _input_pressed
	.globl _input_update
	.globl _wait_vbl_done
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
;src/main.c:15: void main(void) {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:20: while (1) {
00122$:
;src/main.c:22: input_update();
	call	_input_update
;src/main.c:25: if (game_state != current_state) {
	ld	a, (#_game_state)
	ld	hl, #_current_state
	sub	a, (hl)
	jr	Z, 00110$
;src/main.c:27: current_state = game_state;
	ld	a, (#_game_state)
	ld	(#_current_state),a
;src/main.c:28: if (game_state == STATE_INTRO) {
	ld	a, (#_game_state)
	or	a, a
	jr	NZ, 00107$
;src/main.c:29: intro_init();
	call	_intro_init
	jr	00110$
00107$:
;src/main.c:30: } else if (game_state == STATE_MENU) {
	ld	a, (#_game_state)
	dec	a
	jr	NZ, 00104$
;src/main.c:31: menu_init();
	call	_menu_init
	jr	00110$
00104$:
;src/main.c:32: } else if (game_state == STATE_GAME) {
	ld	a, (#_game_state)
	sub	a, #0x02
	jr	NZ, 00110$
;src/main.c:33: game_init();
	call	_game_init
00110$:
;src/main.c:38: if (game_state == STATE_INTRO) {
	ld	a, (#_game_state)
	or	a, a
	jr	NZ, 00119$
;src/main.c:39: intro_update();
	call	_intro_update
	jr	00120$
00119$:
;src/main.c:40: } else if (game_state == STATE_MENU) {
	ld	a, (#_game_state)
	dec	a
	jr	NZ, 00116$
;src/main.c:41: menu_update();
	call	_menu_update
;src/main.c:42: if (input_pressed(J_START)) {
	ld	a, #0x80
	call	_input_pressed
	or	a, a
	jr	Z, 00120$
;src/main.c:43: game_state = STATE_GAME;
	ld	hl, #_game_state
	ld	(hl), #0x02
	jr	00120$
00116$:
;src/main.c:45: } else if (game_state == STATE_GAME) {
	ld	a, (#_game_state)
	sub	a, #0x02
	jr	NZ, 00120$
;src/main.c:46: game_update();
	call	_game_update
00120$:
;src/main.c:50: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:52: }
	jr	00122$
	.area _CODE
	.area _INITIALIZER
__xinit__game_state:
	.db #0x00	; 0
__xinit__current_state:
	.db #0xff	; 255
	.area _CABS (ABS)
