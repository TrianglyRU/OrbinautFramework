function ObjSpringHorizontalStartup()
{
	if object_index == SpringYellowHorizontal
	{
		LaunchForce = 10;
	}
	else if object_index == SpringRedHorizontal
	{
		LaunchForce = 16;
	}
	
	// Set object properties
	if global.S2SpringBehaviour
	{
		object_set_triggerbox(0 - !image_xscale * 40, 40 - !image_xscale * 40, -24, 24);
	}
	object_set_unload(FlagPause);
	object_set_depth(Player, 0);
	object_set_solidbox(8, 16, false);
	
	// Set animation to its last frame so we can simply restart it
	animation_play(sprite_index, 3, 3); image_index = 3;
}