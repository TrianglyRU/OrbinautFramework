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
				
				// Lower default gravity value by 0x28 (0.15625)
				if !Hurt and !FlightState and GlideState != GlideActive
				{
					Grv = 0.0625;
				}
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
		// Create player bubble maker object
		if !instance_exists(BubbleMakerPlayer)
		{
			instance_create(-16, -16, BubbleMakerPlayer);
		}
		
		// Air countdown
		if AirTimer > 0
		{
			if BarrierType != BarrierWater and !Stage.IsFinished
			{
				if AirTimer == 1500 or AirTimer == 1200 or AirTimer == 900
				{
					audio_sfx_play(sfxAirAlert, false);
				}
				else if AirTimer == 720
				{			
					audio_bgm_play(PriorityLow, DrowningMusic, noone);
				}
				AirTimer--
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
				
				NoControls			 = true;
				Camera.Enabled = false;
				Stage.TimeEnabled    = false;
				AllowCollision		 = false;
				Grounded			 = false;
				OnObject			 = false;	
				Drown				 = true;
				DrawOrder			 = 0;
				Xsp					 = 0;
				Ysp					 = 0;
				Animation			 = AnimDrown;	
			}
			else if floor(PosY) >= Camera.ViewY + Game.Height + 276
			{
				Death = true;
			}
		}
		
		// Disable barrier
		if BarrierType == BarrierFlame or BarrierType == BarrierThunder
		{	
			if BarrierType == BarrierThunder
			{
				fade_perform(FadeFrom, FadeFlash, 12);
			}
			BarrierType = false;
			instance_destroy(Barrier);				
		}
			
		// Check for leaving the water
		if PosY < Stage.WaterLevel
		{
			// Play previous track if running out of air
			if AirTimer <= 720
			{	
				if !SuperState
				{
					if HighspeedBonus
					{
						audio_bgm_play(PriorityLow, HighspeedMusic, noone);
					}
					else if InvincibleBonus
					{
						audio_bgm_play(PriorityLow, InvincibilityMusic, noone);
					}
					else
					{
						audio_bgm_play(PriorityLow, Stage.StageMusic, other);
					}
				}
				else
				{
					audio_bgm_play(PriorityLow, SuperMusic, other);
				}
			}
			
			// Create player bubble maker object
			instance_destroy(BubbleMakerPlayer);
			
			// Reset air timer
			AirTimer = 1800;
			
			// Increase default gravity value by 0x28 (0.15625), and double ysp
			if !Hurt and !FlightState and GlideState != GlideActive
			{
				Grv	 = 0.21875;
				Ysp *= 2;
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