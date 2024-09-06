#macro SIGNPOST_STATE_IDLE 0
#macro SIGNPOST_STATE_ROTATE 1
#macro SIGNPOST_STATE_MOVE_PLAYER 2

// Inherit the parent event
event_inherited();

state = SIGNPOST_STATE_IDLE;
sign_spin_timer = 0;
sign_spin_cycle = 0;
player_object = noone;
player_object_type = 0;
sign_char_frame = 4;
ring_sparkle_timer = 0;
ring_sparkle_id = 0;
ring_sparkle_pos =
[
	-24, 8, -16, 24, 0, 16, -24, 24,	// x
	-16, 8,  0, -8, -8, 0,   8,  16		// y
];
	
obj_set_priority(5);
obj_set_culling(CULLING.DISABLE);
	
c_stage.bound_end = x + camera_get_width(0) / 2;