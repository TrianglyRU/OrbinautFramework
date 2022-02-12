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
		
		// Reset dropdash
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
			DropdashRev  = -1;
		}
	}
	
	/* Everything below is special mid-jump actions */
	
	// Do not perform anything if action button hasn't been released just yet
	if Ysp < JumpMin or !Input.ABCPress
	{
		return;
	}
	
	// Transform into super form
	if global.Emeralds == 7 and !SuperState and Rings >= 50 and !Stage.IsFinished
	{
		// Make sure we don't have elemental barrier if we're Sonic
		if global.Character == CharSonic and BarrierType <= BarrierNormal
		or global.Character != CharSonic
		{
			// Set animation
			Animation		    = AnimTransform;
			InvincibilityFrames = 0;
			Jumping				= false;
			Spinning			= false;
			InvincibleBonus		= false;
			SuperStateValue		= false;
			SuperState			= true;
			AirLock				= true;
			
			RadiusX = DefaultRadiusX;
			RadiusY = DefaultRadiusY;
		
			audio_sfx_play(sfxTransform, false);		
			audio_bgm_play(TypePrimary, SuperTheme);
			
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
				if !BarrierType
				{
					if global.DSpinAttackEnabled and !(InvincibleBonus or SuperState or DoubleSpinAttack != SpinReady)
					{
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
												
						// Update barrier animation
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
						
						// Update barrier animation
						with Barrier
						{
							animation_play(spr_obj_barrier_water_drop, [6, 19, 0], 0);
						}

						audio_sfx_play(sfxWaterBarrierBounce, false);
					}
					break;
				}
					
				// Set flag
				BarrierIsActive = true;
			}
		}
		break;
		case CharTails:
		{
			// Reset collision radiuses
			RadiusX = DefaultRadiusX;
			RadiusY = DefaultRadiusY;
				
			// Set flags
			AirLock     = false;
			Jumping     = false;
			Spinning    = false;
			FlightState = true;
			FlightValue = 480;
			Grv			= 0.03125;
				
			// Play sound
			if !IsUnderwater
			{
				audio_sfx_play(sfxFlying, true);
			}
				
			// Clear action buttons
			Input.ABC      = false;
			Input.ABCPress = false;
		}
		break;
		case CharKnuckles:
		{
			// Set collision radiuses
			RadiusX = 10;
			RadiusY = 10;
				
			// Set speeds
			Gsp = 0;
			Xsp = 4 * Facing;
			Ysp = Ysp <= 0 ? 0 : Ysp + 2;
				
			// Set flags
			AirLock        = false;
			Jumping        = false;
			Spinning       = false;
			GlideState     = GlideAir;
			GlideDirection = Facing;
			GlideValue     = Facing == FlipLeft ? 0 : 180;
				
			// Set animation
			Animation = AnimGlide;
		}
		break;
	}
}