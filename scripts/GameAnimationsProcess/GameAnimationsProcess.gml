function GameAnimationsProcess()
{
	with all
	{
		// Check if animation should be played for this object
		if !variable_instance_exists(id, "image_duration")
		{
			image_timer     = 0;
			image_duration  = 0;
			image_loopframe = 0;
			image_speed		= 0;
		}
		else if !fade_check(StateActive) and !variable_check(Stage, "IsPaused")
		{
			// Handle subimage change
			var FrameDuration  = is_array(image_duration) ? image_duration[image_index] : image_duration;
			if  FrameDuration != 0
			{
				if !(--image_timer)
				{
					// Switch to the previous subimage
					if FrameDuration < 0
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