function ObjMotobugStartup()
{
	// Set blank values
	Ysp		   = 0;
	State	   = 0;
	StateTimer = 0;
	
	// Set default position
	PosX = x;
	PosY = y;
	
	// Set object hitbox
	object_set_hitbox(20, 17);
	
	// Set object depth
	object_set_depth(Player, 0);
	
	// Set object unload type
	object_set_unload(TypeReset);
}