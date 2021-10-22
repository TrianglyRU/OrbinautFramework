function ObjSpringVerticalStartup()
{
	// Define spring force
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
	
	// Set animation
	animation_play(sprite_index, 3, 3, 3);
}