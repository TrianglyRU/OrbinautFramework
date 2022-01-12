function ObjPushableBlockStartup()
{
	// Initialise variables
	PosX      = x;
	PosY	  = y;
	Ysp		  = 0;
	Direction = 0;
	ClipTimer = 0;
	State	  = 0;
	
	// Set object properties
	object_set_solidbox(16, 16, false);
	object_set_unload(TypeReset);
	object_set_depth(Player, 0);
}