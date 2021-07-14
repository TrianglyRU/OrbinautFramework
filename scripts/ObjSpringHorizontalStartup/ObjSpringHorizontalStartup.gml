function ObjSpringHorizontalStartup()
{
	// Initialize variables
	LaunchSide  isVar;
	LaunchForce isVar;
	
	// Set object solidbox
	object_set_solidbox(8, 16);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Define launch side
	LaunchSide = image_xscale ? SideRight : SideLeft;
	
	// Define spring force
	if object_index == SpringYellowHorizontal
	{
		LaunchForce = 10;
	}
	else if object_index == SpringRedHorizontal
	{
		LaunchForce = 16;
	}
}