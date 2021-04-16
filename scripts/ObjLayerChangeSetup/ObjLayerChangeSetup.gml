function ObjLayerChangeSetup()
{
	// Set object hitbox
	object_set_triggerbox(-12, 12, -32, 32);
	
	// Set object visibility
	object_set_visibility(false);
		
	// Render behind the player
	object_set_depth(Player, false);
}