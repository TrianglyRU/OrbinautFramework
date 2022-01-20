function ObjSpringHorizontalStartup()
{
	// Set spring force
	if object_index == SpringYellowHorizontal
	{
		LaunchForce = 10;
	}
	else if object_index == SpringRedHorizontal
	{
		LaunchForce = 16;
	}
	
	// Set object properties
	object_set_solidbox(8, 16, false);
	object_set_unload(TypePause);
	object_set_depth(Player, 0);
	
	// Set animation to its last frame so we can simply restart it
	animation_play(sprite_index, 3, 3); image_index = 3;
}