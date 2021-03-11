function ObjRingSetup()
{	
	// Set object collision type
	object_set_collision(SolidNone);
	
	// Set object hitbox
	object_set_hitbox(8, 8);
	
	// Set object visibility
	object_set_visibility(true);
	
	// Render behind the player
	object_set_depth(false);
}