// Inherit the parent event
event_inherited();

// In S2, the initial vel_y is set to -4 due to an oversight
vel_y_default = -5;
vel_y = vel_y_default;
	
obj_set_hitbox(12, 16);
obj_set_priority(5);
obj_set_culling(CULLING.RESPAWN);
ani_start(sprite_index);