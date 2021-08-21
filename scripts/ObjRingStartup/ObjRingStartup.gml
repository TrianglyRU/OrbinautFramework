function ObjRingStartup()
{	
	// Create variables
	PosX	   = 0;
	PosY	   = 0;
	Xsp		   = 0;
	Ysp		   = 0;
	Magnetized = 0;
	
	// Set default position
	PosX = x;
	PosY = y;
	
	// Set object hitbox
	object_set_hitbox(6, 6);
	
	// Set object active range
	object_set_range(RangeClose, TypeUnload);
	
	// Set object depth
	object_set_depth(Player, false);
}