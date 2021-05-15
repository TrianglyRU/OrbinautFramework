function ScreenPaletteDataLoad()
{	
	// Check current room/scene
	switch room 
	{		
		// Load palette for GVZ
		case GVZ:
		case GVZ2:
		{
			palette_load(PaletteSurface,	pal_GVZ_Dynamic);
			palette_load(PaletteUnderwater, pal_GVZ_Wet);
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