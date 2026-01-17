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
	.ds 156
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
;src/data/map_config.c:83: void map_init_data() {
;	---------------------------------
; Function map_init_data
; ---------------------------------
_map_init_data::
;src/data/map_config.c:84: entity_init(&world_entities[0], ENT_NPC, 210, 230, 24, DIALOGUE_NPC_CHILD);
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
;src/data/map_config.c:85: entity_init(&world_entities[1], ENT_NPC, 160, 120, 36, DIALOGUE_NPC_WOMAN);
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
;src/data/map_config.c:86: entity_init(&world_entities[2], ENT_ITEM, 180, 140, 49, NULL); // Flower at 49
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
;src/data/map_config.c:87: world_entities[2].update = ai_anim_simple;
	ld	hl, #(_world_entities + 55)
	ld	(hl), #<(_ai_anim_simple)
	inc	hl
	ld	(hl), #>(_ai_anim_simple)
;src/data/map_config.c:88: entity_init(&house_entities[0], ENT_NPC, 40, 48, 24, DIALOGUE_NPC_HOUSE);
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
;src/data/map_config.c:89: entity_init(&level2_entities[0], ENT_ENEMY, 120, 120, 28, NULL);
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
;src/data/map_config.c:90: level2_entities[0].update = ai_enemy_chaser_shooter;
	ld	hl, #(_level2_entities + 17)
	ld	(hl), #<(_ai_enemy_chaser_shooter)
	inc	hl
	ld	(hl), #>(_ai_enemy_chaser_shooter)
;src/data/map_config.c:91: level2_entities[0].shoot_timer = 60;
	ld	hl, #_level2_entities + 13
	ld	(hl), #0x3c
;src/data/map_config.c:93: entity_init(&level3_entities[0], ENT_PORTAL, 128, 128, 41, NULL);
	ld	de, #0x0000
	push	de
	ld	a, #0x29
	push	af
	inc	sp
	xor	a, a
	push	af
	xor	a, a
	push	af
	ld	a, #0x04
	ld	de, #_level3_entities
	call	_entity_init
;src/data/map_config.c:94: }
	ret
___str_0:
	.ascii "Hola aventurero!"
	.db 0x0a
	.ascii "Bienvenido a este"
	.db 0x0a
	.ascii "lugar misterioso."
	.db 0x0a
	.ascii "Mi casa es la de"
	.db 0x0a
	.ascii "aqui arriba, junto"
	.db 0x0a
	.ascii "al gran arbol."
	.db 0x0a
	.ascii "Si necesitas algo"
	.db 0x0a
	.ascii "busca la llave en"
	.db 0x0a
	.ascii "mi ropero."
	.db 0x0a
	.ascii "Pero ten cuidado"
	.db 0x0a
	.ascii "con los enemigos"
	.db 0x0a
	.ascii "que rondan por"
	.db 0x0a
	.ascii "la zona. Son muy"
	.db 0x0a
	.ascii "peligrosos!"
	.db 0x0a
	.ascii "Buena suerte en"
	.db 0x0a
	.ascii "tu aventura!"
	.db 0x00
___str_1:
	.ascii "Hola viajero."
	.db 0x0a
	.ascii "Bienvenido a estas"
	.db 0x0a
	.ascii "tierras olvidadas."
	.db 0x0a
	.ascii "Hace mucho tiempo,"
	.db 0x0a
	.ascii "este lugar era un"
	.db 0x0a
	.ascii "reino prospero."
	.db 0x0a
	.ascii "Pero un dia, una"
	.db 0x0a
	.ascii "oscura maldicion"
	.db 0x0a
	.ascii "cayo sobre nosotros."
	.db 0x0a
	.ascii "Los guardianes se"
	.db 0x0a
	.ascii "volvieron hostiles"
	.db 0x0a
	.ascii "y la gente huyo."
	.db 0x0a
	.ascii "Solo quedamos unos"
	.db 0x0a
	.ascii "pocos que aun"
	.db 0x0a
	.ascii "resistimos aqui."
	.db 0x0a
	.ascii "Si encuentras la"
	.db 0x0a
	.ascii "reliquia sagrada,"
	.db 0x0a
	.ascii "podras romper el"
	.db 0x0a
	.ascii "hechizo que nos"
	.db 0x0a
	.ascii "atormenta a todos"
	.db 0x0a
	.ascii "los habitantes."
	.db 0x0a
	.ascii "fortuna te acompane"
	.db 0x0a
	.ascii "en tu camino hacia"
	.db 0x0a
	.ascii "la victoria."
	.db 0x00
___str_2:
	.ascii "Bienvenido a mi"
	.db 0x0a
	.ascii "humilde hogar."
	.db 0x0a
	.ascii "Puedes descansar"
	.db 0x0a
	.ascii "aqui si lo"
	.db 0x0a
	.ascii "necesitas."
	.db 0x0a
	.ascii "Pero por favor,"
	.db 0x0a
	.ascii "no toques mis"
	.db 0x0a
	.ascii "cosas personales."
	.db 0x0a
	.ascii "Respeta mi"
	.db 0x0a
	.ascii "espacio y todo"
	.db 0x0a
	.ascii "estara bien."
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
	.area _CABS (ABS)
