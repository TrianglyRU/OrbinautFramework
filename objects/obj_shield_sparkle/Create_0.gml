// Inherit the parent event
event_inherited();
	
display_timer = 0;
	
obj_set_priority(0);
obj_set_culling(CULLING.REMOVE);	
ani_start(sprite_index, 1, 0, 0, [2, 0, 2, 1]);