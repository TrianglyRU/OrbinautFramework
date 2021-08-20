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
				NoControls = true;
				
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
		Inertia    = (!SuperState ? 12 : 15) * Facing;
		NoControls = false;
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
	else
	{
		PeeloutRev = -1;
		NoControls = false;
	}
	
	// Apply peelout animation
	if PeeloutRev != -1
	{
		Animation = AnimPeelout;
	}
	return false;
}