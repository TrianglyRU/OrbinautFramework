function ObjLamppostSetup()
{
	// Set object triggerbox
	object_set_triggerbox(-8, 8, -52, 52);
	
	// Set object visibility
	object_set_visibility(true);
		
	// Render behind the player
	object_set_depth(Player, false);
}