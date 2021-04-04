function ObjRingSetup()
{	
	// Set object hitbox
	object_set_hitbox(6, 6);
	
	// Set object visibility
	object_set_visibility(true);
	
	// Render behind the player
	object_set_depth(Player, false);
}