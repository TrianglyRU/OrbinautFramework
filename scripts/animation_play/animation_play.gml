/// @function animation_play(sprite_id,speed,loop) 
function animation_play(sprite_id, speed, loop) 
{	
	// Ignore the animation method built into the IDE
	sprite_set_speed(sprite_id, 0, spritespeed_framespergameframe);
	
	// Is animation timer exists for this object?
	if !variable_instance_exists(id, "AnimationTimer")
	{	
		// Set animation timer
		AnimationTimer = abs(speed) + 1;
	}

	// Update the sprite if the current sprite is not the target one
	else if sprite_index != sprite_id
	{	
		// Set animation timer
		AnimationTimer = abs(speed) + 1;	
		
		// Reset
		image_index  = 0;
	    sprite_index = sprite_id; 
	}
	
	// Handle subimage change if the animation speed is not zero
	if speed != 0
	{
		// Decrease the value of the animation timer
		if AnimationTimer > 0
		{
			AnimationTimer--;
		}
			
		// Check if it equals zero
		if !AnimationTimer
		{	
			// Clamp doLoopFrom argument
			loop = clamp(loop, 1, image_number);
			
			// Reset animation timer to current animation speed
			AnimationTimer = abs(speed);
				
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
		}	
	}
}