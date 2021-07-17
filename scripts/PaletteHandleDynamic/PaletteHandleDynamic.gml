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
				// Regular
				case -1:
				{
					for (var i = 0; i <= 3; i++) 
					{
						palette_handle(PaletteSurface, i, 1, 1, 1);
						palette_handle(PaletteUnderwater, i, 1, 1, 1);
					}
				}
				break;
				
				// Super start
				case 1:
				{		
					for (var i = 0; i <= 3; i++) 
					{
						palette_handle(PaletteSurface, i, 2, 6, 4);
						palette_handle(PaletteUnderwater, i, 2, 6, 4);
					}
				}
				break;
				
				// Super active
				case 2:
				{
					for (var i = 0; i <= 3; i++) 
					{
						palette_handle(PaletteSurface, i, 8, 10, 4);
						palette_handle(PaletteUnderwater, i, 8, 10, 4);
					}
				}
				break;
				
				// Super end
				case 0:
				{
					for (var i = 0; i <= 3; i++) 
					{
						palette_handle(PaletteSurface, i, 18, 5, 8);
						palette_handle(PaletteUnderwater, i, 18, 5, 8);
					}
				}
				break;
			}
		}
		
		// Tails palette
		if Player.CharacterID == CharTails
		{
			switch Player.SuperState
			{
				// Regular
				case -1:
				{
					
					for (var i = 4; i <= 6; i++) 
					{
						palette_handle(PaletteSurface, i, 1, 1, 1);
						palette_handle(PaletteUnderwater, i, 1, 1, 1);
					}
				}
				break;
				
				// Super start / super active
				case 1:
				case 2:
				{
					for (var i = 4; i <= 6; i++) 
					{
						palette_handle(PaletteSurface, i, 2, 6, 10);
						palette_handle(PaletteUnderwater, i, 2, 6, 10);
					}
				}
				break;
				
				// Super end
				case 0:
				{
					for (var i = 4; i <= 6; i++) 
					{
						palette_handle(PaletteSurface, i, 5, 4, 10);
						palette_handle(PaletteUnderwater, i, 5, 4, 10);
					}
				}
				break;
			}
		}
		
		// Knuckles palette
		if Player.CharacterID == CharKnuckles
		{
			switch Player.SuperState
			{
				// Regular
				case -1:
				{
					for (var i = 8; i <= 10; i++) 
					{
						palette_handle(PaletteSurface, i, 1, 1, 1);
						palette_handle(PaletteUnderwater, i, 1, 1, 1);
					}
				}
				break;
				
				// Super start
				case 1:
				{		
					for (var i = 8; i <= 10; i++) 
					{
						palette_handle(PaletteSurface, i, 2, 8, 3);
						palette_handle(PaletteUnderwater, i, 2, 8, 3);
					}
				}
				break;
				
				// Super active
				case 2:
				{
					for (var i = 8; i <= 10; i++) 
					{
						palette_handle(PaletteSurface, i, 10, 15, 3);
						palette_handle(PaletteUnderwater, i, 10, 15, 3);
					}
				}
				break;
				
				// Super end
				case 0:
				{
					for (var i = 8; i <= 10; i++) 
					{
						palette_handle(PaletteSurface, i, 25, 5, 8);
						palette_handle(PaletteUnderwater, i, 25, 5, 8);
					}
				}
				break;
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
			// Surface dynamic
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
			palette_handle(PaletteUnderwater, 59, 1, 8, 6);
		}
		break;
	}
}