// Inherit the parent event
event_inherited();
event_animator();

depth = draw_depth(0);
max_allowed_game_state = GAME_STATE.STOP_OBJECTS;
player = noone;
animator.start(sprite_index, 0, 0, 2);