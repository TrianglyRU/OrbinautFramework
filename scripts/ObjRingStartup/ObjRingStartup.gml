function ObjRingStartup()
{	
	// Initialise variables
	PosX  = x;
	PosY  = y;
	Xsp	  = 0;
	Ysp	  = 0;
	State = 0;
	
	// Set object properties
	object_set_hitbox(6, 6);
	object_set_depth(Player, 0);
	object_set_unload(TypePause);
}