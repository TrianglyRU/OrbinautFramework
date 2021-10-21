/// @function animation_set(spriteid,duration,startframe,loopframe)
function animation_set(spriteid,duration,startframe,loopframe)
{
	// Update animation
	if sprite_index != spriteid or !variable_instance_exists(id, "image_timer")
	{
		if !is_array(duration)
		{
			image_timer    = abs(duration);
			image_duration = duration;
		}
		else
		{
			image_timer    = abs(duration[startframe]);
			image_duration = duration[startframe];
		}
		image_loopframe = loopframe;
		image_index     = startframe;
		sprite_index    = spriteid;
		
		// Initalise other fags
		image_stoptime = -1;
	}
	else 
	{
		// Update startframe
		if image_duration == 0 and image_index != startframe
		{
			image_index = startframe;
		}
		
		// Update duration
		if !is_array(duration)
		{
			if image_duration != duration
			{
				if image_timer == 0
				{
					image_timer = abs(duration);
				}
				image_duration = duration;
			}
		}
		else if image_duration != duration[image_index]
		{
			image_timer    = abs(duration[image_index]);
			image_duration = duration[image_index];
		}
		
		// Update loopframe
		if image_loopframe != loopframe
		{
			image_loopframe = loopframe;
		}	
	}
}