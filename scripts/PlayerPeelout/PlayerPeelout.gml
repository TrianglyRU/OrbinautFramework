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
				PeeloutRev = 0;
				AirLock = true;
				
				// Play sound
				audio_sfx_play(sfxPeeloutCharge, false);
			}
		}
		
		// Charge it
		else if PeeloutRev < 30
		{
			PeeloutRev++;
		}
	}
	
	// Release peelout
	else if PeeloutRev == 30
	{	
		// Launch player
		var Force = !HighspeedBonus ? TopAcc * 2 : TopAcc * 1.5;
		if SuperState and Force > 16	
		{
			Force = 16;
		}
		
		Inertia    = Force * Facing;
		AirLock    = false;
		PeeloutRev = -1;
		Animation  = AnimMove;
			
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
	else if PeeloutRev
	{	
		PeeloutRev = -1;
		AirLock    = false;
		
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