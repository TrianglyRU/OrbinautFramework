function ObjRingSparkleMain()
{
	// Play animation
	animation_play(sprite_index, 8, 5);
	
	// Destroy on animation end
	if image_index == 4
	{
		instance_destroy();
	}
}