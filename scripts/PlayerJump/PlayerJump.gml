function PlayerJump()
{
	// Exit if we're not jumping
	if !Jumping
	{
		exit;
	}
	
	// Shorten our jump force
	if !Input.ABC
	{
		if Ysp < JumpMin
		{
			Ysp = JumpMin;
		}
	}	
	
	// Exit the further code if action button wasn't pressed
	if !Input.ABCPress
	{
		exit;
	}
	
	// Clear the rolljump flag
	RollJumping = false;
	
	// Check if C button is pressed and we're moving upwards
	if Input.CPress and Rings >= 10 and Ysp < 0 and !SuperState
	{
		// Play animation
		Animation = AnimTransform;
			
		// Transform
		SuperState      = true;
		SuperStateValue = false;
			
		// Disable controls
		NoControls = true;
			
		// Reset invincibility
		InvincibilityBonus  = false;
		InvincibilityFrames = 0;
			
		// Use normal collision radiuses
		RadiusX = DefaultRadiusX;
		RadiusY = DefaultRadiusY;
			
		audio_sfx_play(sfxTransform, false);		
		audio_bgm_play(PriorityLow, SuperMusic, other);
			
		// Reset jump and roll flag
		Jumping  = false;
		Spinning = false;
	}
	
	// Else perform double jump action
	else switch CharacterID
	{
		// Use barrier power as Sonic
		case CharSonic:
		{
			// Exit if in Super form or under invincibility bonus
			if SuperState or InvincibilityBonus
			{
				exit;
			}
			
			// Exit if barrier is active or having no/regular barrier
			if BarrierIsActive or BarrierType <= BarrierNormal
			{
				exit;
			}
			
			// Activate ability
			BarrierIsActive = true;
			
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
					if Screen.ExtendedOffset == 0 
					{
						Screen.ScrollDelay = 16;
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
				
					/* Ring magnetization is performed from its side */
				}
				break;
			
				// Water barrier
				case BarrierWater:
				{
					// Set horizontal and vertical speeds
					Xsp = Game.BuffedWaterBarrier ? Xsp / 2 : 0;
					Ysp = 8;
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
			Jumping  = false;
			Spinning = false;
				
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
			Jumping  = false;
			Spinning = false;
				
			// Set glide direction
			if Facing == DirectionRight
			{
				GlideDirection = DirectionRight;
				GlideValue	   = 180;
			}
			else if Facing == DirectionLeft
			{
				GlideDirection = DirectionLeft;
				GlideValue	   = 0;
			}
				
			// Enter glide state
			GlideState    = GlideActive;
			GlideGrounded = false;
		}
		break;
	}
}