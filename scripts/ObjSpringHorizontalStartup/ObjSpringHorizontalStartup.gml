function ObjSpringHorizontalStartup()
{
	// Create variables
	LaunchForce = 0;
	
	// Define spring force and launch side
	if object_index == SpringYellowHorizontal
	{
		LaunchForce = 10;
	}
	else if object_index == SpringRedHorizontal
	{
		LaunchForce = 16;
	}
	
	// Set object solidbox
	object_set_solidbox(8, 16, false);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object unload type
	object_set_unload(TypePause);
}