function PlayerWaterEvents()
{
	if !Stage.WaterEnabled
	{
		return;
	}
	
	// Check for falling into the water
	if !IsUnderwater
	{
		if floor(PosY) > Stage.WaterLevel and !Death
		{
			audio_sfx_stop(sfxFlying);
			audio_sfx_stop(sfxTired);
				
			Xsp			*= 0.5;
			Ysp			*= 0.25;
			IsUnderwater = true;
			
			// Create bubble controller once we enter the water
			if !instance_exists(BubbleController) and !DebugMode
			{
				instance_create(-16, -16, BubbleController);
			}
				
			// Lower default gravity value by 0x28 (0.15625)
			if !Hurt and !FlightState and GlideState != GlideAir
			{
				Grv = 0.0625;
			}
				
			// Create splash object
			if !Grounded and !ClimbState and GlideState != GlideGround
			{
				instance_create(PosX, Stage.WaterLevel, WaterSplash);
			}
			
			// Destroy barrier
			if BarrierType == BarrierFlame or BarrierType == BarrierThunder
			{	
				if BarrierType == BarrierThunder
				{
					fade_perform(ModeFrom, BlendFlash, 4);
				}
				BarrierType = false;			
			}
		}
	}
	else
	{
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
					audio_bgm_play(AudioPrimary, Drowning);
				}
				AirTimer--
			}
		}
		
		// If ran out of air, drown
		else if !Death
		{
			if !Drown
			{
				audio_sfx_play(sfxDrown, false);
				
				Xsp	= 0;
				Ysp	= 0;
				Grv = 0.0625;
				
				Stage.TimeEnabled = false;
				Camera.Enabled    = false;
				AllowCollision    = false;
				Grounded	      = false;
				OnObject	      = false;
				GroundLock        = false;
				FlightState       = false;
				ClimbState	      = false;
				GlideState	      = false;
				Jumping		      = false;
				Spinning	      = false;
				DropdashRev       = -1;
				SpindashRev       = -1;
				PeeloutRev        = -1;
				DoubleSpinAttack  = SpinRecharge;
				DropdashFlag	  = DashLocked;
				Animation		  = AnimDrown;
				Drown			  = true;
				AirLock		      = true;	
				
				// Draw player above everything
				depth = 50;
			}
			else if floor(PosY) >= Camera.ViewY + global.Height + 276
			{
				Death = true;
			}
		}
		
		// If we have a barrier, destroy it
		if BarrierType == BarrierFlame or BarrierType == BarrierThunder
		{
			BarrierType = false;
		}
	
		// Check for leaving the water
		if PosY < Stage.WaterLevel and !Death
		{
			// Play previous track if running out of air
			if AirTimer <= 720
			{	
				if !SuperState
				{
					if HighspeedBonus
					{
						audio_bgm_play(AudioPrimary, HighSpeed);
					}
					else if InvincibleBonus
					{
						audio_bgm_play(AudioPrimary, Invincibility);
					}
					else
					{
						audio_bgm_play(AudioPrimary, Stage.StageMusic);
					}
				}
				else
				{
					audio_bgm_play(AudioPrimary, SuperTheme);
				}
			}
			
			IsUnderwater = false;	
			AirTimer     = 1800;
			
			// Reset Tails' gravity and double vertical speed
			if !Hurt and GlideState != GlideAir
			{
				if !global.S3WaterPhysics
				or  global.S3WaterPhysics and Ysp >= -4
				{
					Ysp *= 2;
				}
				if Ysp < -16
				{
					Ysp = -16;
				}
				
				if !FlightState
				{
					Grv = 0.21875;
				}
			}
			if FlightState
			{
				audio_sfx_play(sfxFlying, true);
			}
			
			// Create splash object
			if !Grounded and !ClimbState and GlideState != GlideGround
			{
				instance_create(PosX, Stage.WaterLevel, WaterSplash);
				audio_sfx_play(sfxWaterSplash, false);
			}
		}
	}
}