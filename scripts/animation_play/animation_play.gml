/// @function animation_play(spriteid,duration,startframe,loopframe)
function animation_play(spriteid,duration,startframe,loopframe)
{
	// Update animation
	if sprite_index != spriteid or !variable_instance_exists(id, "image_duration")
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
		image_index		= startframe;
		sprite_index    = spriteid;
	}
	
	// Update duration
	else 
	{
		if !is_array(duration) and image_duration != duration
		{
			if image_timer == 0
			{
				image_timer = abs(duration);
			}
			image_duration = duration;
		}
		else if is_array(duration) and image_duration != duration[image_index]
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