/// @function animation_play(sprite_id,speed,loop) 
function animation_play(sprite_id, speed, loop) 
{	
	// Ignore the animation method built into the IDE
	sprite_set_speed(sprite_id, 0, spritespeed_framespergameframe);
	
	if sprite_index != sprite_id or !variable_instance_exists(id, "Obj_AnimationTimer")
	{
		Obj_AnimationTimer = abs(speed) + 1;
	    sprite_index   = sprite_id; 
		image_index    = 0;
	}

	// Handle subimage change if the animation speed is not zero
	if speed != 0 and fade_check(FadeNone)
	{
		// Decrease the value of the animation timer
		if Obj_AnimationTimer > 0
		{
			Obj_AnimationTimer--;
		}
			
		// Check if it equals zero
		if !Obj_AnimationTimer
		{	
			// Clamp doLoopFrom argument
			loop = clamp(loop, 1, image_number);
			
			// Reset animation timer to current animation speed
			Obj_AnimationTimer = abs(speed);
				
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