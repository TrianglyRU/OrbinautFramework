function ObjRingSetup()
{	
	// Set instance as interactive object
	object_setup(SolidNone);
	
	// Set object hitbox
	object_set_hitbox(8, 8);
	
	// Render behind the player
	object_set_depth(false);
}