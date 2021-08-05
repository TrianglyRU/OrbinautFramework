function ObjShatteredRingSetup()
{
	// Initialize variables
	PosX		   isVar;
	PosY		   isVar;
	Xsp			   isVar;
	Ysp			   isVar;
	Grv			   isVar;
	Timer		   isVar;
	CollisionCheck isVar;
	PickupTimeout  isVar;
	
	// Set object hitbox
	object_set_hitbox(6, 6);
	
	// Set object solidbox
	object_set_solidbox(8, 8, false);
	
	object_set_range(RangeClose, ResetDelete);
	
	// Render behind the player
	object_set_depth(Player, false);
	
	// Set default position
	PosX = x;
	PosY = y;
	
	// Set default values
	PickupTimeout = 64;
	Timer	      = 256;
	Grv		      = 0.09375;
}