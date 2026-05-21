// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.RESET);

enum STARPOST_STATE
{
	IDLE,
	ACTIVE
}

image_index = 1;
depth = draw_depth(60);
lamp_obj = instance_create(x, y - 32, obj_star_post_lamp);
star_objs = [];
state = STARPOST_STATE.IDLE;