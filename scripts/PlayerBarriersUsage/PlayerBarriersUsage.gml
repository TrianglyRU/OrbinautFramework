function PlayerBarriersUsage()
{
	// Exit the code if we do not have any active barrier, or current barrier is regular one
	if !BarrierType or BarrierType == BarrierNormal or CharacterID != CharSonic or InvincibilityBonus
	{
		exit;
	}
	
	// Check for barrier ability usage
	if Jumping and Input.ABCPress and !BarrierIsActive
	{
		// Activate barrier ability
		BarrierIsActive = true;
		
		// Get current barrier type
		switch BarrierType
		{
			case BarrierFlame:
			{
				// Set speeds
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
			case BarrierThunder:
			{
				// Set speed
				Ysp = -5.5;
				
				// Play sound
				audio_sfx_play(sfxThunderBarrierSpark, false);
				
				/* Ring magnetization is performed from the ring side */
			}
			break;
			case BarrierWater:
			{
				// Set speeds
				Xsp = 0;
				Ysp = 8;
			}
			break;
		}
	}
	
	// Check for landing with water barrier
	if Grounded and BarrierType == BarrierWater and BarrierIsActive
	{
		BarrierIsActive = false;
		Grounded		= false;
		Jumping			= true;
		
		// Set vertical speed
		Ysp	= -7.5 * dcos(Angle);
		
		// Set horizontal speed to vertical speed on steep angles
		if Angle >= 45 and Angle <= 315
		{
			Xsp = Angle <= 180 ? Ysp : -Ysp;
		}
		
		// Set horizontal speed to halved vertical speed on shallow angles
		else if Angle >= 22.5 and Angle <= 337.5
		{
			Xsp = Angle <= 180 ? Ysp / 2 : -Ysp / 2;
		}
		
		// Reset horizontal speed if angle is almost flat
		else 
		{	
			Xsp = 0;	
		}	
		
		// Play sound
		audio_sfx_play(sfxWaterBarrierBounce, false);
	}
}