function PlayerJump()
{
	// Exit if we're not jumping
	if !Jumping
	{
		exit;
	}
	
	if !Input.ABC
	{
		// Shorten our jump force
		if Ysp < JumpMin
		{
			Ysp = JumpMin;
		}
		
		// Reset dropdash
		if DropdashFlag
		{
			DropdashRev = -1;
			Animation   = AnimRoll;
		}
		DropdashFlag = 0;
	}
	
	// Check if C button is pressed and we're moving upwards
	if Input.CPress and Rings >= 50 and Ysp < 0 and Game.Emeralds == 7 and !SuperState and !Stage.IsFinished
	{
		// Play animation
		Animation = AnimTransform;
			
		// Transform
		SuperState      = true;
		SuperStateValue = false;
			
		// Disable controls
		NoControls = true;
			
		// Reset invincibility
		InvincibleBonus  = false;
		InvincibilityFrames = 0;
			
		// Use normal collision radiuses
		RadiusX = DefaultRadiusX;
		RadiusY = DefaultRadiusY;
			
		audio_sfx_play(sfxTransform, false);		
		audio_bgm_play(PriorityLow, SuperMusic, other);
			
		// Reset jump and roll flag
		Jumping		= false;
		Spinning	= false;
		RollJumping = false;
	}
	
	// Else perform double jump action
	else switch CharacterID
	{
		// Use barrier power as Sonic
		case CharSonic:
		{
			// Perform dropdash
			if BarrierType <= BarrierNormal or SuperState
			{
				if Game.DropdashEnabled and DropdashFlag == 0 and Input.ABC
				{
					RollJumping  = false;
					DropdashFlag = 1;
					Animation    = AnimDropdash;
					
					audio_sfx_play(sfxDropDash, false);
				}
				exit;
			}
			
			// Exit if in Super form or under invincibility bonus
			if InvincibleBonus or DropdashFlag or BarrierIsActive or !Input.ABCPress
			{
				exit;
			}
			
			// Activate ability
			BarrierIsActive = true;
			RollJumping     = false;
			
			// Get current barrier
			switch BarrierType
			{
				// Flame barrier
				case BarrierFlame:
				{
					// Set horizontal and vertical speeds
					Xsp = 8 * Facing;
					Ysp = 0;
				
					// Freeze the screen for 16 frames
					if !Game.CDCamera
					{
						Camera.ScrollDelay = 16;
					}
				
					// Play sound
					audio_sfx_play(sfxFlameBarrierDash, false);
				}
				break;
			
				// Thunder barrier
				case BarrierThunder:
				{
					// Set vertical speed
					Ysp = -5.5;
				
					// Play sound
					audio_sfx_play(sfxThunderBarrierSpark, false);
					
					// Create sparkles
					for (var i = 0; i < 4; i++)
					{
						var  Sparkle = instance_create(floor(PosX), floor(PosY), ThunderSparkle);
						with Sparkle
						{
							SparkleID = i;
						}
					}
				
					/* Ring magnetization is performed from its side */
				}
				break;
			
				// Water barrier
				case BarrierWater:
				{
					// Set horizontal and vertical speeds
					Xsp = Game.SMWaterBarrier ? Xsp / 2 : 0;
					Ysp = 8;
					
					// Set barrier animation
					with Barrier
					{
						animation_set_frame(spr_barrier_water_drop, 1);
					}
				}
				break;
			}
		}
		break;
		
		// Start Tails flight
		case CharTails:
		{
			// Use normal collision radiuses
			RadiusX = DefaultRadiusX;
			RadiusY = DefaultRadiusY;
				
			// Set gravity
			Grv = 0.03125;
				
			// Enter flight state
			FlightState = FlightActive;
			FlightValue = 480;
				
			// Reset jump and roll flag
			Jumping     = false;
			Spinning    = false;
			RollJumping = false;
				
			// Clear action inputs
			Input.ABC	   = false;
			Input.ABCPress = false;
		}
		break;
			
		// Start Knuckles glide
		case CharKnuckles:
		{
			// Set unique glide radiuses
			RadiusX = 10;
			RadiusY = 10;
				
			// Set speeds	
			Inertia = 0;
			Xsp     = 4 * Facing;	
			Ysp     = max(Ysp, 0);
				
			// Reset jump and roll flag
			Jumping     = false;
			Spinning    = false;
			RollJumping = false;
				
			// Set glide direction
			GlideDirection = Facing;
			
			// Enter glide state
			GlideValue    = Facing == FlipLeft ? 0 : 180;
			GlideState    = GlideActive;
			GlideGrounded = false;
		}
		break;
	}
}