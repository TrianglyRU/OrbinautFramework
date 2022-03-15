/// @description Process Animations
// You can write your code in this editor
	
	/* Animations are processed here! */
	
	if !UpdateAnimations
	{
		return;
	}
	
	// Process global animation timer
	AnimationTime[? GlobalTime]++;
	
	// Process animations for all instances
	with all 
	{
		var FrameDuration  = is_array(Obj_AnimDuration) ? Obj_AnimDuration[image_index] : Obj_AnimDuration;
		if  FrameDuration != 0
		{
			if !(--Obj_AnimTimer)
			{
				// Switch to the previous subimage
				if FrameDuration < 0
				{
					if image_index > 0
					{
						image_index--;
					}
					else
					{
						image_index = image_number - Obj_AnimLoopframe - 1;
					}
				}
					
				// Switch to the next subimage
				else
				{
					if image_index < image_number - 1
					{
						image_index++;
					}
					else
					{
						image_index = Obj_AnimLoopframe;
					}
				}
					
				// Reset timer
				if !is_array(Obj_AnimDuration)
				{
					Obj_AnimTimer = abs(Obj_AnimDuration);
				}
				else
				{
					Obj_AnimTimer = abs(Obj_AnimDuration[image_index]);
				}
			}
		}		
	}