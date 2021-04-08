function PlayerCheckPeelout()
{	
	if Input.Up and Inertia == 0
	{
		Animation = AnimLookup;
		
		if CharacterID == CharSonic and Game.PeeloutEnabled
		{
			// Start peelout
			if Input.APress and PeeloutRev == -2
			{
				PeeloutRev   = 0;
				MovementLock = -1;
			}
			
			// Charge peelout
			if PeeloutRev >= 0
			{
				PeeloutRev++;
				if (PeeloutRev > 30) PeeloutRev = 30;
				Animation = AnimPeelout;
			}
		}
	}
			
	// Release peelout
	else if PeeloutRev >= 0
	{
		if PeeloutRev < 30
		{
			PeeloutRev   = -2;
			MovementLock = false;
		}
		else
		{	
			Animation    = AnimPeelout;
			Inertia		 = 12 * Facing;
			PeeloutRev	 = -2;
			MovementLock = false;
			
			if (Screen.ExtendedOffset == 0) Screen.ScrollDelay = 16;
		}
	}		
}