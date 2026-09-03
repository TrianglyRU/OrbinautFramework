// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.RESET);

enum STAR_POST_STATE
{
	IDLE,
	ACTIVE
}

image_index = 1;
depth = draw_depth(60);
lamp_obj = instance_create(x, y - 32, obj_star_post_lamp);
star_objs = [];
state = STAR_POST_STATE.IDLE;

var _checkpoint_data = global.checkpoint_data;

if array_length(_checkpoint_data) > 0 && _checkpoint_data[7] >= iv_index
{
	state = STAR_POST_STATE.ACTIVE;
	lamp_obj.activate();
}