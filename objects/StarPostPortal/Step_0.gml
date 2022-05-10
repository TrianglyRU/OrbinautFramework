/// @description Main
// You can write your code in this editor

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
			if !State and object_check_player(ColHitbox)
			{
				fade_perform(ModeInto, BlendBlack, 1);
				audio_bgm_stop(AudioPrimary,  0.5);
				audio_bgm_stop(AudioSecondary, 0.5);
				
				Input.IgnoreInput		  = true;
				Stage.UpdateObjects       = false;
				Stage.TimeEnabled         = false;
				Renderer.UpdateAnimations = false;
				
				// Increment state
				State++;
			}
		}
	}