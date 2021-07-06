function PlayerGeneralUpdate()
{
	// Handle superform
	switch SuperState
	{	
		// Transformation start
		case 1:
		{
			// Make us invincible
			IsInvincible = true;
			
			// Start timer
			SuperStateValue++
			
			// Become super after 24 frames
			if SuperStateValue == 25
			{
				SuperState		= 2;
				SuperStateValue = 0;
			}				
		}
		break;
		case 2:
		{
			// Keep us invincible
			IsInvincible = true;
			
			
			// Decrease rings
			if Rings
			{
				SuperStateValue++
				
				if SuperStateValue mod 60 == 0
				{
					SuperStateValue = 0;
					Rings--;
				}
			}
			
			// Exit superform
			else
			{
				SuperStateValue = 0;
				SuperState		= 0;
			}
		}
		break;
		case 0:
		{		
			// Start timer
			SuperStateValue++
			
			// Become regylar after 24 frames
			if SuperStateValue == 25
			{
				SuperState		= -1;
				SuperStateValue = 0;
			}
		}
		break;		
	}
	
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
			IsInvincible = false;
			
			if !HighSpeedBonus
			{
				audio_bgm_stop(TypePriority, 1);
			}
			instance_destroy(InvincibilityStar);
		}
	}
	
	// Check for joining and exiting water
	if !isUnderwater
	{
		// Check for falling into the water
		if Stage.WaterEnabled and PosY > Stage.WaterLevel
		{
			Xsp			*= 0.5;
			Ysp			*= 0.25;
			isUnderwater = true;
			
			if !Grounded
			{
				instance_create(floor(PosX), floor(Stage.WaterLevel), WaterSplash);
				audio_sfx_play(sfxWaterSplash, false);
			}
		}
	}
	else
	{ 
		// Disable barrier
		if BarrierType == BarrierFlame or BarrierType == BarrierThunder
		{	
			if BarrierType == BarrierThunder
			{
				fade_perform(from, flash, 12);
			}
			BarrierType = false;
			instance_destroy(Barrier);				
		}
			
		// Check for leaving the water
		if PosY < Stage.WaterLevel
		{
			if !Hurt and Animation != AnimSpring
			{
				Ysp	*= 2;
			}
			isUnderwater = false;
			
			if !Grounded
			{
				instance_create(floor(PosX), floor(Stage.WaterLevel), WaterSplash);
				audio_sfx_play(sfxWaterSplash, false);
			}
		}
	}
	
	// Stop forced roll if we unrolled
	if !Rolling
	{
		ForcedRoll = false;
	}
	
	// Decrease invincibility timer
	if IsInvincible and !InvincibilityBonus and !SuperState and !Hurt
	{
		IsInvincible--;
	}
}