/// @function animation_play(sprite_id,speed,loop) 
function animation_play(sprite_id, speed, loop) 
{	
	// Ignore the animation method built into the IDE 
	image_speed = 0;
	
	// Create a special timer variable for the object
	if !variable_instance_exists(id, "AnimationTimer")
	{
		id.AnimationTimer = abs(speed);
	}
	
	// Update the sprite if the current sprite is not the target one
	if sprite_index != sprite_id
	{
		image_index  = 0;
	    sprite_index = sprite_id; 
		
		// Set animation timer to current animation speed
		id.AnimationTimer = abs(speed);
	}
	
	// Hangle subimage change
	else
	{
		// Clamp doLoopFrom argument
		loop = clamp(loop, 1, image_number);
		
		// Check if the animation speed is not zero
		if speed != 0
		{
			// Decrease the value of the animation timer
		    if id.AnimationTimer > 1
			{
				id.AnimationTimer--;
			}
			
			// Check if it equals zero
		    else
		    {	
				// Switch to the next subimage if the animation speed is positive
				if speed > 0
				{
					image_index = image_index < image_number - 1 ? image_index + 1 : loop - 1;
				}
				
				// Switch to the previous subimage if the animation speed is negative
				else
				{
					image_index = image_index > 0 ? image_index - 1 : image_number - 1 * loop;
				}
				
				// Reset animation timer to current animation speed
				id.AnimationTimer = abs(speed);
		    }	
		}
	}
}