function PlayerSuperPalettesProcess()
{
	switch Game.Character
	{
		// Sonic palette
		case CharSonic:
		{
			// Get current colour
			var Colour = palette_get_colour(PalPrimary, 0);
				
			// Regular form
			if !Player.SuperState
			{
				if Colour == 1
				{
					palette_set_colour_range(PalPrimary,   0, 3, 1);
					palette_set_colour_range(PalSecondary, 0, 3, 1);
				}
				else
				{
					if Colour < 17
					{
						palette_set_colour_range(PalPrimary,   0, 3, 17);
						palette_set_colour_range(PalSecondary, 0, 3, 17);
					}	
					palette_handle_range(PalPrimary,   0, 3, 21, 1, 4);
					palette_handle_range(PalSecondary, 0, 3, 21, 1, 4);	
				}
			}
				
			// Transforming into Super form
			else if Player.SuperState == 1
			{
				if Colour == 1
				{
					palette_handle_range(PalPrimary,   0, 3, 1, 2, 19);
					palette_handle_range(PalSecondary, 0, 3, 1, 2, 19);
				}
				if Colour > 1
				{
					palette_handle_range(PalPrimary,   0, 3, 6, 6, 4);
					palette_handle_range(PalSecondary, 0, 3, 6, 6, 4);
				}
			}
					
			// Super form
			else if Player.SuperState == 2
			{
				if Colour < 7
				{
					palette_set_colour_range(PalPrimary,   0, 3, 7);
					palette_set_colour_range(PalSecondary, 0, 3, 7);
				}
				palette_handle_range(PalPrimary,   0, 3, 16, 7, 8);
				palette_handle_range(PalSecondary, 0, 3, 16, 7, 8);
			}
		}
		break;
		
		// Tails palette
		case CharTails:
		{
			// Get current colour
			var Colour = palette_get_colour(PalPrimary, 4);
				
			// Regular form
			if !Player.SuperState
			{	
				if Colour == 1
				{
					palette_set_colour_range(PalPrimary,   4, 7, 1);
					palette_set_colour_range(PalSecondary, 4, 7, 1);
				}
				else
				{			
					palette_handle_range(PalPrimary,   4, 7, 6, 1, 12);
					palette_handle_range(PalSecondary, 4, 7, 6, 1, 12);
				}
			}
				
			// Super form
			else
			{
				if Colour == 1
				{
					palette_handle_range(PalPrimary,   4, 7, 1, 2, 28);
					palette_handle_range(PalSecondary, 4, 7, 1, 2, 28);
				}
				if Colour > 1
				{
					palette_handle_range(PalPrimary,   4, 7, 7, 2, 12);
					palette_handle_range(PalSecondary, 4, 7, 7, 2, 12);
				}
			}
		}
		break;
		case CharKnuckles:
		{
			// Get current colour
			var Colour = palette_get_colour(PalPrimary, 8);
				
			// Regular form
			if !Player.SuperState
			{
				if Colour == 1
				{
					palette_set_colour_range(PalPrimary,   8, 10, 1);
					palette_set_colour_range(PalSecondary, 8, 10, 1);
				}
				else
				{			
					palette_handle_range(PalPrimary,   8, 10, 11, 1, 3);
					palette_handle_range(PalSecondary, 8, 10, 11, 1, 3);	
				}
			}
			
			// Super form
			else
			{
				if Colour == 1
				{
					palette_handle_range(PalPrimary,   8, 10, 1, 2, 17);
					palette_handle_range(PalSecondary, 8, 10, 1, 2, 17);
				}
				if Colour == 2
				{
					palette_handle_range(PalPrimary,   8, 10, 2, 3, 15);
					palette_handle_range(PalSecondary, 8, 10, 2, 3, 15);
				}
				if Colour > 2
				{
					palette_handle_range(PalPrimary,   8, 10, 11, 2, 3);
					palette_handle_range(PalSecondary, 8, 10, 11, 2, 3);
				}
			}		
		}
		break;
	}
}