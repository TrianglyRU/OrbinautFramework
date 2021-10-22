function GameAnimationsProcess()
{
	with all
	{
		// Ignore in-built animation speed for all instances
		sprite_set_speed(sprite_index, 0, spritespeed_framespergameframe);
		
		// Check if animation should be played for this object
		if variable_instance_exists(id, "image_duration") and !variable_check(Stage, "IsPaused")
		{
			// Handle subimage change
			if image_duration != 0 and !fade_check(FadeActive)
			{
				if !(--image_timer)
				{
					// Switch to the previous subimage
					if image_duration < 0
					{
						if image_index > 0
						{
							image_index--;
						}
						else
						{
							image_index = image_number - image_loopframe - 1;
						}
					}
					
					// Switch to the next subimage
					else
					{
						if image_index < image_number - 1
						{
							image_index++;
						}
						else
						{
							image_index = image_loopframe;
						}
					}
					
					// Reset timer
					if !is_array(image_duration)
					{
						image_timer = abs(image_duration);
					}
					else
					{
						image_timer = abs(image_duration[image_index]);
					}
				}
			}		
		}
	}
}