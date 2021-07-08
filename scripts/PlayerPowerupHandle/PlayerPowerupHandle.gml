function PlayerPowerupHandle()
{
	// Check if player has died
	if Death
	{
		exit;
	}
	
	// Handle highspeed bonus
	if HighSpeedBonus
	{	
		// Decrease timer
		HighSpeedBonus--;
		
		// Restore normal physics when bonus has ended 
		if !HighSpeedBonus
		{
			if !InvincibilityBonus
			{
				audio_bgm_stop(TypePriority, 1);
			}
		}	
	}
	
	// Handle invincibility bonus
	if InvincibilityBonus 
	{
		// Make us invincible
		IsInvincible = true;
		
		// Check if star particles exist
		if !instance_exists(InvincibilityStar) 
		{
			// Create star particles
			for (var i = 1; i < 9; i++)
			{
				var spawnedStar	= instance_create(PosX, PosY, InvincibilityStar);
					spawnedStar.Number = i;
			}
			
			// Start frame for particles
			with InvincibilityStar 
			{
				animation_set_frame(Number mod 2 ? spr_obj_inv_star_type1 : spr_obj_inv_star_type2, Number);
			}
		}
		
		InvincibilityBonus--;
		
		if !InvincibilityBonus
		{
			if !HighSpeedBonus
			{
				audio_bgm_stop(TypePriority, 1);
			}
			instance_destroy(InvincibilityStar);
		}
	}
	
	// Decrease invincibility timer
	if IsInvincible and !InvincibilityBonus and !SuperState and !Hurt
	{
		IsInvincible--;
	}
}