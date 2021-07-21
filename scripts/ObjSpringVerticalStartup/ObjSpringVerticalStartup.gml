function ObjSpringVerticalStartup()
{
	// Initialize variables
	LaunchSide  isVar;
	LaunchForce isVar;
	
	// Set object solidbox
	object_set_solidbox(16, 8);
	
	// Set active range
	object_set_range(RangeClose, false);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Define launch side
	LaunchSide = image_yscale ? SideTop : SideBottom;
	
	// Define spring force
	if object_index == SpringYellowVertical
	{
		LaunchForce = 10;
	}
	else if object_index == SpringRedVertical
	{
		LaunchForce = 16;
	}
}