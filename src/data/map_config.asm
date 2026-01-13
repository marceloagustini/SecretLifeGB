;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module map_config
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _map_init_data
	.globl _entity_init
	.globl _maps
	.globl _level2_portals
	.globl _house_portals
	.globl _world_portals
	.globl _level2_entities
	.globl _house_entities
	.globl _world_entities
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
	.area _HRAM
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_world_entities::
	.ds 15
_house_entities::
	.ds 15
_level2_entities::
	.ds 15
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_world_portals::
	.ds 7
_house_portals::
	.ds 7
_level2_portals::
	.ds 7
_maps::
	.ds 78
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
;src/data/map_config.c:53: void map_init_data() {
;	---------------------------------
; Function map_init_data
; ---------------------------------
_map_init_data::
;src/data/map_config.c:54: entity_init(&world_entities[0], ENT_NPC, 210, 230, 24, DIALOGUE_NPC_CHILD);
	ld	de, #___str_0
	push	de
	ld	a, #0x18
	push	af
	inc	sp
	ld	de, #0x00e6
	push	de
	ld	de, #0x00d2
	push	de
	xor	a, a
	ld	de, #_world_entities
	call	_entity_init
;src/data/map_config.c:55: entity_init(&house_entities[0], ENT_NPC, 40, 48, 24, DIALOGUE_NPC_HOUSE);
	ld	de, #___str_1
	push	de
	ld	a, #0x18
	push	af
	inc	sp
	ld	de, #0x0030
	push	de
	ld	de, #0x0028
	push	de
	xor	a, a
	ld	de, #_house_entities
	call	_entity_init
;src/data/map_config.c:56: entity_init(&level2_entities[0], ENT_ENEMY, 120, 120, 28, NULL);
	ld	de, #0x0000
	push	de
	ld	a, #0x1c
	push	af
	inc	sp
	ld	de, #0x0078
	push	de
	push	de
	ld	a, #0x03
	ld	de, #_level2_entities
	call	_entity_init
;src/data/map_config.c:57: }
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
	.area _CODE
	.area _INITIALIZER
__xinit__world_portals:
	.db #0x0c	; 12
	.db #0x0c	; 12
	.db #0x01	; 1
	.dw #0x004c
	.dw #0x0070
__xinit__house_portals:
	.db #0x05	; 5
	.db #0x0e	; 14
	.db #0x00	; 0
	.dw #0x00d2
	.dw #0x00f6
__xinit__level2_portals:
	.db #0x10	; 16
	.db #0x1f	; 31
	.db #0x00	; 0
	.dw #0x007c
	.dw #0x0030
__xinit__maps:
	.dw _map_data
	.db #0x20	; 32
	.db #0x20	; 32
	.dw _world_entities
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x46	; 70	'F'
	.db #0x47	; 71	'G'
	.db #0xff	; 255
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.dw #0x0000
	.db #0x00	; 0
	.dw _house_map
	.db #0x14	; 20
	.db #0x12	; 18
	.dw _house_entities
	.db #0x01	; 1
	.db #0x19	; 25
	.db #0x23	; 35
	.db #0xff	; 255
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.dw #0x0000
	.db #0x00	; 0
	.dw _level2_map
	.db #0x20	; 32
	.db #0x20	; 32
	.dw _level2_entities
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0xff	; 255
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.db 0x00
	.dw #0x0000
	.db #0x00	; 0
	.area _CABS (ABS)
