#include "../../res/assets.h"
#include "../utils/map_manager.h"
#include "dialogues.h"
#include <stddef.h>

// --- Entity Instances ---
entity_t world_entities[3];
entity_t house_entities[1];
entity_t level2_entities[1];
entity_t level3_entities[2];
entity_t maze_entities[1];
entity_t sanctuary_entities[1];
entity_t void_entities[1];

// --- Portal Instances ---
portal_t world_portals[1] = {
    {12, 12, 1, 76, 112} // Example, will be refined in game.c integration
};

portal_t house_portals[1] = {
    {5, 14, 0, 210, 246} // Returning to world
};

portal_t level2_portals[1] = {{16, 31, 0, 124, 48}};

// --- Map Definitions ---
map_t maps[] = {{
                    // 0: WORLD_MAP
                    map_data,
                    MAP_WIDTH,
                    MAP_HEIGHT,
                    world_entities,
                    3,
                    {0, 2, 3, 4, 5, 21, 22, 255},
                    NULL,
                    0 // Portals managed manually for now or via this list
                },
                {// 1: HOUSE_MAP
                 house_map,
                 HOUSE_WIDTH,
                 HOUSE_HEIGHT,
                 house_entities,
                 1,
                 {25, 35, 255},
                 NULL,
                 0},
                {// 2: LEVEL2_MAP
                 level2_map,
                 L2_WIDTH,
                 L2_HEIGHT,
                 level2_entities,
                 1,
                 {0, 2, 3, 4, 255},
                 NULL,
                 0},
                {// 3: LEVEL3_MAP
                 level3_map,
                 L3_WIDTH,
                 L3_HEIGHT,
                 level3_entities,
                 2,
                 {0, 2, 255},
                 NULL,
                 0},
                {// 4: MAZE_MAP
                 maze_map,
                 MAZE_WIDTH,
                 MAZE_HEIGHT,
                 maze_entities,
                 1,
                 {2, 41, 42, 43, 44, 255}, // 41-44 are portal tiles
                 NULL,
                 0},
                {// 5: SANCTUARY_MAP
                 sanctuary_map,
                 SANCTUARY_WIDTH,
                 SANCTUARY_HEIGHT,
                 sanctuary_entities,
                 1,
                 {35, 255}, // 35 is floor
                 NULL,
                 0},
                {// 6: VOID_MAP
                 void_map,
                 VOID_WIDTH,
                 VOID_HEIGHT,
                 void_entities,
                 1,
                 {0, 2, 255},
                 NULL,
                 0}};

void map_init_data() {
  entity_init(&world_entities[0], ENT_NPC, 210, 230, 24, DIALOGUE_NPC_CHILD);
  entity_init(&world_entities[1], ENT_NPC, 160, 120, 36, DIALOGUE_NPC_WOMAN);
  entity_init(&world_entities[2], ENT_ITEM, 180, 140, 49,
              NULL); // Diskette at 49
  world_entities[2].update = ai_anim_simple;
  entity_init(&house_entities[0], ENT_NPC, 40, 48, 24, DIALOGUE_NPC_HOUSE);
  entity_init(&level2_entities[0], ENT_ENEMY, 120, 120, 28, NULL);
  level2_entities[0].update = ai_enemy_chaser_shooter;
  level2_entities[0].shoot_timer = 60;

  entity_init(&level3_entities[0], ENT_NPC, 128, 128, 36,
              "BIENVENIDO AL\nPUEBLO SENSEI");
  entity_init(&level3_entities[1], ENT_NPC, 200, 100, 24, "HOLA VIAJERO");

  entity_init(&maze_entities[0], ENT_ITEM, 128, 128, 49, "ARMA");

  entity_init(&sanctuary_entities[0], ENT_NPC, 76, 64, 36,
              "ESTAS A SALVO\nTOCA EL ALTAR");

  entity_init(&void_entities[0], ENT_PORTAL, 480, 480, 41, NULL);
}
