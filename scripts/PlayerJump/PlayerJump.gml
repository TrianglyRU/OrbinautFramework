function PlayerJump()
{
	// Exit if we're not jumping
	if !Jumping
	{
		exit;
	}
	
	// If action button is not held, shorten jump force and reset dropdash
	if !Input.ABC
	{
		if Ysp < JumpMin
		{
			Ysp = JumpMin;
		}
		if DropdashFlag
		{
			DropdashRev = -1;
			Animation   = AnimRoll;
		}
		DropdashFlag = 0;
	}
	
	// Transform into super form with C button
	if Input.CPress and (Rings >= 50 and Game.Emeralds == 7 and !SuperState and !Stage.IsFinished)
	{	
		// Set animation
		Animation = AnimTransform;
		
		// Set flags
		InvincibilityFrames = 0;
		Jumping		    = false;
		Spinning	    = false;
		RollJumping     = false;
		InvincibleBonus = false;
		SuperStateValue = false;
		SuperState      = true;
		NoControls		= true;
			
		// Reset collision radiuses
		RadiusX = DefaultRadiusX;
		RadiusY = DefaultRadiusY;
		
		// Play sound and music
		audio_sfx_play(sfxTransform, false);		
		audio_bgm_play(PriorityLow, SuperMusic, other);
	}
	
	// Perform character action
	else switch Game.Character
	{
		// Sonic
		case CharSonic:
		{
			// Perform dropdash
			if BarrierType <= BarrierNormal or SuperState
			{
				if Input.ABC and (Game.DropdashEnabled and DropdashFlag == 0)
				{
					RollJumping  = false;
					DropdashFlag = 1;
					Animation    = AnimDropdash;
					
					audio_sfx_play(sfxDropDash, false);
				}
			}
			else
			{
				// Perform barrier action
				if Input.ABCPress and !(InvincibleBonus or DropdashFlag or BarrierIsActive)
				{			
					BarrierIsActive = true;
					RollJumping     = false;
				
					// Get current barrier
					switch BarrierType
					{
						case BarrierFlame:
						{
							// Freeze the screen for 16 frames
							if !Game.CDCamera
							{
								Camera.ScrollDelay = 16;
							}
						
							// Set speeds
							Xsp = 8 * Facing;
							Ysp = 0;
						
							// Play sound
							audio_sfx_play(sfxFlameBarrierDash, false);
						}
						break;
						case BarrierThunder:
						{
							// Create sparkles
							for (var i = 0; i < 4; i++)
							{
								var  Sparkle = instance_create(floor(PosX), floor(PosY), ThunderSparkle);
								with Sparkle
								{
									SparkleID = i;
								}
							}
						
							// Set vertical speed
							Ysp = -5.5;
						
							// Play sound
							audio_sfx_play(sfxThunderBarrierSpark, false);
						}
						break;
						case BarrierWater:
						{						
							// Set barrier animation
							with Barrier
							{
								animation_set(spr_barrier_water_drop, 1);
							}
						
							// Set speeds
							Xsp = Game.SMWaterBarrier ? Xsp / 2 : 0;
							Ysp = 8;
						}
						break;
					}
				}
			}
		}
		break;
		
		// Start Tails flight
		case CharTails:
		{
			if Input.ABCPress
			{
				// Reset collision radiuses
				RadiusX = DefaultRadiusX;
				RadiusY = DefaultRadiusY;
				
				// Set flags
				Jumping     = false;
				Spinning    = false;
				RollJumping = false;
				Grv			= 0.03125;
				FlightValue = 480;
				FlightState = FlightActive;
				
				// Play sound
				if !IsUnderwater
				{
					audio_sfx_play(sfxFlying, true);
				}
				
				// Clear action buttons
				Input.ABC      = false;
				Input.ABCPress = false;
			}
		}
		break;
			
		// Start Knuckles glide
		case CharKnuckles:
		{
			if Input.ABCPress
			{
				// Set collision radiuses
				RadiusX = 10;
				RadiusY = 10;
				
				// Set speeds
				Inertia = 0;
				Xsp     = 4 * Facing;	
				Ysp     = max(Ysp, 0);
				
				// Set flags
				Jumping        = false;
				Spinning       = false;
				RollJumping    = false;
				GlideGrounded  = false;
				GlideDirection = Facing;
				GlideValue     = Facing == FlipLeft ? 0 : 180;
				GlideState     = GlideActive;
			}
		}
		break;
	}
}