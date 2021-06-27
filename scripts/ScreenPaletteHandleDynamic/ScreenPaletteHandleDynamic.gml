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
		if Player.isSuper
		{
			// Surface superform
			for (var i = 0; i < 4; i++) 
			{
				palette_handle(PaletteSurface, i, 2, 8, 3);
			}
				
			// Underwater superform
			for (var i = 9; i < 13; i++) 
			{
				palette_handle(PaletteUnderwater, i, 2, 8, 3);
			}
		}
		else
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