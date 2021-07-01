function ObjDustPuffScript()
{
	// Play animation
	animation_play(sprite_index, 4, 5);
	
	// Destroy on animation end
	if animation_get_frame(id) == 5
	{
		instance_destroy();
	}
}