// Inherit the parent event
event_inherited();
	
do_update = false;
attach_to_player = false;

obj_set_culling(CULLING.PAUSEONLY);
obj_set_priority(1);
ani_start(sprite_index, 2, 5, 5, [0, 1, 2, 1, 0, 3]);
ani_stop();	