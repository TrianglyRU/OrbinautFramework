function ObjSpikesVerticalSetup()
{
	// Create variables
	HurtSide isReal;
	
	// Set object solidbox
	object_set_solidbox(16, 16, false);
	
	// Set active range
	object_set_range(RangeClose, ResetUnload);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Define hurt side
	HurtSide = image_yscale == 1 ? SideTop : SideBottom;
}