function PlayerPeelout()
{
	// Exit if peelout is disabled or we're not Sonic
	if !Game.PeeloutEnabled or Game.Character != CharSonic
	{
		exit;
	}
	
	// Process peelout
	if Input.Up
	{
		// Start it
		if PeeloutRev == -1
		{
			if Animation == AnimLookup and Input.ABCPress
			{
				// Set our target peelout force
				if !IsUnderwater
				{
					PeeloutForce = !HighspeedBonus ? 12 : 9;
					if SuperState
					{
						PeeloutForce += 2;
					}
				}
				else
				{
					PeeloutForce = 6;
				}
				PeeloutRev = 0;
				
				// Play sound
				audio_sfx_play(sfxPeeloutCharge, false);
			}
		}
		
		// Charge it
		else 
		{
			if PeeloutRev < PeeloutForce
			{
				PeeloutRev = min(PeeloutRev + 0.390625, PeeloutForce);
			}
		}
	}
	
	// Release peelout
	else if PeeloutRev == PeeloutForce
	{	
		// Launch player
		Inertia      = PeeloutForce * Facing;
		PeeloutRev   = -1;
		PeeloutForce = 0;
		Animation    = AnimMove;
			
		// Freeze the screen for 16 frames
		if !Game.CDCamera
		{
			Camera.ScrollDelay = 16;
		}
			
		// Play sound
		audio_sfx_play(sfxPeeloutRelease, false);
		
		// Return success action
		return true;
	}
	
	// Cancel peelout
	else
	{	
		PeeloutRev   = -1;
		PeeloutForce = 0;
		
		// Stop sound
		audio_sfx_stop(sfxPeeloutCharge);
	}
	
	// Apply peelout animation
	if PeeloutRev != -1
	{
		Animation = AnimPeelout;
	}
	return false;
}