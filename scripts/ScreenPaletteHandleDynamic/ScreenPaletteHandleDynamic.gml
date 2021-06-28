function ScreenPaletteHandleDynamic()
{	
	// Exit if paused
	if Stage.GamePaused
	{
		exit;
	}
	
	// Player palette shift
	if instance_exists(Player) and Player.CharacterID == CharSonic
	{	
		switch Player.SuperState
		{
			case false:
			{
				// Surface regular
				for (var i = 0; i < 4; i++) 
				{
					palette_handle(PaletteSurface, i, 1, 1, 1);
				}
			
				// Underwater regular
				for (var i = 9; i < 13; i++) 
				{
					palette_handle(PaletteUnderwater, i, 1, 1, 1);
				}
			}
			break;
			case SuperStart:
			{
				// Surface super start
				for (var i = 0; i < 4; i++) 
				{
					palette_handle(PaletteSurface, i, 1, 6, 3);
				}
			}
			break;
			case SuperActive:
			{
				// Surface super active
				for (var i = 0; i < 4; i++) 
				{
					palette_handle(PaletteSurface, i, 7, 8, 3);
				}
			}
			break;
			case SuperEnd:
			{
				// Surface super end
				for (var i = 0; i < 4; i++) 
				{
					palette_handle(PaletteSurface, i, 15, 6, 3);
				}
			}
			break;
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