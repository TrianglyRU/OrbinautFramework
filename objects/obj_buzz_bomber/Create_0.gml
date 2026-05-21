// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.RESET);

enum BUZZ_BOMBER_STATE
{
	ROAM,
	HOVER,
	FIRE
}

depth = draw_depth(40);
state = BUZZ_BOMBER_STATE.HOVER;
state_timer = 0;
shot_flag = false;
projectile = noone;