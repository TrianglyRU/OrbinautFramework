function ObjMotobugStartup()
{
	// Create variables
	PosX	   = 0;
	PosY	   = 0;
	Xsp		   = 0;
	StopTimer  = 0;
	SmokeTimer = 0;
	ChildrenData = [];
	
	// Set values
	PosX	   = x;
	PosY	   = y;
	Xsp        = 1;
	SmokeTimer = 17;
	
	// Set object hitbox
	object_set_hitbox(20, 17);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object active range
	object_set_range(RangeClose, TypeReset);
}