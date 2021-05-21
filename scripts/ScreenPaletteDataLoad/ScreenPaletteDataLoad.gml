function ScreenPaletteDataLoad()
{	
	// Check current room/scene
	switch room 
	{	
		// Load palettes for MQZ
		case MQZ1:
		case MQZ2:
		{
			palette_load(PaletteSurface,    pal_Dry_MQZ);
			palette_load(PaletteUnderwater, pal_Wet_MQZ);
		}
		break;
		
		// Disable palettes for other rooms
		default:
		{
			palette_load(PaletteSurface,    false);
			palette_load(PaletteUnderwater, false);
		}
		break;
	}
}