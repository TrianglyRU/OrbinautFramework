function PaletteShiftProcess()
{	
	// Exit if fade is active
	if fade_check(FadeActive)
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
				// Get current colour
				var Colour = palette_get_colour(PaletteSurface, i);
				
				// Regular form
				if !Player.SuperState
				{
					if Colour == 1
					{
						palette_handle(PaletteSurface,    i, 1, 1, 1);
						palette_handle(PaletteUnderwater, i, 1, 1, 1);
					}
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
				
				// Transforming into Super form
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
					
				// Super form
				else if Player.SuperState == 2
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
				// Get current colour
				var Colour = palette_get_colour(PaletteSurface, i);
				
				// Regular form
				if !Player.SuperState
				{	
					if Colour == 1
					{
						palette_handle(PaletteSurface,    i, 1, 1, 1);
						palette_handle(PaletteUnderwater, i, 1, 1, 1);
					}
					else
					{			
						palette_handle(PaletteSurface,    i, 6, 1, 12);
						palette_handle(PaletteUnderwater, i, 6, 1, 12);
					}
				}
				
				// Super form
				else
				{
					if Colour == 1
					{
						palette_handle(PaletteSurface,    i, 1, 2, 28);
						palette_handle(PaletteUnderwater, i, 1, 2, 28);
					}
					if Colour > 1
					{
						palette_handle(PaletteSurface,    i, 7, 2, 12);
						palette_handle(PaletteUnderwater, i, 7, 2, 12);
					}
				}
			}
		}
		
		// Knuckles palette
		if Player.CharacterID == CharKnuckles
		{
			for (var i = 9; i <= 11; i++)
			{
				// Get current colour
				var Colour = palette_get_colour(PaletteSurface, i);
				
				// Regular form
				if !Player.SuperState
				{
					if Colour == 1
					{
						palette_handle(PaletteSurface,    i, 1, 1, 1);
						palette_handle(PaletteUnderwater, i, 1, 1, 1);
					}
					else
					{			
						palette_handle(PaletteSurface,    i, 11, 1, 3);
						palette_handle(PaletteUnderwater, i, 11, 1, 3);	
					}
				}
			
				// Super form
				else
				{
					if Colour == 1
					{
						palette_handle(PaletteSurface,    i, 1, 3, 17);
						palette_handle(PaletteUnderwater, i, 1, 3, 17);
					}
					if Colour == 2
					{
						palette_handle(PaletteSurface,    i, 2, 3, 15);
						palette_handle(PaletteUnderwater, i, 2, 3, 15);
					}
					if Colour > 2
					{
						palette_handle(PaletteSurface,    i, 11, 2, 3);
						palette_handle(PaletteUnderwater, i, 11, 2, 3);
					}
				}
			}			
		}
	}
	
	// Basic shift
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
		default: break;
	}
}