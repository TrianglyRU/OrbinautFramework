function ObjMotobugSmokeMain()
{
	// Play animation
	animation_play(sprite_index, 2, 12);
	
	// Destroy on animation end
	if image_index == 12
	{
		instance_destroy();
	}
}