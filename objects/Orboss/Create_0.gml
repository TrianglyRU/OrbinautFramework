/// @description Insert description here
// You can write your code in this editor
	
	HP = 10;
	Timer = 0;
	Active = false;
	
	image_index = instance_exists(Orbstatue) + 1;
	
	object_set_solidbox(15, 15);
	object_set_hitbox(16, 16);
	object_set_depth(Player, false);