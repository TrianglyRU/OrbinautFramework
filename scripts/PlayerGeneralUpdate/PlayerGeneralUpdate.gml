function PlayerGeneralUpdate()
{
	// Check for entering for exiting debug mode
	if Game.DevMode and Input.BPress and !Death
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
		
		// Apply highspeed physics
		Acc     = 0.09375;
		Frc     = 0.09375;
		AirAcc  = 0.1875;
		RollFrc = 0.046875;
		TopAcc  = 12;
		
		// Restore normal physics when bonus has ended 
		if !HighSpeedBonus
		{
			if !InvincibilityBonus
			{
				audio_bgm_stop(TypePriority, 1);
			}
			
			Acc	    = 0.046875;
			Frc     = 0.046875;
			AirAcc  = 0.09375;
			RollFrc = 0.0234375;
			TopAcc  = 6;
		}
	}
	
	// Handle underwater physics
	if !isUnderwater
	{
		// Check for falling into the water
		if Stage.WaterEnabled and PosY > Stage.WaterLevel and !Death
		{
			Xsp			*= 0.5;
			Ysp			*= 0.25;
			isUnderwater = true;
			
			instance_create(floor(PosX), floor(Stage.WaterLevel), WaterSplash);
			audio_sfx_play(sfxWaterSplash, false, true);
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
			
		// Apply underwater physics if not in superform
		if !isSuper
		{
			Acc		= 0.0234375;
			Dec		= 0.25;
			Frc		= 0.0234375;
			RollFrc = 0.01171875;
			TopAcc  = 3;
			AirAcc  = 0.046875;
			JumpMin = -2;
			Jump    = CharacterID == CharKnuckles ? 3 : 3.5;
		}
		Grv	= 0.0625;
		
		// Check for leaving the water
		if !Death and PosY < Stage.WaterLevel
		{
			if !Hurt
			{
				Ysp	*= 2;
			}
			isUnderwater = false;
			
			instance_create(floor(PosX), floor(Stage.WaterLevel), WaterSplash);
			audio_sfx_play(sfxWaterSplash, false, true);
			
			// Restore normal physics if not in superform
			if !isSuper
			{
				Acc		= 0.046875;
				Frc     = 0.046875;
				AirAcc  = 0.09375;
				RollFrc = 0.0234375;
				Dec		= 0.5;			
				TopAcc	= 6;
				JumpMin = -4;
				Jump    = CharacterID == CharKnuckles ? 6 : 6.5;
			}
			Grv	= 0.21875;
		}
	}
	
	// Handle superform physics
	if isSuper
	{
		// Make us invincible
		isInvincible = true;
		
		if Rings > 0
		{
			// Apply superform physics for Sonic
			if CharacterID == CharSonic
			{
				if !isUnderwater
				{
					Acc	    = 0.1875;
					AirAcc  = 0.375;
					Dec     = 1;
					TopAcc  = 10;
					Jump    = 8;
					RollFrc = 0.09375;
				}
				else
				{
					Acc	    = 0.09375;
					AirAcc  = 0.1875;
					Dec     = 0.5;
					TopAcc  = 5;
					Jump    = 8;
					RollFrc = 046875;
				}
				if (Game.ConstantRollFrc) RollFrc = 0.0234375;
			}
			
			// Apply superform physics for Tails and Knuckles
			else
			{
				if !isUnderwater
				{
					Acc     = 0.09375;
					AirAcc  = 0.1875;
					Dec     = 0.75;
					TopAcc  = 8;		
					RollFrc = 0.0234375;
				}
				else
				{
					Acc     = 0.046875;
					AirAcc  = 0.1875;
					Dec     = 0.375;
					TopAcc  = 4;		
					RollFrc = 0.0234375;
				}
			}
			Frc = 0.046875;
			
			// Decrease rings
			Rings -= 1/60;
		}
		
		// Leave super state if no rings left
		else
		{
			isSuper = false;
			Acc		= 0.046875;
			Frc     = 0.046875;
			AirAcc  = 0.09375;
			RollFrc = 0.0234375;
			Dec		= 0.5;			
			TopAcc	= 6;
			Jump    = CharacterID == CharKnuckles ? 6 : 6.5;
		}
	}
	
	// Apply regular gravity if player has died
	if Death
	{
		Grv	= 0.21875;
	}
	
	// Stop forced roll if we unrolled
	if !Rolling
	{
		ForcedRoll = false;
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
	
	// Decrease temp invincibility timer
	if (isInvincible and !InvincibilityBonus and !isSuper) isInvincible--;
}