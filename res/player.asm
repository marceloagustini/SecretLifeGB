;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module player
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _player_sprites
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
	.area _CODE
_player_sprites:
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x43	; 67	'C'
	.db #0x7c	; 124
	.db #0x4f	; 79	'O'
	.db #0x70	; 112	'p'
	.db #0x4f	; 79	'O'
	.db #0x72	; 114	'r'
	.db #0x4f	; 79	'O'
	.db #0x70	; 112	'p'
	.db #0x27	; 39
	.db #0x38	; 56	'8'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0xc2	; 194
	.db #0x3e	; 62
	.db #0xf2	; 242
	.db #0x0e	; 14
	.db #0xf2	; 242
	.db #0x4e	; 78	'N'
	.db #0xf2	; 242
	.db #0x0e	; 14
	.db #0xe4	; 228
	.db #0x1c	; 28
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x27	; 39
	.db #0x3f	; 63
	.db #0x54	; 84	'T'
	.db #0x6f	; 111	'o'
	.db #0x77	; 119	'w'
	.db #0x6f	; 111	'o'
	.db #0x17	; 23
	.db #0x1f	; 31
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0xe4	; 228
	.db #0xfc	; 252
	.db #0x2a	; 42
	.db #0xf6	; 246
	.db #0xee	; 238
	.db #0xf6	; 246
	.db #0xe8	; 232
	.db #0xf8	; 248
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x43	; 67	'C'
	.db #0x7c	; 124
	.db #0x4f	; 79	'O'
	.db #0x70	; 112	'p'
	.db #0x4f	; 79	'O'
	.db #0x72	; 114	'r'
	.db #0x4f	; 79	'O'
	.db #0x70	; 112	'p'
	.db #0x27	; 39
	.db #0x38	; 56	'8'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0xc2	; 194
	.db #0x3e	; 62
	.db #0xf2	; 242
	.db #0x0e	; 14
	.db #0xf2	; 242
	.db #0x4e	; 78	'N'
	.db #0xf2	; 242
	.db #0x0e	; 14
	.db #0xe4	; 228
	.db #0x1c	; 28
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x27	; 39
	.db #0x3f	; 63
	.db #0x54	; 84	'T'
	.db #0x6f	; 111	'o'
	.db #0x77	; 119	'w'
	.db #0x6f	; 111	'o'
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0xe4	; 228
	.db #0xfc	; 252
	.db #0x2a	; 42
	.db #0xf6	; 246
	.db #0xee	; 238
	.db #0xf6	; 246
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x4f	; 79	'O'
	.db #0x7f	; 127
	.db #0x30	; 48	'0'
	.db #0x3f	; 63
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0xf2	; 242
	.db #0xfe	; 254
	.db #0x0c	; 12
	.db #0xfc	; 252
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x27	; 39
	.db #0x3f	; 63
	.db #0x54	; 84	'T'
	.db #0x6f	; 111	'o'
	.db #0x77	; 119	'w'
	.db #0x6f	; 111	'o'
	.db #0x17	; 23
	.db #0x1f	; 31
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0xe4	; 228
	.db #0xfc	; 252
	.db #0x2a	; 42
	.db #0xf6	; 246
	.db #0xee	; 238
	.db #0xf6	; 246
	.db #0xe8	; 232
	.db #0xf8	; 248
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x11	; 17
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x40	; 64
	.db #0x7f	; 127
	.db #0x4f	; 79	'O'
	.db #0x7f	; 127
	.db #0x30	; 48	'0'
	.db #0x3f	; 63
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x88	; 136
	.db #0xf8	; 248
	.db #0x04	; 4
	.db #0xfc	; 252
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0x02	; 2
	.db #0xfe	; 254
	.db #0xf2	; 242
	.db #0xfe	; 254
	.db #0x0c	; 12
	.db #0xfc	; 252
	.db #0x18	; 24
	.db #0x1f	; 31
	.db #0x27	; 39
	.db #0x3f	; 63
	.db #0x54	; 84	'T'
	.db #0x6f	; 111	'o'
	.db #0x77	; 119	'w'
	.db #0x6f	; 111	'o'
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0a	; 10
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x18	; 24
	.db #0xf8	; 248
	.db #0xe4	; 228
	.db #0xfc	; 252
	.db #0x2a	; 42
	.db #0xf6	; 246
	.db #0xee	; 238
	.db #0xf6	; 246
	.db #0x50	; 80	'P'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x13	; 19
	.db #0x1f	; 31
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x09	; 9
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x84	; 132
	.db #0x7c	; 124
	.db #0xc4	; 196
	.db #0x3c	; 60
	.db #0xc8	; 200
	.db #0x38	; 56	'8'
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x14	; 20
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x1b	; 27
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x38	; 56	'8'
	.db #0xe8	; 232
	.db #0x38	; 56	'8'
	.db #0xe8	; 232
	.db #0x30	; 48	'0'
	.db #0xd0	; 208
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x13	; 19
	.db #0x1f	; 31
	.db #0x17	; 23
	.db #0x18	; 24
	.db #0x0f	; 15
	.db #0x09	; 9
	.db #0x0f	; 15
	.db #0x08	; 8
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x20	; 32
	.db #0xe0	; 224
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x08	; 8
	.db #0xf8	; 248
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x84	; 132
	.db #0x7c	; 124
	.db #0xc4	; 196
	.db #0x3c	; 60
	.db #0xc8	; 200
	.db #0x38	; 56	'8'
	.db #0x04	; 4
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x0f	; 15
	.db #0x14	; 20
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x1b	; 27
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x10	; 16
	.db #0xf0	; 240
	.db #0x38	; 56	'8'
	.db #0xe8	; 232
	.db #0x38	; 56	'8'
	.db #0xe8	; 232
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x30	; 48	'0'
	.db #0xd0	; 208
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.area _INITIALIZER
	.area _CABS (ABS)
