/// @function animation_play(spriteID, aniSpeed, doLoopFrom) 
function animation_play(spriteID, aniSpeed, doLoopFrom) 
{	
	// Force GMS sprite speed to be 0
	image_speed = 0;
	
	// Set anitimer variable
	variable_set_temp("aniTimer");
	
	// Update sprite
	if sprite_index != spriteID
	{
		image_index  = 0;
	    sprite_index = spriteID; 
		aniTimer	 = abs(aniSpeed);
	}
	
	// Hangle subimage change
	else
	{
		// Report script error
		if doLoopFrom < 1 or doLoopFrom > image_number
		{
			show_message("Wrong doLoopFrom attribute set in function animation_play for animation " + string(sprite_get_name(spriteID)) + ". doLoopFrom should not be lower than 1 or higher than sprite frames number.");
			game_end();
		}
		if aniSpeed != 0
		{
		    if aniTimer > 1
			{
				aniTimer--;
			}
		    else
		    {	
				if aniSpeed > 0
				{
					image_index = image_index < image_number - 1 ? image_index + 1 : doLoopFrom - 1;
				}
				else
				{
					image_index = image_index > 0 ? image_index - 1 : image_number - 1 * doLoopFrom;
				}
				aniTimer = abs(aniSpeed);
		    }	
		}
	}
}