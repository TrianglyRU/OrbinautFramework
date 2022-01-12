/// @function animation_play(spriteid,duration,startframe,loopframe)
function animation_play(spriteid,duration,startframe,loopframe)
{
	// Update or set animation
	if sprite_index != spriteid or event_type == ev_create
	{
		if !is_array(duration)
		{
			image_timer = abs(duration);
		}
		else
		{
			image_timer = abs(duration[startframe]);	
		}
		image_duration  = duration;
		image_loopframe = loopframe;
		image_index		= startframe;
		sprite_index    = spriteid;		
	}
	else 
	{
		// Update duration
		if !is_array(duration) and image_duration != duration
		or  is_array(duration) and !is_array(image_duration)
		{
			if !is_array(duration)
			{
				if image_timer == 0
				{
					image_timer = abs(duration);
				}
				image_duration = duration;
			}
			else
			{
				image_timer    = abs(duration[0]);
				image_duration = duration;
			}
		}
		
		// Update loopframe
		if image_loopframe != loopframe
		{
			image_loopframe = loopframe;
		}
	}
}