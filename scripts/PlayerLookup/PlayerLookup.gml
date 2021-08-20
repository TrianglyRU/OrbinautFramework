function PlayerLookup()
{	
	// Exit
	if Inertia != 0 or Pushing
	{
		exit;
	}
	
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
				PeeloutRev = 0;
				NoControls = true;
				
				// Play sound
				audio_sfx_play(sfxPeeloutCharge, false);
			}
			
			// Charge Super Peel Out
			if PeeloutRev >= 0
			{	
				PeeloutRev++;
				
				// Set 'peelout' animation
				Animation = AnimPeelout;
				
				if PeeloutRev > 30
				{
					PeeloutRev = 30;
				}
			}
		}
	}
			
	// Release Super Peel Out
	else if PeeloutRev >= 0
	{
		if PeeloutRev < 30
		{
			PeeloutRev = -1;
			NoControls = false;
		}
		else
		{	
			// Play sound
			audio_sfx_play(sfxPeeloutRelease, false);
				
			// Set 'move' animation
			Animation = AnimMove;
			
			// Launch Sonic forwards
			Inertia = (!SuperState ? 12 : 15) * Facing;
			
			// Freeze the screen for 16 frames
			if !Game.CDCamera
			{
				Camera.ScrollDelay = 16;
			}
			
			PeeloutRev = -1;
			NoControls = false;
			
			return true;
		}		
	}
	return false;
}