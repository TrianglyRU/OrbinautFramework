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
	
	// Set object active range
	object_set_range(RangeClose, TypeDelete);
}