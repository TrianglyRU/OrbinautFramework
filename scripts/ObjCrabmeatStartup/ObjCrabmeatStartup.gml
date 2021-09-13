function ObjCrabmeatStartup()
{
	// Create variables
	PosX      = x;
	Direction = image_xscale;
	State     = 0;
	PrevAnim  = 0;
	Timer     = 127;
	
	// Set object animation
	sprite_index = spr_obj_crabmeat_move;
	
	// Set object hitbox
	object_set_hitbox(16, 16);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object unload type
	object_set_unload(TypeReset);
}