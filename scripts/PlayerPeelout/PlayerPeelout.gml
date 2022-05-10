function PlayerPeelout()
{
	if !global.PeeloutEnabled or global.Character != CharSonic
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
		if !global.CDCamera
		{
			Camera.ScrollDelay = 16;
		}
		
		Gsp      =  PeeloutForce * Facing;
		PeeloutRev   = -1;
		PeeloutForce =  0;
		Animation    =  AnimMove;
		
		audio_sfx_play(sfxPeeloutRelease, false);
		
		// Same story as with the spindash, so...
		if global.FixDashRelease
		{
			Xsp = Gsp *  dcos(Angle);
			Ysp = Gsp * -dsin(Angle);
		}
		
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