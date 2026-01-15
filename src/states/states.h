#ifndef STATES_H
#define STATES_H

#define STATE_INTRO 0
#define STATE_MENU 1
#define STATE_GAME 2
#define STATE_INVENTORY 3
#define STATE_GAMEOVER 4

void intro_init(void);
void intro_update(void);

void menu_init(void);
void menu_update(void);

void game_init(void);
void game_update(void);

void inventory_state_init(void);
void inventory_state_update(void);

void gameover_init(void);
void gameover_update(void);

void game_reset(void);

#endif
