/// @function animation_play(spriteid,duration,loopframe)
function animation_play(spriteid,duration,loopframe)
{
	// Set animation for the instance
	if sprite_index != spriteid or event_type == ev_create
	{
		if !is_array(duration)
		{
			Obj_AnimTimer = abs(duration);
		}
		else
		{
			Obj_AnimTimer = abs(duration[0]);	
		}
		Obj_AnimDuration  = duration;
		Obj_AnimLoopframe = loopframe;
		sprite_index      = spriteid;
		image_index		  = 0;
		image_speed		  = 0;
	}
	
	// Update if called every frame
	else 
	{
		// Update target frame duration
		if !is_array(duration) and Obj_AnimDuration != duration
		or  is_array(duration) and !is_array(Obj_AnimDuration)
		{
			if !is_array(duration)
			{
				if Obj_AnimTimer == 0
				{
					Obj_AnimTimer = abs(duration);
				}
				Obj_AnimDuration = duration;
			}
			else
			{
				Obj_AnimTimer    = abs(duration[0]);
				Obj_AnimDuration = duration;
			}
		}
		
		// Update target loop frame
		if Obj_AnimLoopframe != loopframe
		{
			Obj_AnimLoopframe = loopframe;
		}
	}
}