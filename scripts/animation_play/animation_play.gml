/// @function animation_play(spriteID, aniSpeed, doLoopFrom) 
function animation_play(spriteID, aniSpeed, doLoopFrom) 
{	
	// Ignore the IDE method
	image_speed = 0;
	
	// Create a timer variable for the instance
	variable_set_temp("aniTimer");
	
	// Update sprite if it's not target one
	if sprite_index != spriteID
	{
		image_index  = 0;
	    sprite_index = spriteID; 
		
		// Set animation timer to current animation speed
		aniTimer = abs(aniSpeed);
	}
	
	// Hangle subimage change
	else
	{
		// Clamp doLoopFrom argument
		doLoopFrom = clamp(doLoopFrom, 1, image_number);
		
		// Check if animation speed does not equal to 0
		if aniSpeed != 0
		{
			// Decrease animaton timer
		    if aniTimer > 1
			{
				aniTimer--;
			}
			
			// Check if animation timer equals to 0
		    else
		    {	
				// Switch to the next subimage
				if aniSpeed > 0
				{
					image_index = image_index < image_number - 1 ? image_index + 1 : doLoopFrom - 1;
				}
				
				// Switch to the previous subimage
				else
				{
					image_index = image_index > 0 ? image_index - 1 : image_number - 1 * doLoopFrom;
				}
				
				// Reset animation timer to current animation speed
				aniTimer = abs(aniSpeed);
		    }	
		}
	}
}