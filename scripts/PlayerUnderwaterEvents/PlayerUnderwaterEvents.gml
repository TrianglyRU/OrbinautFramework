function PlayerUnderwaterEvents()
{
	// Check for joining and exiting water
	if !isUnderwater
	{
		// Check for falling into the water
		if Stage.WaterEnabled and PosY > Stage.WaterLevel
		{
			Xsp			*= 0.5;
			Ysp			*= 0.25;
			isUnderwater = true;
			
			// Player can spend underwater for 30 seconds
			AirTimer = 1800;
			
			if !Grounded
			{
				instance_create(floor(PosX), floor(Stage.WaterLevel), WaterSplash);
				audio_sfx_play(sfxWaterSplash, false);
			}
		}
	}
	else
	{ 
		// Decrease timer
		if AirTimer > 0
		{
			AirTimer--;
		
			// Play alerts
			if AirTimer == 1500 or AirTimer == 1200 or AirTimer == 900
			{
				audio_sfx_play(sfxAirAlert, false);
			}
		
			// Play drowning music
			if AirTimer <= 720
			{			
				audio_bgm_play(Drowning, noone, 0, TypeNormal);
				audio_bgm_mute(TypePriority, 0);
			}
		}
		
		// Drown
		else if !Death
		{
			if !Drown
			{
				// Stop all audio
				audio_stop_all();
			
				// Play drown sound
				audio_sfx_play(sfxDrowning, false);
			
				if SuperState
				{
					SuperState = false;
				}
			
				Screen.CameraEnabled = false;
				Stage.TimeEnabled    = false;
				AllowCollision		 = false;
				Grounded			 = false;
				OnObject			 = false;
				Drown				 = true;
				Xsp					 = 0;
				Ysp					 = 0;
				MovementLock		 = -1;
				Animation			 = AnimDeath;	
			}
			else if floor(PosY) >= Screen.CameraY + Screen.Height + 276
			{
				Death = true;
			}
		}
		
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
			if AirTimer <= 720
			{	
				audio_bgm_unmute(TypePriority, 0);
				audio_bgm_play(Stage.StageMusic, noone, Stage.StageMusicLooppoint, TypeNormal);
			}
			
			if !Hurt and Animation != AnimSpring
			{
				Ysp	*= 2;
			}
			isUnderwater = false;
			
			// Reset air timer
			AirTimer = 1800;
			
			if !Grounded
			{
				instance_create(floor(PosX), floor(Stage.WaterLevel), WaterSplash);
				audio_sfx_play(sfxWaterSplash, false);
			}
		}
	}
}