/// @function animation_play(ind,speed,goto) 
function animation_play(ind,speed,goto) 
{	
	// Ignore the animation method built into the IDE
	sprite_set_speed(ind, 0, spritespeed_framespergameframe);
	
	// Create new instance variables
	variable_create_new("image_duration",  abs(speed) + 1);
	variable_create_new("image_lastindex", 0);
	
	// Update sprite
	if sprite_index != ind
	{
		sprite_index    = ind; 	
		image_index     = 0;
		image_lastindex = 0;
		image_duration  = abs(speed) + 1;
	}
	
	// Update duration
	if image_lastindex != image_index
	{
		image_duration  = abs(speed);
		image_lastindex = image_index;
	}

	// Handle subimage change
	if speed != 0 and fade_check(FadeNone)
	{
		if !(--image_duration)
		{	
			// Switch to the next subimage
			if speed > 0
			{
				image_index = image_index + 1 < image_number ? image_index + 1 : goto - 1;
			}
			else
			{
				image_index = image_index + 1 > 1 ? image_index - 1 : image_number - goto;
			}
		}
	}	
}