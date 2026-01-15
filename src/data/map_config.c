#include "../../res/assets.h"
#include "../utils/map_manager.h"
#include "dialogues.h"
#include <stddef.h>

// --- Entity Instances ---
entity_t world_entities[3];
entity_t house_entities[1];
entity_t level2_entities[1];

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
                 0}};

void map_init_data() {
  entity_init(&world_entities[0], ENT_NPC, 210, 230, 24, DIALOGUE_NPC_CHILD);
  entity_init(&world_entities[1], ENT_NPC, 160, 120, 36, DIALOGUE_NPC_WOMAN);
  entity_init(&world_entities[2], ENT_ITEM, 180, 140, 41, NULL); // Flower
  world_entities[2].update = ai_anim_simple;
  entity_init(&house_entities[0], ENT_NPC, 40, 48, 24, DIALOGUE_NPC_HOUSE);
  entity_init(&level2_entities[0], ENT_ENEMY, 120, 120, 28, NULL);
  level2_entities[0].update = ai_enemy_chaser_shooter;
  level2_entities[0].shoot_timer = 60;
}
