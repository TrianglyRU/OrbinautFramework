function ObjSpringDiagonalStartup()
{
	// Set spring force
	if object_index == SpringYellowDiagonal
	{
		LaunchForce = 10;
	}
	else if object_index == SpringRedDiagonal
	{
		LaunchForce = 16;
	}
	var Heightmap = [32,32,32,32,32,32,32,32,32,32,31,30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10];
	
	// Set object properties
	object_set_solidbox(16, 16, Heightmap);
	object_set_unload(TypePause);
	object_set_depth(Player, 0);
	
	// Set animation to its last frame so we can simply restart it
	animation_play(sprite_index, 3, 3); image_index = 3;
}