function ObjPushableBlockStartup()
{
	// Set blank values
	Ysp		  = 0;
	Direction = 0;
	ClipTimer = 0;
	FoundWall = 0;
	State	  = 0;
	
	// Set variables
	PosX  = x;
	PosY  = y;
	
	// Set object solidbox
	object_set_solidbox(16, 16, false);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object unload type
	object_set_unload(TypeReset);
}