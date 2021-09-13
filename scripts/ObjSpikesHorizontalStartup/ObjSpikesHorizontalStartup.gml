function ObjSpikesHorizontalStartup()
{
	// Create variable
	HurtSide = 0;
	
	// Set object solidbox
	object_set_solidbox(16, 16, false);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object unload type
	object_set_unload(TypePause);
	
	// Define hurt side
	HurtSide = image_xscale == 1 ? SideRight : SideLeft;
}