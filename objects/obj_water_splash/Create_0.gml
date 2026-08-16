// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.DESTROY);

depth = draw_depth(0);
max_allowed_game_state = GAME_STATE.STOP_OBJECTS;
animator.start(sprite_index, 0, 6, 4);