function ObjLayerChangeSetup()
{
	// Set object hitbox
	object_set_hitbox(8, 32);
	
	// Set object visibility
	object_set_visibility(false);
		
	// Render behind the player
	object_set_depth(Player, false);
}