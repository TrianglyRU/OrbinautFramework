/// @function animation_play(objSprite, aniSpeed, doLoopFrom) 
function animation_play(objSprite, aniSpeed, doLoopFrom) 
{	
	// Report script error
	if doLoopFrom < 1 or doLoopFrom > image_number
	{
		show_message("Wrong doLoopFrom attribute set in function animation_play for animation " + string(sprite_get_name(objSprite)) + ". doLoopFrom should not be lower than 1 or higher than sprite frames number.");
		game_end();
	}
	
	// Force GMS sprite speed to be 0
	image_speed = 0;
	
	// Set anitimer variable
	if !variable_instance_exists(id, "aniTimer")
	{
		aniTimer = 0;
	}
	
	// Update sprite
	if sprite_index != objSprite
	{
	    sprite_index = objSprite;
	    image_index  = 0;
		aniTimer	 = aniSpeed;
	}
	
	// Hangle subimage change
	else
	{
	    if aniTimer > 1
		{
			aniTimer--;
		}
	    else
	    {	
			image_index = image_index < image_number - 1 ? image_index + 1 : doLoopFrom - 1;
			aniTimer = aniSpeed;
	    }	
	}
}