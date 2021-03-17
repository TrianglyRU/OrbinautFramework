function ObjCapsuleSetup()
{
	// Set object collision type
	object_set_collision(SolidAll);
	
	// Set object hitbox
	object_set_hitbox(32, 26);
	
	// Set object visibility
	object_set_visibility(true);
		
	// Render behind the player
	object_set_depth(Player, false);
}