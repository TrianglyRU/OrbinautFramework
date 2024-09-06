#macro BUMPER_FORCE 7 
	
// Inherit the parent event
event_inherited();

// There is no limit in S2. Set to 10 to match the S1 behaviour
hits_left = -1;	
	
obj_set_hitbox(8, 8);
obj_set_priority(1);
obj_set_culling(CULLING.DISABLE);
ani_start(sprite_index, [0, 4, 4, 5], 0, 0, [0, 1, 0, 1]);