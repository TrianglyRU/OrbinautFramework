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
					audio_bgm_play(ChannelPrimary, Drowning);
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
				Grv = 0.0625;
				
				// Set flags
				Stage.TimeEnabled = false;
				Camera.Enabled    = false;
				ClimbState		  = false;
				GlideState		  = false;
				GlideValue		  = false;
				FlightState       = false;
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
				fade_perform(ModeFrom, BlendFlash, 8);
			}
			BarrierType = false;			
		}
			
		// Check for leaving the water
		if PosY < Stage.WaterLevel and !Death
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
						audio_bgm_play(ChannelPrimary, HighSpeed);
					}
					else if InvincibleBonus
					{
						audio_bgm_play(ChannelPrimary, Invincibility);
					}
					else
					{
						audio_bgm_play(ChannelPrimary, Stage.StageMusic);
					}
				}
				else
				{
					audio_bgm_play(ChannelPrimary, SuperTheme);
				}
			}
			
			// Reset gravity and double vertical speed
			if !Hurt and GlideState != GlideAir
			{
				if Game.S3KWaterPhysics
				{
					if Ysp >= -4
					{
						Ysp *= 2;
					}
				}
				else
				{
					Ysp *= 2;
				}
				Grv = 0.21875;
				
				// Limit vertical speed
				if Ysp < -16
				{
					Ysp = -16;
				}
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