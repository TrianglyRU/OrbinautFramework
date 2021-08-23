function ObjRingFlashMain()
{
	// Play animation
	animation_play(sprite_index, 2, 8);
	
	// Destroy on animaton end
	if image_index == 8
	{
		instance_destroy();
	}
}