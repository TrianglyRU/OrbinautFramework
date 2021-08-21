function ObjDropdashDustMain()
{
	// Play animation
	animation_play(sprite_index, 2, 8);
	
	// Destroy on animation end
	if image_index == 10
	{
		instance_destroy();
	}
}