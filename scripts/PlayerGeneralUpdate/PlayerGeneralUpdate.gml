function PlayerGeneralUpdate()
{
	// Check if player has died
	if Death
	{
		exit;
	}
	
	// Check for entering for exiting debug mode
	if Game.DevMode and Input.BPress
	{
		DebugMode      = !DebugMode;	
		DebugSpeed     = 0;
		Hurt		   = false;
		MovementLock   = false;
		SpindashRev    = -1;
		PeeloutRev     = -1;
		DropdashRev    = -1;
		Grounded	   =  DebugMode;
		AllowCollision = !DebugMode;	
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
	
	// Handle superform
	switch SuperState
	{	
		// Transformation start
		case SuperStart:
		{
			// Start timer
			SuperStateValue++
				
			// Make us invincible
			IsInvincible = true;
				
			// Become super after 18 frames
			if SuperStateValue == 18
			{
				SuperState		= SuperActive;
				SuperStateValue = 0;
			}
		}
		break;
		case SuperActive:
		{
			// Make us invincible
			IsInvincible = true;
			
			// Decrease rings
			if Rings
			{
				Rings -= 1/60;
			}
			
			// Exit superform
			else
			{
				SuperState = SuperEnd;
			}
		}
		break;
		case SuperEnd:
		{
			// Start timer
			SuperStateValue++
			
			// Make us invincible
			IsInvincible = true;
				
			// Become regylar after 18 frames
			if SuperStateValue == 18
			{
				SuperState		= false;
				SuperStateValue = 0;
			}
		}
		break;		
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
			
			instance_create(floor(PosX), floor(Stage.WaterLevel), WaterSplash);
			audio_sfx_play(sfxWaterSplash, false);
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
			
			instance_create(floor(PosX), floor(Stage.WaterLevel), WaterSplash);
			audio_sfx_play(sfxWaterSplash, false);
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