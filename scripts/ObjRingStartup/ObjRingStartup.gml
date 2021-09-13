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
	
	// Set object unload type
	object_set_unload(TypePause);
	
	// Set object depth
	object_set_depth(Player, false);
}