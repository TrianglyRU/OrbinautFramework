function ObjSignpostSetup()
{
	// Set object triggerbox
	object_set_triggerbox(0, 32, -512, 512);
	
	// Set object visibility
	object_set_visibility(true);
		
	// Render behind the player
	object_set_depth(Player, false);
}