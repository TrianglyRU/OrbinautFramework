function PaletteDynamicShiftHandle()
{	
	// Check if player is in their super form
	if Player.isSuper
	{
		switch Player.CharacterID
		{
			// Perform Super Sonic palette shift
			case CharSonic:
			{
				for (var i = 0; i < 4; i++) 
				{
					palette_handle(i, 9, 4);
				}
			}
			break;
			
			// Perform Super Tails palette shift
			case CharTails:
			{
				for (var i = 4; i < 7; i++) 
				{
					palette_handle(i, 3, 4);
				}
			}
			break;
			
			// Perform Super Knuckles palette shift
			case CharKnuckles:
			{
				for (var i = 7; i < 10; i++) 
				{
					palette_handle(i, 10, 4);
				}
			}
			break;
		}
	}	
	
	// Check current room/scene
	switch room
	{
		// Perform palette shift for Moonlight Base
		case MBZ:
		{
			palette_handle(10, 6, 8);
		}
	}
}