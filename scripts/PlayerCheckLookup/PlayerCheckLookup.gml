function PlayerCheckLookup()
{	
	// Exit if we're moving
	if Inertia != 0 exit;
	
	// Exit if we're balancing
	if Balancing != false exit;
	
	// Check if we're holding UP button
	if Input.Up
	{
		// Set 'lookup' animation
		Animation = AnimLookup;
		
		// Check if we're Sonic and Super Peel Out is enabled
		if CharacterID == CharSonic and Game.PeeloutEnabled
		{
			// Start Super Peel Out on A button press
			if Input.APress and PeeloutRev == -1
			{
				PeeloutRev   = 0;
				MovementLock = -1;
				
				// Play sound
				audio_sfx_play(sfxPeeloutCharge, false, true);
			}
			
			// Charge Super Peel Out
			if PeeloutRev >= 0
			{
				// Set 'peelout' animation
				Animation = AnimPeelout;
				
				PeeloutRev++;
				if (PeeloutRev > 30) PeeloutRev = 30;
			}
		}
	}
			
	// Release Super Peel Out
	else if PeeloutRev >= 0
	{
		// If it is not fully charged, juts drop it
		if PeeloutRev < 30
		{
			PeeloutRev   = -1;
			MovementLock = false;
		}
		
		// Else release correctly
		else
		{	
			// Play sound
			audio_sfx_play(sfxPeeloutRelease, false, true);
				
			// Set 'peelout' animation
			Animation    = AnimPeelout;
			
			// Launch Sonic forwards
			Inertia		 = 12 * Facing;
			MovementLock = false;
			
			// Reset peelout charge value
			PeeloutRev = -1;
			
			// Freeze the screen for 16 frames
			if (Screen.ExtendedOffset == 0) Screen.ScrollDelay = 16;
		}
	}		
}