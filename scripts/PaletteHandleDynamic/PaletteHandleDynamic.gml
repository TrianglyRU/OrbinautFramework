function PaletteHandleDynamic()
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
			switch Player.SuperState
			{
				case -1:
				{
					// Regular
					for (var i = 0; i < 4; i++) 
					{
						palette_handle(PaletteSurface, i, 1, 1, 1);
						palette_handle(PaletteUnderwater, i, 1, 1, 1);
					}
				}
				break;
				case 1:
				{
					// Super start
					for (var i = 0; i < 4; i++) 
					{
						palette_handle(PaletteSurface, i, 2, 6, 4);
						palette_handle(PaletteUnderwater, i, 2, 6, 4);
					}
				}
				break;
				case 2:
				{
					// Super active
					for (var i = 0; i < 4; i++) 
					{
						palette_handle(PaletteSurface, i, 8, 10, 4);
						palette_handle(PaletteUnderwater, i, 8, 10, 4);
					}
				}
				break;
				case 0:
				{
					// Super end
					for (var i = 0; i < 4; i++) 
					{
						palette_handle(PaletteSurface, i, 18, 6, 4);
						palette_handle(PaletteUnderwater, i, 18, 6, 4);
					}
				}
				break;
			}
		}
		
		// Tails palette
		if Player.CharacterID == CharTails
		{
			if !Player.SuperState
			{
				// Regular
				for (var i = 4; i < 7; i++) 
				{
					palette_handle(PaletteSurface, i, 1, 1, 1);
					palette_handle(PaletteUnderwater, i, 1, 1, 1);
				}
			}
			else
			{
				// Super active
				for (var i = 4; i < 7; i++) 
				{
					palette_handle(PaletteSurface, i, 1, 6, 6);
					palette_handle(PaletteUnderwater, i, 1, 6, 6);
				}
			}
		}
		
		// Knuckles palette
		
		// General underwater
		for (var i = 10; i < 17; i++)
		{
			palette_handle(PaletteUnderwater, i, 1, 1, 1);
		}
	}
	
	// Stage palette shift
	switch room
	{
		case MQZ1:
		case MQZ2:
		{
			// Surface
			for (var i = 10; i < 18; i++)
			{
				palette_handle(PaletteSurface, i, 1, 8, 3);
			}
			palette_handle(PaletteSurface, 18, 1, 8, 6);
			
			// Underwater
			for (var i = 24; i < 31; i++)
			{
				palette_handle(PaletteUnderwater, i, 1, 8, 3);
			}
			palette_handle(PaletteUnderwater, 32, 1, 8, 6);
		}
		break;
	}
}