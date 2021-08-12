function PlayerPowerup()
{
	// Check if player has died
	if Death
	{
		exit;
	}
	
	// Handle highspeed bonus
	if HighSpeedBonus
	{	
		// Count down the timer
		if !(--HighSpeedBonus)
		{
			// Play stage music
			if audio_bgm_is_playing(HighspeedMusic)
			{
				audio_bgm_play(PriorityLow, Stage.StageMusic, other);
			}
		}	
	}
	
	// Handle invincibility bonus
	if InvincibilityBonus 
	{
		// Check if star particles exist
		if !instance_exists(InvincibilityStar) 
		{
			// Create star particles
			for (var i = 1; i < 9; i++)
			{
				var SpawnedStar	= instance_create(PosX, PosY, InvincibilityStar);
					SpawnedStar.Number = i;
			}
			
			// Start frame for particles
			with InvincibilityStar 
			{
				animation_set_frame(Number mod 2 ? spr_obj_inv_star_type1 : spr_obj_inv_star_type2, Number);
			}
		}
		
		// Count down the timer
		if !(--InvincibilityBonus)
		{
			// Play stage music
			if audio_bgm_is_playing(InvincibilityMusic)
			{
				audio_bgm_play(PriorityLow, Stage.StageMusic, other);
			}
		}
	}
	
	// Decrease invincibility timer
	if InvincibilityFrames and !Hurt
	{
		InvincibilityFrames--;
	}
}