function ObjRingStartup()
{	
	// Set blank values
	Xsp	  = 0;
	Ysp	  = 0;
	State = 0;
	
	// Set other variables
	PosX  = x;
	PosY  = y;
	
	// Set object hitbox
	object_set_hitbox(6, 6);
	
	// Set object unload type
	object_set_unload(TypePause);
	
	// Set object depth
	object_set_depth(Player, 0);
}