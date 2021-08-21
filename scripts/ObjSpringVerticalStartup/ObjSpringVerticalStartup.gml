function ObjSpringVerticalStartup()
{
	// Create variables
	LaunchSide  = 0;
	LaunchForce = 0;
	
	// Define spring force and launch side
	if object_index == SpringYellowVertical
	{
		LaunchForce = 10;
	}
	else if object_index == SpringRedVertical
	{
		LaunchForce = 16;
	}
	LaunchSide = image_yscale ? SideTop : SideBottom;
	
	// Set object solidbox
	object_set_solidbox(16, 8, false);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object active range
	object_set_range(RangeClose, TypeUnload);
}