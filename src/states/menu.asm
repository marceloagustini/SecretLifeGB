;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module menu
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _puts
	.globl _printf
	.globl _input_pressed
	.globl _display_off
	.globl _wait_vbl_done
	.globl _menu_init
	.globl _menu_update
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
;src/states/menu.c:8: void menu_init(void) {
;	---------------------------------
; Function menu_init
; ---------------------------------
_menu_init::
;src/states/menu.c:9: wait_vbl_done();
	call	_wait_vbl_done
;src/states/menu.c:11: DISPLAY_OFF;
	call	_display_off
;src/states/menu.c:14: BGP_REG = 0xE4;
	ld	a, #0xe4
	ldh	(_BGP_REG + 0), a
;src/states/menu.c:22: printf("\n\n");
	ld	de, #___str_11
	call	_puts
;src/states/menu.c:23: printf("   PRESS START");
	ld	de, #___str_8
	push	de
	call	_printf
	pop	hl
;src/states/menu.c:26: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/states/menu.c:27: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;src/states/menu.c:28: }
	ret
___str_8:
	.ascii "   PRESS START"
	.db 0x00
___str_11:
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.db 0x0a
	.ascii "   GAMEBOY ZELDA"
	.db 0x0a
	.ascii "      LIKE"
	.db 0x0a
	.db 0x0a
	.db 0x00
;src/states/menu.c:30: void menu_update(void) {
;	---------------------------------
; Function menu_update
; ---------------------------------
_menu_update::
;src/states/menu.c:31: if (input_pressed(J_START)) {
	ld	a, #0x80
;src/states/menu.c:39: }
	jp	_input_pressed
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
