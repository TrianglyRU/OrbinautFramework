function ObjExplosionScript()
{
	// Update animation
	if !image_index
	{
		animation_play(sprite_index, 8, 0, 5);
	}
	
	// Destroy on animation end
	else if image_index == 5
	{
		instance_destroy();
	}
}