function ObjSpikesVerticalStartup()
{
	// Create variable
	HurtSide = 0;
	
	// Set object solidbox
	object_set_solidbox(16, 16, false);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object active range
	object_set_range(TypePause);
	
	// Define hurt side
	HurtSide = image_yscale == 1 ? SideTop : SideBottom;
}