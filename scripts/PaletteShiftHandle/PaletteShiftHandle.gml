function PaletteShiftHandle()
{	
	// Exit if paused
	if instance_exists(Stage) and Stage.State == StagePaused
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
				// Get current colour and duration
				var Colour = palette_get_colour(PaletteSurface, i);
				
				// Is Sonic in his regular form?
				if !Player.SuperState
				{
					// If not transforming, use first colour
					if Colour == 1
					{
						palette_handle(PaletteSurface,    i, 1, 1, 1);
						palette_handle(PaletteUnderwater, i, 1, 1, 1);
					}
					
					// If transforming from Super
					else
					{
						if Colour < 17
						{
							palette_set_colour(PaletteSurface,    i, 17);
							palette_set_colour(PaletteUnderwater, i, 17);
						}	
						palette_handle(PaletteSurface,    i, 21, 1, 4);
						palette_handle(PaletteUnderwater, i, 21, 1, 4);	
					}
				}
				
				// Transforming into Super
				else if Player.SuperState == 1
				{
					if Colour == 1
					{
						palette_handle(PaletteSurface,    i, 2, 2, 19);
						palette_handle(PaletteUnderwater, i, 2, 2, 19);
					}
					if Colour > 1
					{
						palette_handle(PaletteSurface,    i, 6, 6, 4);
						palette_handle(PaletteUnderwater, i, 6, 6, 4);
					}
				}
				
				// In Super Form
				else
				{
					if Colour < 7
					{
						palette_set_colour(PaletteSurface,    i, 7);
						palette_set_colour(PaletteUnderwater, i, 7);
					}
					palette_handle(PaletteSurface,    i, 16, 7, 8);
					palette_handle(PaletteUnderwater, i, 16, 7, 8);
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