function ObjSpringVerticalStartup()
{
	if object_index == SpringYellowVertical
	{
		LaunchForce = 10;
	}
	else if object_index == SpringRedVertical
	{
		LaunchForce = 16;
	}
	
	// Set object properties
	object_set_unload(TypePause);
	object_set_depth(Player, 0);
	object_set_solidbox(16, 8, false);

	// Set animation to its last frame so we can simply restart it
	animation_play(sprite_index, 3, 3); image_index = 3;
}