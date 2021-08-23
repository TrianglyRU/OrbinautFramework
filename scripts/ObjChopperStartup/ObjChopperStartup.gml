function ObjChopperStartup()
{
	// Create variables
	OriginY		   = 0;
	PosY		   = 0;
	Ysp			   = 0;
	AnimationSpeed = 0;
	
	// Set default position
	OriginY = y;
	PosY    = y;
	
	// Set object hitbox
	object_set_hitbox(12, 16);
	
	// Set object active range
	object_set_range(RangeFar, TypeReset);
}