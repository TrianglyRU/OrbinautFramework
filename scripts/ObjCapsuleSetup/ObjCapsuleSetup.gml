function ObjCapsuleSetup()
{
	// Set object hitbox
	object_set_hitbox(32, 31);
	
	// Set object visibility
	object_set_visibility(true);
		
	// Render behind the player
	object_set_depth(Player, false);
}