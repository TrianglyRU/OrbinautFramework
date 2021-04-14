function ObjYellowSpringHSetup()
{
	// Set object solidbox
	object_set_solidbox(8, 16);
	
	// Set object visibility
	object_set_visibility(true);
		
	// Render behind the player
	object_set_depth(Player, false);
}