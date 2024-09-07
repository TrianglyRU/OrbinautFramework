// Inherit the parent event
event_inherited();
	
launch_force = 10;

obj_set_solid(8, 14);
obj_set_priority(5);
obj_set_culling(CULLING.DISABLE);	
ani_start(sprite_index, 3);