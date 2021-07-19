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
	
	// Did we land with an activated water barrier?
	if Grounded and BarrierIsActive and BarrierType == BarrierWater 
	{
		// Set flags
		BarrierIsActive = false;
		Grounded		= false;
		Jumping			= true;
		
		// Set vertical speed
		Ysp	= -7.5 * dcos(Angle);
		
		// Set horizontal speed to vertical speed if floor is full steep
		if Angle >= 45 and Angle <= 315
		{
			Xsp = Angle <= 180 ? Ysp : -Ysp;
		}
		
		// Set horizontal speed to halved vertical speed if floor is half steep
		else if Angle >= 22.5 and Angle <= 337.5
		{
			Xsp = Angle <= 180 ? Ysp / 2 : -Ysp / 2;
		}
		
		// Reset horizontal speed if floor is shallow
		else 
		{	
			Xsp = 0;	
		}	
		
		// Play sound
		audio_sfx_play(sfxWaterBarrierBounce, false);
	}
}