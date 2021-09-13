function ObjProjectileStartup()
{
	// Create variables
	PosX   = x;
	PosY   = y;
	Xsp    = 0;
	Ysp    = 0;
	Sprite = 0;
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object unload type
	object_set_unload(TypeDelete);
}