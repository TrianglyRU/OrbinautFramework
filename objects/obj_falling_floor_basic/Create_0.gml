#macro FALLING_FLOOR_STATE_IDLE 0
#macro FALLING_FLOOR_STATE_FALL 1
	
// Inherit the parent event
event_inherited();

state = FALLING_FLOOR_STATE_IDLE;
wait_timer = 8;
fall_flag = false;
corner_x = floor(x - sprite_get_xoffset(sprite_index));
corner_y = floor(y - sprite_get_yoffset(sprite_index));
width  = sprite_get_width(sprite_index);
height = sprite_get_height(sprite_index);
	
obj_set_solid(floor(CollisionWidth / 2), floor(CollisionHeight / 2));
obj_set_priority(5);
obj_set_culling(CULLING.RESPAWN);