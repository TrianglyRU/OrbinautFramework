function PlayerWaterEvents()
{
	// If there is no water in the stage, exit
	if !Stage.WaterEnabled
	{
		exit;
	}
	
	// Check for falling into the water
	if !IsUnderwater
	{
		if floor(PosY) > Stage.WaterLevel and !Death
		{
			Xsp			*= 0.5;
			Ysp			*= 0.25;
			IsUnderwater = true;
				
			// Lower default gravity value by 0x28 (0.15625)
			if !Hurt and !FlightState and GlideState != GlideAir
			{
				Grv = 0.0625;
			}
				
			// Stop sound
			if FlightState
			{
				audio_sfx_stop(sfxFlying);
				audio_sfx_stop(sfxTired);
			}
				
			// Create splash object
			if !Grounded
			{
				audio_sfx_play(sfxWaterSplash, false);
				instance_create(PosX, Stage.WaterLevel, WaterSplash);
			}
		}
	}
	else
	{ 
		// Create player bubble maker object
		if !instance_exists(BubbleController)
		{
			instance_create(-16, -16, BubbleController);
		}
		
		// Countdown air timer
		if AirTimer > 0
		{
			if BarrierType != BarrierWater and !Stage.IsFinished and !Death
			{
				if AirTimer == 1500 or AirTimer == 1200 or AirTimer == 900
				{
					audio_sfx_play(sfxAirAlert, false);
				}
				else if AirTimer == 720
				{			
					audio_bgm_play(PriorityLow, Drowning, noone);
				}
				AirTimer--
			}
		}
		
		// If ran out of air, drown
		else if !Death
		{
			if !Drown
			{
				// Reset speeds
				Xsp	= 0;
				Ysp	= 0;
				
				// Set flags
				Stage.TimeEnabled = false;
				Camera.Enabled    = false;
				AllowCollision    = false;
				Grounded		  = false;
				OnObject		  = false;	
				Drown			  = true;
				AirLock		      = true;
				Animation		  = AnimDrown;	
				
				// Draw player above everything
				DrawOrder = 0;
				
				// Play sound
				audio_sfx_play(sfxDrowning, false);
			}
			
			// Enter death state if off-screen
			else if floor(PosY) >= Camera.ViewY + Game.Height + 276
			{
				Death = true;
			}
		}
		
		// Destroy barrier
		if BarrierType == BarrierFlame or BarrierType == BarrierThunder
		{	
			if BarrierType == BarrierThunder
			{
				fade_perform(FadeFrom, ColourFlash, 8);
			}
			BarrierType = false;
			instance_destroy(Barrier);				
		}
			
		// Check for leaving the water
		if PosY < Stage.WaterLevel
		{
			// Destroy player bubble maker object
			if instance_exists(BubbleController)
			{
				instance_destroy(BubbleController);
			}
			
			// Play previous track if running out of air
			if AirTimer <= 720
			{	
				if !SuperState
				{
					if HighspeedBonus
					{
						audio_bgm_play(PriorityLow, HighSpeed, noone);
					}
					else if InvincibleBonus
					{
						audio_bgm_play(PriorityLow, Invincibility, noone);
					}
					else
					{
						audio_bgm_play(PriorityLow, Stage.StageMusic, other);
					}
				}
				else
				{
					audio_bgm_play(PriorityLow, SuperTheme, other);
				}
			}
			
			// Reset gravity and double vertical speed
			if !Hurt and !FlightState and GlideState != GlideAir
			{
				Grv	 = 0.21875;
				Ysp *= 2;
			}
			
			// Play sound
			if FlightState
			{
				audio_sfx_play(sfxFlying, true);
			}
			IsUnderwater = false;	
			AirTimer     = 1800;
			
			// Create splash object
			if !Grounded
			{
				instance_create(PosX, Stage.WaterLevel, WaterSplash);
				audio_sfx_play(sfxWaterSplash, false);
			}
		}
	}
}