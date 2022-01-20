/// @function animation_play(spriteid,duration,loopframe)
function animation_play(spriteid,duration,loopframe)
{
	// Update or set animation
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
	}
	else 
	{
		// Update duration
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
		
		// Update loopframe
		if Obj_AnimLoopframe != loopframe
		{
			Obj_AnimLoopframe = loopframe;
		}
	}
}