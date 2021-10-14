function ObjStarPostPortalMain()
{
	// Handle size change
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
	
	// Handle portal
	if !State
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
				
				// Stop music
				audio_bgm_stop(PriorityLow,  0.5);
				audio_bgm_stop(PriorityHigh, 0.5);
			}
		}
	}
}