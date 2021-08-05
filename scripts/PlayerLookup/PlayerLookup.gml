function PlayerLookup()
{	
	// Exit
	if Inertia != 0 or Pushing != false or Balancing
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
				switch PeeloutRev div 15
				{
					case 0: Animation = AnimWalk	break;
					case 1: Animation = AnimRun		break;
					case 2: Animation = AnimPeelout break;
				}
				
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
				
			// Set 'peelout' animation
			Animation = AnimPeelout;
			
			// Launch Sonic forwards
			Inertia = (!SuperState ? 12 : 15) * Facing;
			
			// Freeze the screen for 16 frames
			if Screen.ExtendedOffset == 0
			{
				Screen.ScrollDelay = 16;
			}
			
			PeeloutRev = -1;
			NoControls = false;
			
			return true;
		}		
	}
	return false;
}