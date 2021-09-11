function ObjPushableBlockStartup()
{
	// Create variables
	PushSide  = 0;
	PosX	  = 0;
	PosY	  = 0;
	PrevX     = 0;
	PrevY     = 0;
	Update	  = 0;
	Ysp		  = 0;
	Grounded  = 0;
	Direction = 0;
	ClipTimer = 0;
	FoundWall = 0;
	
	// Set default state
	PosX	 = x;
	PosY	 = y;
	PrevX	 = x;
	PrevY	 = y;
	Grounded = true;
	Update	 = true;
	
	// Set object solidbox
	object_set_solidbox(16, 16, false);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object active range
	object_set_range(TypeReset);
}