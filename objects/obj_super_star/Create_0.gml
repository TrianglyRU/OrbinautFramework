// Inherit the parent event
event_inherited();
event_animator();

#macro SUPER_STAR_LAST_FRAME image_number - 1

depth = draw_depth(10);
image_index = SUPER_STAR_LAST_FRAME;
max_allowed_game_state = GAME_STATE.STOP_OBJECTS;
player = noone;