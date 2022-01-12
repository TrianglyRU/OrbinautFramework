function GameAnimationsStartup()
{
	// When loading a room, initalise animation variables for all instances
	if !variable_instance_exists(id, "image_duration")
	{
		image_timer     = 0;
		image_duration  = 0;
		image_loopframe = 0;
		image_framedata = 0;
	}
}