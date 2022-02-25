function PlayerSuperPalettesProcess()
{
	switch global.Character
	{
		case CharSonic:
		{
			// Get colour
			var Colour = palette_get_colour(PalPrimary, 0);
			
			// Regular form
			if !Player.SuperState
			{
				if Colour > 1
				{
					if Colour < 17
					{
						palette_set_colour(PalPrimary, 0, 17);
					}	
					palette_update_colour(PalPrimary, 0, 21, 1, 4);
				}
			}
			
			// Super form
			else
			{
				if Colour == 1
				{
					palette_update_colour(PalPrimary, 0, 1, 2, 19);
				}
				else if Colour < 7
				{
					palette_update_colour(PalPrimary, 0, 6, 7, 4);
				}
				else
				{
					palette_update_colour(PalPrimary, 0, 16, 7, 8);
				}
			}
			
			// Sync other colours
			var Colour = palette_get_colour(PalPrimary, 0);
			
			palette_set_colour_range(PalPrimary,   1, 3, Colour);
			palette_set_colour_range(PalSecondary, 0, 3, Colour);
		}
		break;
		case CharTails:
		{
			// Get colour
			var Colour = palette_get_colour(PalPrimary, 4);
			
			// Regular form
			if !Player.SuperState
			{	
				var Colour = palette_get_colour(PalPrimary, 4);
				if  Colour > 1
				{
					palette_update_colour(PalPrimary, 4, 7, 1, 12);
				}
			}
				
			// Super form
			else
			{
				if Colour == 1
				{
					palette_update_colour(PalPrimary, 4, 1, 2, 28);
				}
				else
				{
					palette_update_colour(PalPrimary, 4, 7, 2, 12);
				}
			}
			
			// Sync other colours
			var Colour = palette_get_colour(PalPrimary, 4);
			
			palette_set_colour(PalPrimary,			  5, Colour);
			palette_set_colour(PalPrimary,            9, Colour);
			palette_set_colour(PalSecondary,          9, Colour);
			palette_set_colour_range(PalSecondary, 4, 5, Colour);
		}
		break;
		case CharKnuckles:
		{	
			// Get colour
			var Colour = palette_get_colour(PalPrimary, 6);
			
			// Regular form
			if !Player.SuperState
			{
				if  Colour > 1
				{
					palette_update_colour(PalPrimary, 6, 11, 1, 3);
				}
			}
			
			// Super form
			else
			{
				if Colour == 1
				{
					palette_update_colour(PalPrimary, 6, 1, 2, 17);
				}
				else if Colour == 2
				{
					palette_update_colour(PalPrimary, 6, 2, 3, 15);
				}
				else
				{
					palette_update_colour(PalPrimary, 6, 11, 2, 3);
				}
			}
			
			// Sync other colours
			var Colour = palette_get_colour(PalPrimary, 6);
			
			palette_set_colour_range(PalPrimary,   7, 8, Colour);
			palette_set_colour_range(PalSecondary, 7, 8, Colour);
		}
		break;
	}
}