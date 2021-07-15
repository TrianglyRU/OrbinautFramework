function ObjRingSetup()
{	
	// Initialize variables
	PosX		   isVar;
	PosY		   isVar;
	Xsp			   isVar;
	Ysp			   isVar;
	Magnetized     isVar;
	
	// Set object hitbox
	object_set_hitbox(6, 6);
	
	// Set active range
	object_set_range(RangeClose);
	
	// Render behind the player
	object_set_depth(Player, false);
	
	// Set default position
	PosX     = x;
	PosY     = y;
}