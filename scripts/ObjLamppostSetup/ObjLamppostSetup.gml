function ObjLamppostSetup()
{
	// Set triggerbox
	object_set_triggerbox(-8, 8, -52, 52);
	
	// Render behind the player
	object_set_depth(Player, false);
}