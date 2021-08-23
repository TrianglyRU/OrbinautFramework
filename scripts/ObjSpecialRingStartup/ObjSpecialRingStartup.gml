function ObjSpecialRingStartup()
{
	// Create variables
	State = 0;
	Timer = 0;
	
	// Set object hitbox
	object_set_hitbox(8, 16);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Make ring temporary invisible
	visible = false;
}