function PaletteShiftProcess()
{	
	// Exit if fade is active or stage is paused
	if fade_check(FadeActive) or variable_check(Stage, "IsPaused")
	{
		exit;
	}
	
	// Player palette
	if instance_exists(Player)
	{	
		// Sonic palette
		if Game.Character == CharSonic
		{
			// Get current colour
			var Colour = palette_get_colour(PaletteDry, 1);
				
			// Regular form
			if !Player.SuperState
			{
				if Colour == 1
				{
					palette_set_colour(PaletteDry, 1, 4, 1);
					palette_set_colour(PaletteWet, 1, 4, 1);
				}
				else
				{
					if Colour < 17
					{
						palette_set_colour(PaletteDry, 1, 4, 17);
						palette_set_colour(PaletteWet, 1, 4, 17);
					}	
					palette_handle(PaletteDry, 1, 4, 21, 1, 4);
					palette_handle(PaletteWet, 1, 4, 21, 1, 4);	
				}
			}
				
			// Transforming into Super form
			else if Player.SuperState == 1
			{
				if Colour == 1
				{
					palette_handle(PaletteDry, 1, 4, 2, 2, 19);
					palette_handle(PaletteWet, 1, 4, 2, 2, 19);
				}
				if Colour > 1
				{
					palette_handle(PaletteDry, 1, 4, 6, 6, 4);
					palette_handle(PaletteWet, 1, 4, 6, 6, 4);
				}
			}
					
			// Super form
			else if Player.SuperState == 2
			{
				if Colour < 7
				{
					palette_set_colour(PaletteDry, 1, 4, 7);
					palette_set_colour(PaletteWet, 1, 4, 7);
				}
				palette_handle(PaletteDry, 1, 4, 16, 7, 8);
				palette_handle(PaletteWet, 1, 4, 16, 7, 8);
			}
		}
		
		// Tails palette
		else if Game.Character == CharTails
		{
			// Get current colour
			var Colour = palette_get_colour(PaletteDry, 5);
				
			// Regular form
			if !Player.SuperState
			{	
				if Colour == 1
				{
					palette_set_colour(PaletteDry, 5, 4, 1);
					palette_set_colour(PaletteWet, 5, 4, 1);
				}
				else
				{			
					palette_handle(PaletteDry, 5, 4, 6, 1, 12);
					palette_handle(PaletteWet, 5, 4, 6, 1, 12);
				}
			}
				
			// Super form
			else
			{
				if Colour == 1
				{
					palette_handle(PaletteDry, 5, 4, 1, 2, 28);
					palette_handle(PaletteWet, 5, 4, 1, 2, 28);
				}
				if Colour > 1
				{
					palette_handle(PaletteDry, 5, 4, 7, 2, 12);
					palette_handle(PaletteWet, 5, 4, 7, 2, 12);
				}
			}
		}
		
		// Knuckles palette
		else if Game.Character == CharKnuckles
		{
			// Get current colour
			var Colour = palette_get_colour(PaletteDry, 9);
				
			// Regular form
			if !Player.SuperState
			{
				if Colour == 1
				{
					palette_set_colour(PaletteDry, 9, 3, 1);
					palette_set_colour(PaletteWet, 9, 3, 1);
				}
				else
				{			
					palette_handle(PaletteDry, 9, 3, 11, 1, 3);
					palette_handle(PaletteWet, 9, 3, 11, 1, 3);	
				}
			}
			
			// Super form
			else
			{
				if Colour == 1
				{
					palette_handle(PaletteDry, 9, 3, 1, 3, 17);
					palette_handle(PaletteWet, 9, 3, 1, 3, 17);
				}
				if Colour == 2
				{
					palette_handle(PaletteDry, 9, 3, 2, 3, 15);
					palette_handle(PaletteWet, 9, 3, 2, 3, 15);
				}
				if Colour > 2
				{
					palette_handle(PaletteDry, 9, 3, 11, 2, 3);
					palette_handle(PaletteWet, 9, 3, 11, 2, 3);
				}
			}		
		}
	}
	
	// Room colours shift
	switch room
	{
		case MQZ0:
		{
			// Surface
			palette_handle(PaletteDry, 12, 8, 8, 1, 4);
			palette_handle(PaletteDry, 20, 1, 8, 1, 6);
			
			// Underwater
			palette_handle(PaletteWet, 47, 8, 8, 1, 4);
			palette_handle(PaletteWet, 55, 1, 8, 1, 6);
		}
		break;
		default: break;
	}
}