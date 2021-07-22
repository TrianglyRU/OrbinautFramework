function PaletteShiftHandle()
{	
	// Exit if paused
	if instance_exists(Stage) and Stage.GamePaused
	{
		exit;
	}
	
	// Player palette
	if instance_exists(Player)
	{	
		// Sonic palette
		if Player.CharacterID == CharSonic
		{
			for (var i = 1; i <= 4; i++)
			{
				if !Player.SuperState
				{
					// Regular form
					if palette_get_colour(PaletteSurface, i) == 1
					{
						palette_handle(PaletteSurface,    i, 1, 1, 1);
						palette_handle(PaletteUnderwater, i, 1, 1, 1);
					}
					
					// Transforming from super into regular form
					else
					{
						if palette_get_colour(PaletteSurface, i) < 17
						{
							palette_handle(PaletteSurface,    i, 16, 17, 4);
							palette_handle(PaletteUnderwater, i, 16, 17, 4);
						}
						else
						{				
							palette_handle(PaletteSurface,    i, 21, 1, 8);
							palette_handle(PaletteUnderwater, i, 21, 1, 8);	
						}
					}
				}
				
				// Super form
				else
				{
					palette_handle(PaletteSurface,    i, 16, 7, 4);
					palette_handle(PaletteUnderwater, i, 16, 7, 4);
				}
			}
		}
		
		// Tails palette
		if Player.CharacterID == CharTails
		{
			for (var i = 5; i <= 8; i++)
			{
				if !Player.SuperState
				{
					// Regular form
					if palette_get_colour(PaletteSurface, i) == 1
					{
						palette_handle(PaletteSurface,    i, 1, 1, 1);
						palette_handle(PaletteUnderwater, i, 1, 1, 1);
					}
					
					// Transforming from super into regular form
					else
					{			
						palette_handle(PaletteSurface,    i, 6, 1, 10);
						palette_handle(PaletteUnderwater, i, 6, 1, 10);	
					}
				}
				
				// Super form
				else
				{
					palette_handle(PaletteSurface,    i, 6, 1, 10);
					palette_handle(PaletteUnderwater, i, 6, 1, 10);
				}
			}
		}
		
		// Knuckles palette
		if Player.CharacterID == CharKnuckles
		{
			for (var i = 9; i <= 11; i++)
			{
				if !Player.SuperState
				{
					// Regular form
					if palette_get_colour(PaletteSurface, i) == 1
					{
						palette_handle(PaletteSurface,    i, 1, 1, 1);
						palette_handle(PaletteUnderwater, i, 1, 1, 1);
					}
					
					// Transforming from super into regular form
					else
					{			
						palette_handle(PaletteSurface,    i, 15, 1, 3);
						palette_handle(PaletteUnderwater, i, 15, 1, 3);	
					}
				}
				
				// Super form
				else
				{
					palette_handle(PaletteSurface,    i, 15, 1, 3);
					palette_handle(PaletteUnderwater, i, 15, 1, 3);
				}
			}			
		}
	}
	
	// Stage palette shift
	switch room
	{
		case MQZ0:
		case MQZ1:
		case MQZ2:
		{
			/*// Surface dynamic
			for (var i = 11; i <= 18; i++)
			{
				palette_handle(PaletteSurface, i, 1, 8, 4);
			}
			palette_handle(PaletteSurface, 19, 1, 8, 6);
			
			// Underwater dynamic
			for (var i = 51; i <= 58; i++)
			{
				palette_handle(PaletteUnderwater, i, 1, 8, 4);
			}
			palette_handle(PaletteUnderwater, 59, 1, 8, 6);*/
		}
		break;
	}
}