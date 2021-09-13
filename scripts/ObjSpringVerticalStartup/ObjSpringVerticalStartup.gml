function ObjSpringVerticalStartup()
{
	// Create variables
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
	
	// Set object solidbox
	object_set_solidbox(16, 8, false);
	
	// Set object depth
	object_set_depth(Player, false);
	
	// Set object unload type
	object_set_unload(TypePause);
}