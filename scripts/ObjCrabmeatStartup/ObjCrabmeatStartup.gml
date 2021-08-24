function ObjCrabmeatStartup()
{
	// Create variables
	PosX      = 0;
	PosY      = 0;
	Xsp       = 0;
	Timer     = 0;
	
	// Set default properties
	PosX  = x;
	PosY  = y;
	Xsp   = 0.5;
	Timer = 128;
	
	// Set object animation
	sprite_index = spr_obj_crabmeat_move;
	
	// Set object hitbox
	object_set_hitbox(16, 16);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object active range
	object_set_range(RangeClose, TypeReset);
}