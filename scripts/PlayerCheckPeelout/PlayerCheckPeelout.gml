function PlayerCheckPeelout()
{	
	if Input.Up and Inertia = 0
	{
		Animation = AnimLookup;
		
		if CharacterID = CharSonic and Game.PeeloutEnabled
		{
			// Start peelout
			if Input.APress
			{
				PeeloutRev = 0;
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
	else
	{
		if PeeloutRev < 30
		{
			PeeloutRev = -2;
		}
		else
		{
			Screen.ScrollDelay = 12;
			Inertia			   = 12 * Facing;
			PeeloutRev		   = -2;
		}
	}		
}