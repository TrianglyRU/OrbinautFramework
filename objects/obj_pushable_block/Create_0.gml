#macro PUSHABLE_BLOCK_STATE_GROUND 0
#macro PUSHABLE_BLOCK_STATE_LEDGE 1
#macro PUSHABLE_BLOCK_STATE_FALL 2
	
// Inherit the parent event
event_inherited();

state = PUSHABLE_BLOCK_STATE_GROUND;
vel_x = 0;
vel_y = 0;
direction_x = 0;
solid_size = 16;
	
obj_set_solid(solid_size, solid_size);
obj_set_priority(4);
obj_set_culling(CULLING.DISABLE);