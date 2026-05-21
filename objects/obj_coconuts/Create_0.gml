// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.RESET);

enum COCONUTS_STATE
{
	IDLE,
	START_CLIMB,
	START_THROW,
	CLIMB,
	THROW
}

depth = draw_depth(40);
state = COCONUTS_STATE.IDLE;
state_timer = 16;
vel_y = 0;
climb_table_index = 0;
attack_timer = 0;
attack_flag = false;
hand_frame = 0;
climb_data =
[
//   vel	    timer
	-1,			32,
	 1,			24, 
    -1,			16,
	 1,			40,
    -1,			32,
	 1,			16
];