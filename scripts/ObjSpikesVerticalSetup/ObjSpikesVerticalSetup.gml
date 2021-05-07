function ObjSpikesVerticalSetup()
{
	// Set solidbox
	object_set_solidbox(16, 16);
	
	// Render behind the player
	object_set_depth(Player, false);
}