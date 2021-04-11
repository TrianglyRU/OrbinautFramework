function ObjCapsuleSetup()
{
	// Set object hitbox
	object_set_solidbox(32, 25);
	
	// Set object visibility
	object_set_visibility(true);
		
	// Render behind the player
	object_set_depth(Player, false);
}