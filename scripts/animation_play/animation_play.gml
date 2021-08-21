/// @function animation_play(ind,speed,goto) 
function animation_play(ind,speed,goto) 
{	
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
	if speed != 0 and !fade_check(FadeActive)
	{
		if !(--image_duration)
		{	
			// Switch to the next subimage
			if speed > 0
			{
				image_index = image_index < image_number - 1 ? image_index + 1 : goto;
			}
			else
			{
				image_index = image_index > 0 ? image_index - 1 : image_number - goto - 1;
			}
		}
	}	
}