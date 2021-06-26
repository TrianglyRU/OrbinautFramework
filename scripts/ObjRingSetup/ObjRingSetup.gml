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
	
	// Render behind the player
	object_set_depth(Player, false);
	
	// Set default position
	PosX     = x;
	PosY     = y;
}