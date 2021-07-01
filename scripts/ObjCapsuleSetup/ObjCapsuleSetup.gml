function ObjCapsuleSetup()
{
	// Set object hitbox
	object_set_solidbox(32, 25);
		
	// Render behind the player
	object_set_depth(Player, false);
}