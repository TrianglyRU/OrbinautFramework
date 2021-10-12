function ObjStarPostEffectMain()
{
	// Exit if stage is paused (object is ignored to deactivate automatically)
	if Stage.IsPaused
	{
		exit;
	}
	
	// Change the size if fade is not active
	if !fade_check(FadeActive)
	{
		if Timer < 128
		{
			Diameter++;
		}
		else if Timer > 472
		{
		   Diameter--;
	   
		   // Update hitbox
		   object_set_hitbox(Diameter >> 3, 4);
		}
	}
	
	switch State
	{
		case 0:
		{
			if (++Timer) == 600
			{
				instance_destroy();
			}
			else if Timer > 60
			{
				if !State and object_check_overlap(Hitbox)
				{
					State++;
					fade_perform(FadeTo, ColourBlack, 1);		
				}
			}
		}
		break;
		case 1:
		{
			if fade_check(FadeMax)
			{
				// TODO: send to bonus stage
				room_restart();
			}
		}
		break;
	}
}