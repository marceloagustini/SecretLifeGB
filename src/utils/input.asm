;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module input
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _joypad
	.globl _joy_previous
	.globl _joy_current
	.globl _input_update
	.globl _input_pressed
	.globl _input_held
	.globl _input_released
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
_joy_current::
	.ds 1
_joy_previous::
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
;src/utils/input.c:6: void input_update(void) {
;	---------------------------------
; Function input_update
; ---------------------------------
_input_update::
;src/utils/input.c:7: joy_previous = joy_current;
	ld	a, (#_joy_current)
	ld	(#_joy_previous),a
;src/utils/input.c:8: joy_current = joypad();
	call	_joypad
	ld	(#_joy_current),a
;src/utils/input.c:9: }
	ret
;src/utils/input.c:11: uint8_t input_pressed(uint8_t button) {
;	---------------------------------
; Function input_pressed
; ---------------------------------
_input_pressed::
	ld	c, a
;src/utils/input.c:12: return (joy_current & button) && !(joy_previous & button);
	ld	a, (#_joy_current)
	and	a, c
	jr	Z, 00103$
	ld	a, (#_joy_previous)
	and	a, c
	jr	Z, 00104$
00103$:
	xor	a, a
	ret
00104$:
	ld	a, #0x01
;src/utils/input.c:13: }
	ret
;src/utils/input.c:15: uint8_t input_held(uint8_t button) { return (joy_current & button); }
;	---------------------------------
; Function input_held
; ---------------------------------
_input_held::
	ld	hl, #_joy_current
	and	a, (hl)
	ret
;src/utils/input.c:17: uint8_t input_released(uint8_t button) {
;	---------------------------------
; Function input_released
; ---------------------------------
_input_released::
	ld	c, a
;src/utils/input.c:18: return !(joy_current & button) && (joy_previous & button);
	ld	a, (#_joy_current)
	and	a, c
	jr	NZ, 00103$
	ld	a, (#_joy_previous)
	and	a, c
	jr	NZ, 00104$
00103$:
	xor	a, a
	ret
00104$:
	ld	a, #0x01
;src/utils/input.c:19: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__joy_current:
	.db #0x00	; 0
__xinit__joy_previous:
	.db #0x00	; 0
	.area _CABS (ABS)
