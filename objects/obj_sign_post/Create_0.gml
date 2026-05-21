// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.PAUSE);

enum SIGNPOST_STATE
{
	IDLE,
	ROTATE,
	CHECK_RESULTS,
	RESULTS
}

obj_rm_stage.end_bound = x + camera_get_width(0) * 0.5;

depth = draw_depth(50);
state = SIGNPOST_STATE.IDLE;
sign_spin_timer = 0;
sign_spin_cycle = 0;
player = noone;
sign_char_frame = 4;
ring_sparkle_timer = 0;
ring_sparkle_id = 0;
ring_sparkle_pos =
[
	-24, 8, -16, 24, 0, 16, -24, 24,	// x
	-16, 8,  0, -8, -8, 0,   8,  16		// y
];