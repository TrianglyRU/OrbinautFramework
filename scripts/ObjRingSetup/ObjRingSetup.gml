function ObjRingSetup()
{	
	// Set object collision type
	object_set_collision(SolidNone);
	
	// Set object hitbox
	object_set_hitbox(6, 6);
	
	// Set object visibility
	object_set_visibility(true);
	
	// Render behind the player
	object_set_depth(Player, false);
}