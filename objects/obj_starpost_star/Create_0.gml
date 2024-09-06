// Inherit the parent event
event_inherited();
	
transition_flag = false;
timer = 0;
radius = 0;
	
obj_set_hitbox(4, 4);
obj_set_priority(6);
ani_start(sprite_index, 2, 0, 0, [0, 1, 2, 1]);