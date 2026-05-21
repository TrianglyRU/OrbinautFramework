// Inherit the parent event
event_inherited();

max_allowed_game_state = GAME_STATE.STOP_OBJECTS;

next_bubble_timer_no_air = irandom(15);
next_bubble_timer = 0;
bubbles_spawned_no_air = 0;
countdown_bubble_frame = 0;
spawn_countdown_bubble = false;
player = noone;