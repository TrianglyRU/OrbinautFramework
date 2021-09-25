function ObjProjectileStartup()
{
	// Create variables
	PosX   = x;
	PosY   = y;
	Xsp    = 0;
	Ysp    = 0;
	Grv    = 0.21875;
	
	// Set object hitbox size
	object_set_hitbox(6, 6);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object unload type
	object_set_unload(TypeDelete);
}