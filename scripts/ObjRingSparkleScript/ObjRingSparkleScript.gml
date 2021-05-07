function ObjRingSparkleScript()
{
	// Set animation speed
	animation_play(sprite_index, 8, 5);
	
	// Destroy object
	if animation_get_frame(id) == 5
	{
		instance_destroy();
	}
}