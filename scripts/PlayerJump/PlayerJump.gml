function PlayerJump()
{
	if !Jumping
	{
		return;
	}
	
	if !Input.ABC
	{
		// Shorten jump force
		if Ysp < JumpMin
		{
			Ysp = JumpMin;
		}
		
		// Update dropdash flag
		if DropdashFlag == DashLocked
		{
			DropdashFlag = DashReady;
		}
		else if DropdashFlag == DashActive
		{
			if DropdashRev == 20
			{
				Animation    = AnimSpin;
				DropdashFlag = DashRecharge;
			}
			DropdashRev = -1;
		}
	}
	
	/* Everything below is special mid-jump actions */
	
	if Ysp < JumpMin or !Input.ABCPress
	{
		return;
	}
	
	// Transform into the super form
	if global.Emeralds == 7 and !SuperState and Rings >= 50 and !Stage.IsFinished
	{
		if global.Character != CharSonic or BarrierType <= BarrierNormal
		{
			Animation		    = AnimTransform;
			InvincibilityFrames = 0;
			Jumping				= false;
			Spinning			= false;
			InvincibleBonus		= false;
			AllowCollision		= false;
			SuperStateValue		= false;
			SuperState			= true;
			AirLock				= true;
			
			RadiusX = DefaultRadiusX;
			RadiusY = DefaultRadiusY;
		
			audio_sfx_play(sfxTransform, false);		
			audio_bgm_play(AudioPrimary, SuperTheme);
			
			return;
		}
	}

	// Perform character action
	switch global.Character
	{
		case CharSonic:
		{	
			if BarrierType <= BarrierNormal
			{	
				// Perform double spin attack
				if !BarrierType and !SuperState and !InvincibleBonus
				{
					if global.DSpinAttackEnabled and DoubleSpinAttack == SpinReady
					{
						AirLock			 = false;
						DoubleSpinAttack = SpinActive;
						
						instance_create(PosX, PosY, DoubleSpinShield);
						audio_sfx_play(sfxDoubleSpinAttack, false);
					}
				}
				
				// Perform dropdash
				if global.DropdashEnabled and DropdashFlag == DashReady
				{
					AirLock      = false;
					DropdashFlag = DashActive;
				}
			}
			
			// Perform barrier action
			else if !(InvincibleBonus or BarrierIsActive or SuperState)
			{	
				BarrierIsActive = true;
				
				switch BarrierType
				{
					case BarrierFlame:
					{
						if !global.CDCamera
						{
							Camera.ScrollDelay = 16;
						}
						
						AirLock = true;
						Xsp		= 8 * Facing;
						Ysp		= 0;
												
						// Update barrier
						with Barrier
						{
							object_set_depth(Player, 1);
							animation_play(spr_obj_barrier_flame_dash, 2, 0);
						}
						
						audio_sfx_play(sfxFlameBarrierDash, false);
					}
					break;
					case BarrierThunder:
					{	
						AirLock = false;
						Ysp		= -5.5;
						
						// Create sparkles
						for (var i = 0; i < 4; i++)
						{
							var  Object = instance_create(PosX, PosY, BarrierSparkle);
							with Object
							{
								SparkleID = i;
							}
						}
						
						audio_sfx_play(sfxThunderBarrierJump, false);
					}
					break;
					case BarrierWater:
					{						
						AirLock = false;
						Xsp		= 0;
						Ysp		= 8;
						
						// Update barrier
						with Barrier
						{
							animation_play(spr_obj_barrier_water_drop, [6, 19, 0], 0);
						}

						audio_sfx_play(sfxWaterBarrierBounce, false);
					}
					break;
				}
			}
		}
		break;
		case CharTails:
		{
			RadiusX		= DefaultRadiusX;
			RadiusY		= DefaultRadiusY;
			AirLock     = false;
			Jumping     = false;
			Spinning    = false;
			FlightState = true;
			FlightValue = 480;
			Grv			= 0.03125;
			
			if !IsUnderwater
			{
				audio_sfx_play(sfxFlying, true);
			}
				
			Input.ABC      = false;
			Input.ABCPress = false;
		}
		break;
		case CharKnuckles:
		{
			Gsp		= 0;
			Xsp		= 4 * Facing;
			Ysp		= Ysp <= 0 ? 0 : Ysp + 2;
			
			RadiusX		   = 10;
			RadiusY		   = 10;
			AirLock        = false;
			Jumping        = false;
			Spinning       = false;
			Animation	   = AnimGlide;
			GlideState     = GlideAir;
			GlideDirection = Facing;
			GlideValue     = Facing == FlipLeft ? 0 : 180;
		}
		break;
	}
}