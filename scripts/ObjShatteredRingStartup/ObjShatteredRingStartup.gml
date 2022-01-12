function ObjShatteredRingStartup()
{
	// Initialise variables
	PosX		   = x;
	PosY		   = y;
	Xsp			   = 0;
	Ysp			   = 0;
	Timer		   = 256;
	PickupTimeout  = 64;
	
	// Set object properties
	object_set_hitbox(6, 6);
	object_set_unload(TypeDelete);
	object_set_depth(Player, 0);
}