function ScreenPaletteHandleDynamic()
{	
	// Exit if paused
	if Stage.GamePaused
	{
		exit;
	}

	// Player palette shift
	if instance_exists(Player)
	{
		if Player.isSuper
		{
			switch Player.CharacterID
			{
				// Super Sonic palette shift
				case CharSonic:
				{
					// Surface
					for (var i = 0; i < 4; i++) 
					{
						palette_handle(PaletteSurface, i, 0, 8, 3);
					}
						
					// Underwater
					for (var i = 13; i < 17; i++) 
					{
						palette_handle(PaletteUnderwater, i, 0, 3, 3);
					}
				}
				break;
			
				// Super Tails palette shift
				case CharTails:
				{
					// Surface
					for (var i = 4; i < 7; i++) 
					{
						palette_handle(PaletteSurface, i, 0, 4, 3);
					}
				}
				break;
			
				// Super Knuckles palette shift
				case CharKnuckles:
				{
					// Surface
					for (var i = 7; i < 10; i++) 
					{
						palette_handle(PaletteSurface, i, 0, 10, 3);
					}
				}
				break;
			}
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
				palette_handle(PaletteSurface, i, 0, 8, 3);
			}
			palette_handle(PaletteSurface, 18, 0, 8, 6);
			
			// Underwater
			for (var i = 24; i < 31; i++)
			{
				palette_handle(PaletteUnderwater, i, 0, 8, 3);
			}
			palette_handle(PaletteUnderwater, 32, 0, 8, 6);
		}
		break;
	}
}