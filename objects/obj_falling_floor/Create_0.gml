// Inherit the parent event
event_inherited();
event_culler(CULL_ACTION.RESET);

enum FALLING_FLOOR_STATE
{
	IDLE,
	FALL,
	DESTROYED
}

depth = draw_depth(50);
state = FALLING_FLOOR_STATE.IDLE;
wait_timer = 8;
fall_flag = false;
corner_x = floor(x - sprite_get_xoffset(sprite_index));
corner_y = floor(y - sprite_get_yoffset(sprite_index));
width = sprite_get_width(sprite_index);
height = sprite_get_height(sprite_index);