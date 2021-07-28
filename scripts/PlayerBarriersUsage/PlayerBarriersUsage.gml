function PlayerBarriersUsage()
{
	// Exit the code if we play as Sonic
	if CharacterID != CharSonic
	{
		exit;
	}
	
	// Exit the code if we do not have a barrier, or it is not elemental
	if BarrierType <= BarrierNormal
	{
		exit;
	}
	
	// Exit the code if we are under the invincibility bonus or in super form
	if InvincibilityBonus or SuperState
	{
		exit;
	}
	
	// We’re in a jump, no barrier used and the action button pressed?
	if Jumping and !BarrierIsActive and Input.ABCPress
	{
		// Activate barrier ability
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
}