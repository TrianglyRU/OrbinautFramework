function ObjShatteredRingStartup()
{
	// Create variables
	PosX		   = x;
	PosY		   = y;
	Xsp			   = 0;
	Ysp			   = 0;
	Timer		   = 256;
	PickupTimeout  = 64;
	
	// Set object hitbox
	object_set_hitbox(6, 6);
	
	// Set object range
	object_set_range(TypeDelete);
	
	// Set object depth
	object_set_depth(Player, false);
}