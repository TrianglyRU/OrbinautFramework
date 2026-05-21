// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.RESET);

enum MOTOBUG_STATE
{
	INIT,
	WAIT,
	ROAM
}

depth = draw_depth(50);
state = MOTOBUG_STATE.INIT;
move_timer = 0;
smoke_timer = 0;
vel_x = 0;
vel_y = 0;