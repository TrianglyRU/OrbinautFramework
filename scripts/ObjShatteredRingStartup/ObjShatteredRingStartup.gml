function ObjShatteredRingStartup()
{
	// Initialize variables
	PosX		   = 0;
	PosY		   = 0;
	Xsp			   = 0;
	Ysp			   = 0;
	Grv			   = 0;
	Timer		   = 0;
	CollisionCheck = 0;
	PickupTimeout  = 0;
	
	// Set object hitbox
	object_set_hitbox(6, 6);
	
	// Set object solidbox
	object_set_solidbox(8, 8, false);
	
	// Set object range
	object_set_range(RangeClose, TypeDelete);
	
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