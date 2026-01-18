;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler
; Version 4.5.1 #15267 (Mac OS X ppc)
;--------------------------------------------------------
	.module map_config
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _map_init_data
	.globl _ai_enemy_chaser_shooter
	.globl _ai_anim_simple
	.globl _entity_init
	.globl _maps
	.globl _level2_portals
	.globl _house_portals
	.globl _world_portals
	.globl _void_entities
	.globl _sanctuary_entities
	.globl _maze_entities
	.globl _level3_entities
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
	.ds 57
_house_entities::
	.ds 19
_level2_entities::
	.ds 19
_level3_entities::
	.ds 38
_maze_entities::
	.ds 19
_sanctuary_entities::
	.ds 19
_void_entities::
	.ds 19
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
	.ds 182
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
;src/data/map_config.c:93: void map_init_data() {
;	---------------------------------
; Function map_init_data
; ---------------------------------
_map_init_data::
;src/data/map_config.c:94: entity_init(&world_entities[0], ENT_NPC, 210, 230, 24, DIALOGUE_NPC_CHILD);
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
;src/data/map_config.c:95: entity_init(&world_entities[1], ENT_NPC, 160, 120, 36, DIALOGUE_NPC_WOMAN);
	ld	de, #___str_1
	push	de
	ld	a, #0x24
	push	af
	inc	sp
	ld	de, #0x0078
	push	de
	xor	a, a
	and	a
	push	af
	xor	a, a
	ld	de, #(_world_entities + 19)
	call	_entity_init
;src/data/map_config.c:96: entity_init(&world_entities[2], ENT_ITEM, 180, 140, 49,
	ld	de, #0x0000
	push	de
	ld	a, #0x31
	push	af
	inc	sp
	ld	de, #0x008c
	push	de
	ld	de, #0x00b4
	push	de
	ld	a, #0x01
	ld	de, #(_world_entities + 38)
	call	_entity_init
;src/data/map_config.c:98: world_entities[2].update = ai_anim_simple;
	ld	hl, #(_world_entities + 55)
	ld	(hl), #<(_ai_anim_simple)
	inc	hl
	ld	(hl), #>(_ai_anim_simple)
;src/data/map_config.c:99: entity_init(&house_entities[0], ENT_NPC, 40, 48, 24, DIALOGUE_NPC_HOUSE);
	ld	de, #___str_2
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
;src/data/map_config.c:100: entity_init(&level2_entities[0], ENT_ENEMY, 120, 120, 28, NULL);
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
;src/data/map_config.c:101: level2_entities[0].update = ai_enemy_chaser_shooter;
	ld	hl, #(_level2_entities + 17)
	ld	(hl), #<(_ai_enemy_chaser_shooter)
	inc	hl
	ld	(hl), #>(_ai_enemy_chaser_shooter)
;src/data/map_config.c:102: level2_entities[0].shoot_timer = 60;
	ld	hl, #_level2_entities + 13
	ld	(hl), #0x3c
;src/data/map_config.c:105: "BIENVENIDO AL\nPUEBLO SENSEI");
;src/data/map_config.c:104: entity_init(&level3_entities[0], ENT_NPC, 128, 128, 36,
	ld	de, #___str_3
	push	de
	ld	a, #0x24
	push	af
	inc	sp
	xor	a, a
	push	af
	xor	a, a
	push	af
	xor	a, a
	ld	de, #_level3_entities
	call	_entity_init
;src/data/map_config.c:106: entity_init(&level3_entities[1], ENT_NPC, 200, 100, 24, "HOLA VIAJERO");
	ld	de, #___str_4
	push	de
	ld	a, #0x18
	push	af
	inc	sp
	ld	de, #0x0064
	push	de
	ld	de, #0x00c8
	push	de
	xor	a, a
	ld	de, #(_level3_entities + 19)
	call	_entity_init
;src/data/map_config.c:108: entity_init(&maze_entities[0], ENT_ITEM, 128, 128, 49, "ARMA");
	ld	de, #___str_5
	push	de
	ld	a, #0x31
	push	af
	inc	sp
	xor	a, a
	push	af
	xor	a, a
	push	af
	ld	a, #0x01
	ld	de, #_maze_entities
	call	_entity_init
;src/data/map_config.c:111: "ESTAS A SALVO\nTOCA EL ALTAR");
;src/data/map_config.c:110: entity_init(&sanctuary_entities[0], ENT_NPC, 76, 64, 36,
	ld	de, #___str_6
	push	de
	ld	a, #0x24
	push	af
	inc	sp
	ld	de, #0x0040
	push	de
	ld	de, #0x004c
	push	de
	xor	a, a
	ld	de, #_sanctuary_entities
	call	_entity_init
;src/data/map_config.c:113: entity_init(&void_entities[0], ENT_PORTAL, 480, 480, 41, NULL);
	ld	de, #0x0000
	push	de
	ld	a, #0x29
	push	af
	inc	sp
	ld	de, #0x01e0
	push	de
	push	de
	ld	a, #0x04
	ld	de, #_void_entities
	call	_entity_init
;src/data/map_config.c:114: }
	ret
___str_0:
	.ascii "Hola DogDog! Por"
	.db 0x0a
	.ascii "lo que pude saber,"
	.db 0x0a
	.ascii "es TikTokClock."
	.db 0x0a
	.ascii "En la oficina de"
	.db 0x0a
	.ascii "la agencia arriba,"
	.db 0x0a
	.ascii "junto al gran arbol.En el armario"
	.db 0x0a
	.ascii "tienes la llave"
	.db 0x0a
	.ascii "para salir de las"
	.db 0x0a
	.ascii "agencias. Pero ten"
	.db 0x0a
	.ascii "cuidado con los"
	.db 0x0a
	.ascii "enemigos que hay"
	.db 0x0a
	.ascii "en la zona. El lo"
	.db 0x0a
	.ascii "sabe todo! Suerte"
	.db 0x0a
	.ascii "en tu aventura!"
	.db 0x00
___str_1:
	.ascii "Hola DogDog. Soy"
	.db 0x0a
	.ascii "UMA tu asistente."
	.db 0x0a
	.ascii "TikTokClock quiere"
	.db 0x0a
	.ascii "acelerar el tiempo"
	.db 0x0a
	.ascii "del universo."
	.db 0x0a
	.ascii "Debemos evitarlo,"
	.db 0x0a
	.ascii "es muy peligroso. "
	.db 0x0a
	.ascii "Nadie sabe por que"
	.db 0x0a
	.ascii "pero el tiene las"
	.db 0x0a
	.ascii "herramientas..."
	.db 0x0a
	.ascii "Nuestra vida seria"
	.db 0x0a
	.ascii "mas corta y nos"
	.db 0x0a
	.ascii "volveriamos viejos"
	.db 0x0a
	.ascii "muy pronto. Debes"
	.db 0x0a
	.ascii "actuar ahora! Ten"
	.db 0x0a
	.ascii "mucho cuidado, un"
	.db 0x0a
	.ascii "secuaz enemigo te"
	.db 0x0a
	.ascii "espera al salir."
	.db 0x00
___str_2:
	.ascii "Hola DogDog! Toma"
	.db 0x0a
	.ascii "lo que quieras."
	.db 0x0a
	.ascii "El enemigo es muy"
	.db 0x0a
	.ascii "bravo, nadie puede"
	.db 0x0a
	.ascii "salir de aqui."
	.db 0x0a
	.ascii "Si logras abrir el"
	.db 0x0a
	.ascii "portal podremos"
	.db 0x0a
	.ascii "llegar lejos."
	.db 0x0a
	.ascii "Confiamos en ti y"
	.db 0x0a
	.ascii "tus habilidades"
	.db 0x0a
	.ascii "para salvarnos!"
	.db 0x00
___str_3:
	.ascii "BIENVENIDO AL"
	.db 0x0a
	.ascii "PUEBLO SENSEI"
	.db 0x00
___str_4:
	.ascii "HOLA VIAJERO"
	.db 0x00
___str_5:
	.ascii "ARMA"
	.db 0x00
___str_6:
	.ascii "ESTAS A SALVO"
	.db 0x0a
	.ascii "TOCA EL ALTAR"
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
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0xff	; 255
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
	.dw _level3_map
	.db #0x20	; 32
	.db #0x20	; 32
	.dw _level3_entities
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x02	; 2
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
	.dw _maze_map
	.db #0x20	; 32
	.db #0x20	; 32
	.dw _maze_entities
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x2b	; 43
	.db #0x2c	; 44
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
	.dw #0x0000
	.db #0x00	; 0
	.dw _sanctuary_map
	.db #0x14	; 20
	.db #0x12	; 18
	.dw _sanctuary_entities
	.db #0x01	; 1
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
	.db 0x00
	.dw #0x0000
	.db #0x00	; 0
	.dw _void_map
	.db #0x40	; 64
	.db #0x40	; 64
	.dw _void_entities
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x02	; 2
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
	.area _CABS (ABS)
