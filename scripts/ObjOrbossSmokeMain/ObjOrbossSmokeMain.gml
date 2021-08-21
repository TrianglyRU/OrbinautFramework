function ObjOrbossSmokeMain()
{
	// Play animation
	animation_play(sprite_index, 4, 4);
	
	// Destroy on animation end
	if image_index == 4
	{
		instance_destroy();
	}
}