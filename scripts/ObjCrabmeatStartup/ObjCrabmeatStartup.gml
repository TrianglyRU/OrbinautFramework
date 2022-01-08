function ObjCrabmeatStartup()
{
	// Set blank values
	Ysp			   = 0;
	State		   = 0;
	StateTimer	   = 0;
	PreviousSprite = 0;
	
	// Set default position
	PosX      = x;
	PosY      = y;
	Direction = image_xscale;

	// Set object hitbox
	object_set_hitbox(16, 16);
	
	// Set object depth
	object_set_depth(Player, 0);
	
	// Set object unload type
	object_set_unload(TypeReset);
	
	
}