function PlayerPeelout()
{
	if !Game.PeeloutEnabled or Game.Character != CharSonic
	{
		return;
	}
	
	// Process peelout
	if Input.Up
	{
		if PeeloutRev == -1
		{
			if Animation == AnimLookup and Input.ABCPress
			{
				if !IsUnderwater
				{
					// Set our target peelout force
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
				
				audio_sfx_play(sfxPeeloutCharge, false);
			}
		}
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
		if !Game.CDCamera
		{
			Camera.ScrollDelay = 16;
		}
		
		Inertia      =  PeeloutForce * Facing;
		PeeloutRev   = -1;
		PeeloutForce =  0;
		Animation    =  AnimMove;
		
		audio_sfx_play(sfxPeeloutRelease, false);
		
		return true;
	}
	
	// Cancel peelout
	else
	{	
		PeeloutRev   = -1;
		PeeloutForce = 0;
		
		audio_sfx_stop(sfxPeeloutCharge);
	}
	
	// Apply peelout animation
	if PeeloutRev != -1
	{
		Animation = AnimPeelout;
	}
	
	return false;
}