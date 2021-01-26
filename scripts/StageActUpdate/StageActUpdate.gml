function StageActUpdate()
{	
	// Proceed time counter
	if (TimeEnabled) Time++;
	
	// Perform super palette cycle
	if Player.isSuper
	{
		if Player.CharacterID = 0 
		{
			for (var i = 0; i < 4; i++) 
			{
				palette_cycle_perform(i, 9, 4);
				palette_cycle_perform(i, 9, 4);
				palette_cycle_perform(i, 9, 4);
				palette_cycle_perform(i, 9, 4);
			}
		}
		if Player.CharacterID = 1 
		{
			for (var i = 0; i < 4; i++) 
			{
				palette_cycle_perform(i, 9, 4);
				palette_cycle_perform(i, 9, 4);
				palette_cycle_perform(i, 9, 4);
				palette_cycle_perform(i, 9, 4);
			}
		}
	}	
	
	// Perform stage palette cycle
	switch room
	{
		case MBZ:
		break;
	}
}