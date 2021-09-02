function ObjRingStartup()
{	
	// Create variables
	PosX  = x;
	PosY  = y;
	Xsp	  = 0;
	Ysp	  = 0;
	State = 0;
	
	// Set object hitbox
	object_set_hitbox(6, 6);
	
	// Set object active range
	object_set_range(RangeClose, TypeUnload);
	
	// Set object depth
	object_set_depth(Player, false);
}