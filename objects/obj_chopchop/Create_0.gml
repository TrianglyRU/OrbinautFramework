// Inherit the parent event
event_inherited();
event_animator();
event_culler(CULL_ACTION.RESET);

#macro CHOPCHOP_DEFAULT_MOVE_TIMER 512
#macro CHOPCHOP_DEFAULT_BUBBLE_TIMER 80

enum CHOPCHOP_STATE
{
	ROAM,
	WAIT,
	CHARGE
}

depth = draw_depth(40);
state = CHOPCHOP_STATE.ROAM;
move_timer = CHOPCHOP_DEFAULT_MOVE_TIMER;
bubble_timer = CHOPCHOP_DEFAULT_BUBBLE_TIMER;
vel_x = 0.25 * sign(image_xscale);
vel_y = 0;