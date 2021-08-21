function ObjExplosionScript()
{
	// Play animation
	if !image_index
	{
		animation_play(sprite_index, 6, 6);
	}
	else if image_index < 5
	{
		animation_play(sprite_index, 8, 6);
	}
	
	// Destroy on animation end
	else
	{
		instance_destroy();
	}
}