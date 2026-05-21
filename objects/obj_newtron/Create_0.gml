// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.RESET);

enum NEWTRON_TYPE
{
	FALL,
	FIRE
}

enum NEWTRON_STATE
{
	FIND_TARGET,
	FALL,
	FLOOR,
	FLY,
	FIRE
}

depth = draw_depth(40);
state = NEWTRON_STATE.FIND_TARGET;
vel_y = 0;
target_player = noone;
shot_flag = false;