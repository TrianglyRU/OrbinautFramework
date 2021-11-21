function ObjBuzzbomberStartup()
{
	// Create variables
	PosX  = x;
	Xsp	  = 4;
	State = 0;
	Timer = 127;
	
	// Set object hitbox
	object_set_hitbox(24, 12);
	
	// Set object depth
	object_set_depth(Player, 0);
	
	// Set object unload type
	object_set_unload(TypeReset);
	
	// Set animation
	animation_play(spr_obj_buzzbomber_fly, 1, 0, 0);
}