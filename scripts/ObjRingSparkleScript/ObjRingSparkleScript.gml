function ObjRingSparkleScript()
{
	// Set animation speed
	animation_play(sprite_index, 6, 5);
	
	// Destroy object
	if image_index > image_number - 1
	{
		instance_destroy();
	}
}