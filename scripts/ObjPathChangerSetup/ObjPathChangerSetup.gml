function ObjPathChangerSetup()
{
	// Set triggerbox
	object_set_triggerbox(-8, 8, -32, 32);
	
	// Make invisible
	object_set_visibility(false);
		
	// Render behind the player
	object_set_depth(Player, false);
}