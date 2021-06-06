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
				audio_sfx_play(sfxFlameBarrierDash, false, true);
			}
			break;
			case BarrierThunder:
			{
				// Set speed
				Ysp = -5.5;
				
				// Play sound
				audio_sfx_play(sfxThunderBarrierSpark, false, true);
				
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
		Ysp				= -7.5;
		
		// Play sound
		audio_sfx_play(sfxWaterBarrierBounce, false, true);
	}
}