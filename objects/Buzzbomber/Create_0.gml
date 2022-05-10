/// @description Startup
// You can write your code in this editor

	PosX  = x;
	Xsp	  = 4;
	State = 0;
	Timer = 127;
	
	// Set object properties
	object_set_unload(FlagReset);
	object_set_depth(Player, 0);
	object_set_hitbox(24, 12);
	
	animation_play(spr_obj_buzzbomber_fly, 1, 0);