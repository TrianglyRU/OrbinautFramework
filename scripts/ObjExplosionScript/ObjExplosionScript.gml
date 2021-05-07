function ObjExplosionScript()
{
	// Play animation
	if animation_get_frame(id) == 1
	{
		animation_play(sprite_index, 6, 6);
	}
	else if animation_get_frame(id) < 6
	{
		animation_play(sprite_index, 8, 6);
	}
	
	// Destroy on the very last frame
	else
	{
		instance_destroy();
	}
}