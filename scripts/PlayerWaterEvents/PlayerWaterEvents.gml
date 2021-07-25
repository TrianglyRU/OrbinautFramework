function PlayerWaterEvents()
{
	// Check if player has died
	if Death
	{
		exit;
	}
	
	// Check for joining and exiting water
	if !IsUnderwater
	{
		// Check for falling into the water
		if Stage.WaterEnabled
		{
			if floor(PosY) > Stage.WaterLevel
			{
				Xsp			*= 0.5;
				Ysp			*= 0.25;
				IsUnderwater = true;
			
				// Player can spend underwater for 30 seconds
				AirTimer = 1800;
			
				if !Grounded
				{
					instance_create(floor(PosX), floor(Stage.WaterLevel), WaterSplash);
					audio_sfx_play(sfxWaterSplash, false);
				}
			}
		}
	}
	else
	{ 
		// Decrease timer
		if AirTimer > 0
		{
			if Stage.Time mod 60 == 0
			{
				instance_create(floor(PosX), floor(PosY), Bubble);
			}
			
			if !Stage.IsFinished and BarrierType != BarrierWater
			{
				// Decrease timer
				AirTimer--
				
				// Play alerts
				if AirTimer == 1500 or AirTimer == 1200 or AirTimer == 900
				{
					audio_sfx_play(sfxAirAlert, false);
				}
		
				// Play drowning music
				if AirTimer == 720
				{			
					audio_bgm_play(Drowning, -1, TypeNormal);
					audio_bgm_mute(TypePriority, 0);
				}
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
			
				Screen.CameraEnabled = false;
				Stage.TimeEnabled    = false;
				SuperState			 = false;
				AllowCollision		 = false;
				Grounded			 = false;
				OnObject			 = false;
				Drown				 = true;
				Xsp					 = 0;
				Ysp					 = 0;
				MovementLock		 = -1;
				Animation			 = AnimDrown;	
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
				
				if !SuperState
				{
					audio_bgm_play(Stage.StageMusic, Stage.StageMusicLooppoint, TypeNormal);
				}
				else
				{
					audio_bgm_play(SuperTheme, 0.6, TypeNormal);
				}
			}
			
			if !Hurt
			{
				// Double (and limit) ysp
				Ysp = max(Ysp * 2, -16);
			}
			IsUnderwater = false;
			
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