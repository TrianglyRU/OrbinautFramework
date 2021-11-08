function PlayerJump()
{
	// If not jumping, exit
	if !Jumping
	{
		exit;
	}
	
	// If action button is not held, shorten jump force
	if !Input.ABC
	{
		if Ysp < JumpMin
		{
			Ysp = JumpMin;
		}
		
		// Reset dropdash
		if DropdashFlag == -1
		{
			DropdashFlag = 0;
		}
		else if DropdashFlag == 1
		{
			if DropdashRev == 20
			{
				Animation    = AnimSpin;
				DropdashFlag = 2;
			}
			DropdashRev  = -1;
		}
	}
	
	// Do not perform any actions if moving too fast or no input press has been registered
	if Ysp < JumpMin or !Input.ABCPress
	{
		exit;
	}
	
	// Transform into super form
	if Game.Emeralds == 7 and !SuperState and Rings >= 50 and !Stage.IsFinished
	{
		// Make sure we don't have elemental barrier if we're Sonic
		if Game.Character == CharSonic and BarrierType <= BarrierNormal
		or Game.Character != CharSonic
		{
			// Set animation
			Animation = AnimTransform;
		
			// Set flags
			InvincibilityFrames = 0;
			Jumping		    = false;
			Spinning	    = false;
			InvincibleBonus = false;
			SuperStateValue = false;
			SuperState      = true;
			AirLock			= true;
			
			// Reset collision radiuses
			RadiusX = DefaultRadiusX;
			RadiusY = DefaultRadiusY;
		
			// Play sound and music
			audio_sfx_play(sfxTransform, false);		
			audio_bgm_play(PriorityLow, SuperTheme);
				
			// Exit the code
			exit;
		}
	}

	// Perform character action
	switch Game.Character
	{
		// Sonic
		case CharSonic:
		{		
			if BarrierType <= BarrierNormal or SuperState
			{
				// Perform dropdash if enabled
				if Game.DropdashEnabled and DropdashFlag == 0
				{
					AirLock      = false;
					DropdashFlag = 1;
				}
			}
			else
			{
				// Perform barrier action
				if !(InvincibleBonus or DropdashFlag or BarrierIsActive)
				{			
					switch BarrierType
					{
						case BarrierFlame:
						{
							// Freeze the screen for 16 frames
							if !Game.CDCamera
							{
								Camera.ScrollDelay = 16;
							}
							
							// Set barrier animation
							with Barrier
							{
								animation_play(spr_obj_barrier_flame_dash, 2, 0, 0);
							}
						
							// Set speeds
							Xsp = 8 * Facing;
							Ysp = 0;
							
							// Lock control
							AirLock = true;
						
							// Play sound
							audio_sfx_play(sfxFlameBarrierDash, false);
						}
						break;
						case BarrierThunder:
						{
							// Create sparkles
							for (var i = 0; i < 4; i++)
							{
								var  Object = instance_create(PosX, PosY, BarrierSparkle);
								with Object
								{
									SparkleID = i;
								}
							}
							
							// Restore control
							AirLock = false;
						
							// Set vertical speed
							Ysp = -5.5;
						
							// Play sound
							audio_sfx_play(sfxThunderBarrierJump, false);
						}
						break;
						case BarrierWater:
						{						
							// Set barrier animation
							with Barrier
							{
								animation_play(spr_obj_barrier_water_drop, [6, 19, 0], 0, 0);
							}
							
							// Restore control
							AirLock = false;
						
							// Set speeds
							Xsp = 0;
							Ysp = 8;
							
							// Play sound
							audio_sfx_play(sfxWaterBarrierBounce, false);
						}
						break;
					}
					
					// Set flag
					BarrierIsActive = true;
				}
			}
		}
		break;
		
		// Start Tails flight
		case CharTails:
		{
			// Reset collision radiuses
			RadiusX = DefaultRadiusX;
			RadiusY = DefaultRadiusY;
				
			// Set flags
			AirLock     = false;
			Jumping     = false;
			Spinning    = false;
			Grv			= 0.03125;
			FlightValue = 480;
			FlightState = true;
				
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
			
		// Start Knuckles glide
		case CharKnuckles:
		{
			// Set collision radiuses
			RadiusX = 10;
			RadiusY = 10;
				
			// Set speeds
			Inertia = 0;
			Xsp     = 4 * Facing;
			Ysp     = Ysp <= 0 ? 0 : Ysp + 2;
				
			// Set flags
			AirLock        = false;
			Jumping        = false;
			Spinning       = false;
			GlideGrounded  = false;
			GlideDirection = Facing;
			GlideValue     = Facing == FlipLeft ? 0 : 180;
			GlideState     = GlideAir;
				
			// Set animation
			Animation = AnimGlide;
		}
		break;
	}
}