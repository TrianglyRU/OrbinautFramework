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
					palette_updt_colour(PalPrimary, 0, 1, 21, 4);
				}
			}
			
			// Super form
			else
			{
				if Colour == 1
				{
					palette_updt_colour(PalPrimary, 0, 1, 2, 19);
				}
				else if Colour < 7
				{
					palette_updt_colour(PalPrimary, 0, 6, 7, 4);
				}
				else
				{
					palette_updt_colour(PalPrimary, 0, 7, 16, 8);
				}
			}
			
			// Sync other colours
			palette_sync_colour(PalPrimary,   1, 3, PalPrimary, 0);
			palette_sync_colour(PalSecondary, 0, 3, PalPrimary, 0);
		}
		break;
		case CharTails:
		{
			// Get colour
			var Colour = palette_get_colour(PalPrimary, 4);
			
			// Regular form
			if !Player.SuperState
			{	
				if Colour > 1
				{
					palette_updt_colour(PalPrimary, 4, 1, 7, 12);
				}
			}
				
			// Super form
			else
			{
				if Colour == 1
				{
					palette_updt_colour(PalPrimary, 4, 1, 2, 28);
				}
				else
				{
					palette_updt_colour(PalPrimary, 4, 2, 7, 12);
				}
			}
			
			// Sync other colours
			palette_sync_colour(PalPrimary,   5, 5, PalPrimary, 4);
			palette_sync_colour(PalPrimary,   9, 9, PalPrimary, 4);
			palette_sync_colour(PalSecondary, 4, 5, PalPrimary, 4);
			palette_sync_colour(PalSecondary, 9, 9, PalPrimary, 4);
		}
		break;
		case CharKnuckles:
		{	
			// Get colour
			var Colour = palette_get_colour(PalPrimary, 6);
			
			// Regular form
			if !Player.SuperState
			{
				if Colour > 1
				{
					palette_updt_colour(PalPrimary, 6, 1, 11, 3);
				}
			}
			
			// Super form
			else
			{
				if Colour == 1
				{
					palette_updt_colour(PalPrimary, 6, 1, 2, 17);
				}
				else if Colour == 2
				{
					palette_updt_colour(PalPrimary, 6, 2, 3, 15);
				}
				else
				{
					palette_updt_colour(PalPrimary, 6, 2, 11, 3);
				}
			}
			
			// Sync other colours
			palette_sync_colour(PalPrimary,   7, 8, PalPrimary, 6);
			palette_sync_colour(PalSecondary, 6, 8, PalPrimary, 6);
		}
		break;
	}
}