function PaletteDynamicShiftHandle()
{	
	// Check if player is in their super form
	if instance_exists(Player)
	{
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
	}
	
	switch room
	{
		case GVZ:
		case GVZ2:
		{
			for (var i = 10; i < 15; i++)
			{
				palette_handle(i, 4, 8);
			}
		}
	}
}