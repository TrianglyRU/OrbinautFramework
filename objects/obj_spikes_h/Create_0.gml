// Inherit the parent event
event_inherited();
	
retract_direction = sign(image_xscale);
retract_distance = 32;
retract_timer = 0;
retract_offset = 0;
	
obj_set_solid(16, 16);
obj_set_priority(5);
obj_set_culling(CULLING.ORIGINRESPAWN);