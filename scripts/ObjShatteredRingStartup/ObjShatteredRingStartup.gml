function ObjShatteredRingStartup()
{
	// Set blank values
	Xsp	= 0;
	Ysp = 0;
	
	// Set other variables
	PosX		   = x;
	PosY		   = y;
	Timer		   = 256;
	PickupTimeout  = 64;
	
	// Set object hitbox
	object_set_hitbox(6, 6);
	
	// Set object range
	object_set_unload(TypeDelete);
	
	// Set object depth
	object_set_depth(Player, false);
}