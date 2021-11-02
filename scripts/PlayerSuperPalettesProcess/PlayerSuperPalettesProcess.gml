function PlayerSuperPalettesProcess()
{
	// Sonic palette
	if Game.Character == CharSonic
	{
		// Get current colour
		var Colour = palette_get_colour(PaletteType1, 0);
				
		// Regular form
		if !Player.SuperState
		{
			if Colour == 1
			{
				palette_set_colour(PaletteType1, 0, 4, 1);
				palette_set_colour(PaletteType2, 0, 4, 1);
			}
			else
			{
				if Colour < 17
				{
					palette_set_colour(PaletteType1, 0, 4, 17);
					palette_set_colour(PaletteType2, 0, 4, 17);
				}	
				palette_handle(PaletteType1, 0, 4, 21, 1, 4);
				palette_handle(PaletteType2, 0, 4, 21, 1, 4);	
			}
		}
				
		// Transforming into Super form
		else if Player.SuperState == 1
		{
			if Colour == 1
			{
				palette_handle(PaletteType1, 0, 4, 2, 2, 19);
				palette_handle(PaletteType2, 0, 4, 2, 2, 19);
			}
			if Colour > 1
			{
				palette_handle(PaletteType1, 0, 4, 6, 6, 4);
				palette_handle(PaletteType2, 0, 4, 6, 6, 4);
			}
		}
					
		// Super form
		else if Player.SuperState == 2
		{
			if Colour < 7
			{
				palette_set_colour(PaletteType1, 0, 4, 7);
				palette_set_colour(PaletteType2, 0, 4, 7);
			}
			palette_handle(PaletteType1, 0, 4, 16, 7, 8);
			palette_handle(PaletteType2, 0, 4, 16, 7, 8);
		}
	}
		
	// Tails palette
	else if Game.Character == CharTails
	{
		// Get current colour
		var Colour = palette_get_colour(PaletteType1, 4);
				
		// Regular form
		if !Player.SuperState
		{	
			if Colour == 1
			{
				palette_set_colour(PaletteType1, 4, 4, 1);
				palette_set_colour(PaletteType2, 4, 4, 1);
			}
			else
			{			
				palette_handle(PaletteType1, 4, 4, 6, 1, 12);
				palette_handle(PaletteType2, 4, 4, 6, 1, 12);
			}
		}
				
		// Super form
		else
		{
			if Colour == 1
			{
				palette_handle(PaletteType1, 4, 4, 1, 2, 28);
				palette_handle(PaletteType2, 4, 4, 1, 2, 28);
			}
			if Colour > 1
			{
				palette_handle(PaletteType1, 4, 4, 7, 2, 12);
				palette_handle(PaletteType2, 4, 4, 7, 2, 12);
			}
		}
	}
		
	// Knuckles palette
	else if Game.Character == CharKnuckles
	{
		// Get current colour
		var Colour = palette_get_colour(PaletteType1, 8);
				
		// Regular form
		if !Player.SuperState
		{
			if Colour == 1
			{
				palette_set_colour(PaletteType1, 8, 3, 1);
				palette_set_colour(PaletteType2, 8, 3, 1);
			}
			else
			{			
				palette_handle(PaletteType1, 8, 3, 11, 1, 3);
				palette_handle(PaletteType2, 8, 3, 11, 1, 3);	
			}
		}
			
		// Super form
		else
		{
			if Colour == 1
			{
				palette_handle(PaletteType1, 8, 3, 1, 3, 17);
				palette_handle(PaletteType2, 8, 3, 1, 3, 17);
			}
			if Colour == 2
			{
				palette_handle(PaletteType1, 8, 3, 2, 3, 15);
				palette_handle(PaletteType2, 8, 3, 2, 3, 15);
			}
			if Colour > 2
			{
				palette_handle(PaletteType1, 8, 3, 11, 2, 3);
				palette_handle(PaletteType2, 8, 3, 11, 2, 3);
			}
		}		
	}
}